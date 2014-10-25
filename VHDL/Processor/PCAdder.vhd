----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11:13:31 10/17/2014 
-- Design Name: 1
-- Module Name: PCAdder - Behavioral 
-- Project Name: ARM compatible micro-processor
-- Target Devices: Nexys4
-- Tool versions: Xilinx ISE Webpack 14.4
-- Description: Sumador de 32 bit
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
    Port ( PC_in : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_out : out  STD_LOGIC_VECTOR (31 downto 0));
end PCAdder;

architecture Behavioral of PCAdder is
constant four : STD_LOGIC_VECTOR(31 downto 0) := "00000000000000000000000000000100";

signal Gen: STD_LOGIC_VECTOR (31 downto 0);
signal Pro: STD_LOGIC_VECTOR (31 downto 0);
signal Carry: STD_LOGIC_VECTOR (32 downto 0);

begin

  Gen <= PC_in and four;
  Pro <= PC_in xor four;
  
  Add: process(Gen, Pro, Carry)
  begin
    Carry(0) <= '0';
    For i in 1 to 32 loop
      Carry(i) <= Gen(i-1) or (Pro(i-1) 
                           and Carry(i-1));
    End loop;  
  end process;

process(Pro, Carry)
begin
  PC_out <= Pro xor Carry(31 downto 0);
end process;
--Cout <= Carry(32);
end Behavioral;

