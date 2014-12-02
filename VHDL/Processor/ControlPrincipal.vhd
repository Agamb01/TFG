----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Andres Gamboa 
-- 
-- Create Date:    17:41:47 12/01/2014 
-- Design Name: 
-- Module Name:    ControlPrincipal - Behavioral 
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

entity ControlPrincipal is
   Port ( 
      in_instruction : in  STD_LOGIC_VECTOR(31 downto 0);
      out_WB_control : out STD_LOGIC_VECTOR(11 downto 0);
      out_MEM_control : out STD_LOGIC_VECTOR(9 downto 0);
      out_EXE_control : out STD_LOGIC_VECTOR(9 downto 0)
   );
end ControlPrincipal;

architecture Behavioral of ControlPrincipal is

begin

   out_WB_control <= in_instruction(31 downto 20);
   out_MEM_control <= in_instruction(19 downto 10);
   out_EXE_control <= in_instruction(9 downto 0);

end Behavioral;

