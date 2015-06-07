----------------------------------------------------------------------------------
-- Company: Universidad Complutense de Madrid
-- Engineer: Andres Gamboa Melendez
-- 
-- Module Name: IF_main - Behavioral 
-- Project Name: ARM compatible micro-processor
-- Target Devices: Nexys4
-- Tool versions: Xilinx ISE Webpack 14.4
-- Description: Módulo principal de etapa "Instruction Fetch"
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
   
entity IF_main is
   Port( 
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

begin
   
-- Modulo funcional de la fase IF
   i_pIF: Phase0_InstructionFetch 
      port map(
      -- Entradas
         in_pc => in_pc,
      -- Salidas
         out_pc => out_pc,
         out_inst => out_inst
      );

end Behavioral;

