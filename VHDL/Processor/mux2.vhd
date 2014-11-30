----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:34:18 11/27/2014 
-- Design Name: 
-- Module Name:    mux - Behavioral 
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

entity mux2 is
   Generic (
      size : INTEGER := 32
   );
   Port ( 
      in_A : in STD_LOGIC_VECTOR (size-1 downto 0);
      in_B : in STD_LOGIC_VECTOR (size-1 downto 0);
      sel : in STD_LOGIC;
      out_C : out STD_LOGIC_VECTOR (size-1 downto 0)
   );
end mux2;

architecture Behavioral of mux2 is

begin

p_mux: process(in_A, in_B, sel)
	begin
		if sel='1' then
         out_C <= in_B;
      else
         out_C <= in_A;
      end if;
   end process;
end Behavioral;

