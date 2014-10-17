----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:13:23 10/12/2014 
-- Design Name: 
-- Module Name:    MemInstruction - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MemInstruction is
    Port ( PC : in  STD_LOGIC_VECTOR (31 downto 0);
           Instruction : out  STD_LOGIC_VECTOR (31 downto 0));
end MemInstruction;

architecture Behavioral of MemInstruction is

begin

  Instruction <= (others => PC(31));

--  process(PC)
--  begin
--    if PC(31) = '0' then
--	   Instruction <= (others => '0');
--	 else
--	   Instruction <= (others => '1');
--	 end if;
--  end process;
  
end Behavioral;

