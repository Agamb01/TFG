----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:57:29 01/15/2015 
-- Design Name: 
-- Module Name:    comparador - Behavioral 
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

entity comparador is
   Generic (
      size : INTEGER := 32
   );
   Port ( 
      A : in  STD_LOGIC_VECTOR(size-1 downto 0);
      B : in  STD_LOGIC_VECTOR(size-1 downto 0);
      Z : out  STD_LOGIC_VECTOR(size-1 downto 0)
   );
end comparador;

architecture Behavioral of comparador is

begin

   Z <= not (A xor B);

end Behavioral;

