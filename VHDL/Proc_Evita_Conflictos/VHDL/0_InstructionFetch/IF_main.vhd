----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:25:00 01/07/2015 
-- Design Name: 
-- Module Name:    IF_main - Behavioral 
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

--    Contador de programa actual   

-- Salidas:
--    Array de paradas de esta instrucción
--    Bit de instrucción "NULA" actual
--    Enable para lógica de fase

--    Contador de programa siguiente
--    Instruccion correspondiente a PC actual

library work;
   use work.my_package.all;
   
entity IF_main is
   Port( 
      clk, rst       : in STD_LOGIC;
      in_paradas     : in tipo_paradas;
      in_nula        : in STD_LOGIC;
      out_paradas    : out tipo_paradas;
      out_nula       : out STD_LOGIC;
      out_valid_data : out STD_LOGIC;
      
      -- Contador de programa actual
      in_pc          : in std_logic_vector(31 downto 0);
      -- Contador de programa siguiente
      out_pc         : out std_logic_vector(31 downto 0);
      -- Instruccion correspondiente a PC actual
      out_inst       : out std_logic_vector(31 downto 0)
   );
end IF_main;

architecture Behavioral of IF_main is

-- Modulo que realiza el trabajo de la fase
   component Phase0_InstructionFetch is
      Generic (
         address_size : INTEGER := 32;
         inst_size : INTEGER := 32
      );
      Port (
      -- Entradas
         in_pc : in STD_LOGIC_VECTOR (address_size-1 downto 0); -- Direccion PC
      -- Salidas
         out_pc : out  STD_LOGIC_VECTOR (address_size-1 downto 0);   -- Valor de pc + 4
         out_inst : out  STD_LOGIC_VECTOR (inst_size-1 downto 0)  -- Valor de Instruccion en direccion PC
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
   
   
-- Modulo funcional de la fase IF
   i_pIF: Phase0_InstructionFetch 
      port map(
      -- Entradas
         in_pc => in_pc,
      -- Salidas
         out_pc => out_pc,
         out_inst => out_inst
      );
--


end Behavioral;

