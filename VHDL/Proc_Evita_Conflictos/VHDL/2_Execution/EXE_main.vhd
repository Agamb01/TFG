----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:47:54 01/22/2015 
-- Design Name: 
-- Module Name:    EXE_main - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- Entradas:
--    Clock de sistema
--    Reset de sistema
--    Array de paradas de la siguiente instrucción
--    Bit de instruccion "NULA" siguiente

--    Contador de programa para calcular direccion de salto
--    Entero sacado de la instruccion
--    Buses de datos de los registros seleccionados por la instruccion

--    Señales de control para etapa de ejecucion:
--       bits[3:1] -> ALU_op
--       bits[0]   -> ALU_ctr

-- Salidas:
--    Array de paradas de esta instrucción
--    Bit de instrucción "NULA" actual
--    Enable para lógica de fase

--    Direccion de salto calculada
--    Resultado de operacion calculado por la ALU
--    Flags de la operacion calculada por la ALU

library work;
   use work.my_package.all;
   
entity EXE_main is
   Port( 
      clk, rst       : in STD_LOGIC;
      in_paradas     : in tipo_paradas;
      in_nula        : in STD_LOGIC;
      out_paradas    : out tipo_paradas;
      out_nula       : out STD_LOGIC;
      out_valid_data : out STD_LOGIC;
      
      --Entradas (ID->EXE)
      in_PC          : in STD_LOGIC_VECTOR(31 downto 0);
      in_entero      : in STD_LOGIC_VECTOR(31 downto 0);
      in_busA        : in STD_LOGIC_VECTOR(31 downto 0);
      in_busB        : in STD_LOGIC_VECTOR(31 downto 0);
       
      --Salidas (EXE->MEM)
      out_PC_salto   : out STD_LOGIC_VECTOR(31 downto 0);
      out_ALU_bus    : out STD_LOGIC_VECTOR(31 downto 0);
      out_ALU_flags  : out STD_LOGIC_VECTOR(1 downto 0); -- Flags(N,Z)

      --Señales de control(ID->EXE)
      in_EXE_control : in STD_LOGIC_VECTOR(3 downto 0) -- [3:1]=ALUop, [0]=ALUsrc

   );
end EXE_main;

architecture Behavioral of EXE_main is

-- Modulo que realiza el trabajo de la fase
   component Phase2_Execution is
      port (  
         --Entradas (ID->EXE)
         in_PC          : in STD_LOGIC_VECTOR(31 downto 0);
         in_entero      : in STD_LOGIC_VECTOR(31 downto 0);
         in_busA        : in STD_LOGIC_VECTOR(31 downto 0);
         in_busB        : in STD_LOGIC_VECTOR(31 downto 0);
          
         --Salidas (EXE->MEM)
         out_PC_salto   : out STD_LOGIC_VECTOR(31 downto 0);
         out_ALU_bus    : out STD_LOGIC_VECTOR(31 downto 0);
         out_ALU_flags  : out STD_LOGIC_VECTOR(1 downto 0); -- Flags(N,Z)

         --Señales de control(ID->EXE)
         in_EXE_control : in STD_LOGIC_VECTOR(3 downto 0) -- [3:1]=ALUop, [0]=ALUsrc
      );
   end component;

   signal paradas_reg: tipo_paradas; -- Señales de cuantas paradas deben ejecutarse
   signal nula_reg: STD_LOGIC; -- Indica si la instrucción guardada en "NULA"

 --  signal s_enable : STD_LOGIC;
begin

   -- Si la instrucción actual es "NULA" o no necesita realizar ninguna parada, 
   -- carga valores para la siguiente instrucción
   p_carga: process(clk, rst)
   begin
      -- Si hay reset carga instrucción "NULA" 
      if rst = '0' then
         nula_reg <= '1';
      elsif rising_edge(clk) then
         -- Si la instrucción es "NULA" o no tiene que esperar, carga valores de entrada
         if (nula_reg = '1') or (unsigned(paradas_reg(0)) = 0) then
            paradas_reg(0 to Numero_Fases) <= in_paradas(0 to Numero_Fases);
            nula_reg <= in_nula;
         elsif (unsigned(paradas_reg(0)) > 0) then 
            paradas_reg(0) <= std_logic_vector( unsigned(paradas_reg(0)) - 1 );
         end if;
      end if;
   end process;
   
   p_salida: process(paradas_reg, nula_reg)
   begin
      out_paradas(0 to Numero_Fases-1) <= paradas_reg(1 to Numero_Fases);
      out_paradas(Numero_Fases) <= (others => '0');
      
      -- Se habilita el funcionamiento del modulo interno 
      -- si existe una instruccion valida
      -- out_enable <= 
       out_nula <= nula_reg;
   -- La instruccion se propaga solo si es el ultimo ciclo de la instruccion en esta fase
      if (nula_reg = '0') and (unsigned(paradas_reg(0)) = 0) then
         out_valid_data <= '1';
      else
         out_valid_data <= '0';
      end if;
   end process;
   
-- Modulo funcional de la fase ID
   i_pEXE: Phase2_Execution
      Port map (
         --Entradas (ID->EXE)
         in_PC => in_PC,
         in_entero => in_entero,
         in_busA => in_busA,
         in_busB => in_busB,
         
         --Salidas (EXE->MEM)
         out_PC_salto => out_PC_salto,
         out_ALU_bus => out_ALU_bus,
         out_ALU_flags => out_ALU_flags,

         --Señales de control(ID->EXE)
         in_EXE_control => in_EXE_control
      );
--


end Behavioral;

