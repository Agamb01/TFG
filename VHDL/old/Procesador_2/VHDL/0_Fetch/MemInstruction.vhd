----------------------------------------------------------------------------------
-- Company: Universidad Complutense de Madrid
-- Engineer: Andres Gamboa Melendez
-- 
-- Create Date: 12:05:02 11/12/2014 
-- Design Name: Modulo Memoria de instrucciones
-- Module Name: MemInstruction - Behavioral 
-- Project Name: ARM compatible micro-processor
-- Target Devices: Nexys4
-- Tool versions: Xilinx ISE Webpack 14.4
-- Description: Recibe una dirección y devuelve la instruccion situada en esa 
--              direccion.
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;



--TODO: Completar

entity MemInstruction is
   Port (
      in_pc : in  STD_LOGIC_VECTOR (31 downto 0);
      out_instruction : out  STD_LOGIC_VECTOR (31 downto 0) 
   );
end MemInstruction;

architecture Behavioral of MemInstruction is

begin

  out_instruction <= (in_pc);
  
end Behavioral;

