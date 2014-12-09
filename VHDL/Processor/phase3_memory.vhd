----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:19:11 12/08/2014 
-- Design Name: 
-- Module Name:    phase3_memory - Behavioral 
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

entity phase3_memory is
    Port ( clk, rst   : in  STD_LOGIC;
           in_ALUbus  : in  STD_LOGIC_VECTOR (31 downto 0);
           in_busB    : in  STD_LOGIC_VECTOR (31 downto 0);
           out_MEMbus : out  STD_LOGIC_VECTOR (31 downto 0));
end phase3_memory;

architecture Behavioral of phase3_memory is

begin


end Behavioral;

