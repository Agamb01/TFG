----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:38:22 10/29/2014 
-- Design Name: 
-- Module Name:    RegisterBank - Behavioral 
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

entity RegisterBank is
   port ( RA : in STD_LOGIC_VECTOR(4 downto 0);
          RB : in STD_LOGIC_VECTOR(4 downto 0);
          RW : in STD_LOGIC_VECTOR(4 downto 0);  
          BusW : in STD_LOGIC_VECTOR(31 downto 0);
          busA : out STD_LOGIC_VECTOR(31 downto 0);
          busB : out STD_LOGIC_VECTOR(31 downto 0)
         );
end RegisterBank;

architecture Behavioral of RegisterBank is

begin


end Behavioral;

