----------------------------------------------------------------------------------
-- Company: Universidad Complutense de Madrid
-- Engineer: Andres Gamboa Melendez
-- 
-- Create Date: 11:13:31 10/17/2014 
-- Design Name: Modulo Sumador de contador de programa
-- Module Name: PCAdder - Behavioral 
-- Project Name: ARM compatible micro-processor
-- Target Devices: Nexys4
-- Tool versions: Xilinx ISE Webpack 14.4
-- Description: Suma 4 a una señal de entrada de 32 bits
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
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

--http://www.academia.edu/253031/Design_and_Implementation_of_a_Fast_Unsigned_32-bit_Multiplier_Using_VHDL

entity PCAdder is
   Generic(
      size : INTEGER := 32
   );
   Port ( 
      in_pc : in  STD_LOGIC_VECTOR (size-1 downto 0);
      out_pc : out  STD_LOGIC_VECTOR (size-1 downto 0)
   );
end PCAdder;

architecture Behavioral of PCAdder is
constant four : STD_LOGIC_VECTOR(size-1 downto 0) := "00000000000000000000000000000100";

signal Gen: STD_LOGIC_VECTOR (size-1 downto 0);
signal Pro: STD_LOGIC_VECTOR (size-1 downto 0);
signal Carry: STD_LOGIC_VECTOR ((size) downto 0);

begin

  Gen <= in_pc and four;
  Pro <= in_pc xor four;

   Add: process(Gen, Pro, Carry)
   begin
      Carry(0) <= '0';
      For i in 1 to size loop
         Carry(i) <= Gen(i-1) or (Pro(i-1) 
                           and Carry(i-1));
      End loop;  
   end process;

   process(Pro, Carry)
   begin
      out_pc <= Pro xor Carry(size-1 downto 0);
   end process;
--Cout <= Carry(size);
end Behavioral;

