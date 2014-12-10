----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11:13:31 10/17/2014 
-- Design Name: 1
-- Module Name: BrAdder - Behavioral 
-- Project Name: ARM compatible micro-processor
-- Target Devices: Nexys4
-- Tool versions: Xilinx ISE Webpack 14.4
-- Description: Sumador de 32 bit, suma dos entradas
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

entity BrAdder is
   Generic (
      op_size : INTEGER := 31
   );
   Port ( 
      in_A : in  STD_LOGIC_VECTOR (op_size downto 0);
      in_B : in  STD_LOGIC_VECTOR (op_size downto 0);
      out_res : out  STD_LOGIC_VECTOR (op_size downto 0)
   );
end BrAdder;

architecture Behavioral of BrAdder is

   signal Gen: STD_LOGIC_VECTOR (op_size downto 0);
   signal Pro: STD_LOGIC_VECTOR (op_size downto 0);
   signal Carry: STD_LOGIC_VECTOR (op_size+1 downto 0);

begin

  Gen <= in_A and in_B;
  Pro <= in_A xor in_B;
  
  Add: process(Gen, Pro, Carry)
  begin
    Carry(0) <= '0';
    For i in 1 to op_size+1 loop
      Carry(i) <= Gen(i-1) or (Pro(i-1) 
                           and Carry(i-1));
    End loop;  
  end process;

process(Pro, Carry)
begin
  out_res <= Pro xor Carry(op_size downto 0);
end process;
--Cout <= Carry(op_size+1);
end Behavioral;

