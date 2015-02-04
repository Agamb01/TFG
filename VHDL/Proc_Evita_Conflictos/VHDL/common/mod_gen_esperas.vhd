----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:57:04 02/04/2015 
-- Design Name: 
-- Module Name:    mod_gen_esperas - Behavioral 
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

library work;
   use work.my_package.all;
   
entity mod_gen_esperas is
    Port ( in_pc          : in  STD_LOGIC_VECTOR (31 downto 0);
           out_paradas    : out  tipo_paradas;
           out_nula       : out  STD_LOGIC;
           out_valid_data : out  STD_LOGIC);
end mod_gen_esperas;

architecture Behavioral of mod_gen_esperas is

begin

   out_paradas <= (others => (others => '0'));
   out_nula <= '0';
   out_valid_data <= '0';
   
end Behavioral;

