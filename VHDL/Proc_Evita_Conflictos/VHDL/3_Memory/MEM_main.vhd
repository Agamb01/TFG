----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:22:54 01/25/2015 
-- Design Name: 
-- Module Name:    MEM_main - Behavioral 
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

--    Bus de datos, resultado de ALU
--    Bus de datos, segundo registro
--    Flags de comparacion de ALU

--    Señales de control para etapa de memoria:
--       bits[5:4] -> Condiciones para salto condicional
--       bits[3]   -> Salto condicional
--       bits[2]   -> Salto incondicional
--       bits[1]   -> Lectura de memoria
--       bits[0]   -> Escritura de memoria

-- Salidas:
--    Array de paradas de esta instrucción
--    Bit de instrucción "NULA" actual
--    Enable para lógica de fase

--    Bus de datos, datos obtenidos de memoria
--    Control de salto (PC_Src)

library work;
   use work.my_package.all;
   
entity MEM_main is
   Port (
      clk, rst       : in STD_LOGIC;
      in_paradas     : in tipo_paradas;
      in_nula        : in STD_LOGIC;
      out_paradas    : out tipo_paradas;
      out_nula       : out STD_LOGIC;
      out_valid_data : out STD_LOGIC;

      --Entradas (EXE->MEM)
      in_ALUbus  : in STD_LOGIC_VECTOR (31 downto 0);
      in_busB    : in STD_LOGIC_VECTOR (31 downto 0);
      in_flags   : in STD_LOGIC_VECTOR (1 downto 0);
      -- in_BRdir   : in STD_LOGIC_VECTOR (31 downto 0);

      --Salidas (MEM->WB) 
      out_MEMbus : out  STD_LOGIC_VECTOR (31 downto 0);

      --Salidas (MEM->Branch)
      -- out_BRdir  : out STD_LOGIC_VECTOR (31 downto 0);
      out_BRctr  : out STD_LOGIC;

      --Señales de control (ID->MEM)
      in_MEM_control : in STD_LOGIC_VECTOR(5 downto 0) 
      -- [5:2]=BRCond(Negative,Zero,Cond,Incond), [1]=MemRead, [0]=MemWrite

   );
end MEM_main;

architecture Behavioral of MEM_main is

-- Modulo que realiza el trabajo de la fase
   component Phase3_Memory is
      Port ( 
         clk, rst   : in STD_LOGIC;

         --Entradas (EXE->MEM)
         in_ALUbus  : in STD_LOGIC_VECTOR (31 downto 0);
         in_busB    : in STD_LOGIC_VECTOR (31 downto 0);
         in_flags   : in STD_LOGIC_VECTOR (1 downto 0);
         -- in_BRdir   : in STD_LOGIC_VECTOR (31 downto 0);

         --Salidas (MEM->WB) 
         out_MEMbus : out  STD_LOGIC_VECTOR (31 downto 0);

         --Salidas (MEM->Branch)
         -- out_BRdir  : out STD_LOGIC_VECTOR (31 downto 0);
         out_BRctr  : out STD_LOGIC;

         --Señales de control (ID->MEM)
         in_MEM_control : in STD_LOGIC_VECTOR(5 downto 0) 
            -- [5:2]=BRCond(Negative,Zero,Cond,Incond), [1]=MemRead, [0]=MemWrite
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
   i_pMEM: Phase3_Memory
      Port map (
         clk => clk, 
         rst => rst,

         --Entradas (EXE->MEM)
         in_ALUbus => in_ALUbus,
         in_busB   => in_busB,
         in_flags  => in_flags,

         --Salidas (MEM->WB) 
         out_MEMbus => out_MEMbus,

         --Salidas (MEM->Branch)
         out_BRctr  => out_BRctr,

         --Señales de control (ID->MEM)
         in_MEM_control => in_MEM_control
      );
--


end Behavioral;

