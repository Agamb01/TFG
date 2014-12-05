----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:21:02 11/17/2014 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
   Port ( 
      -- Entradas
      in_BusA   : in  STD_LOGIC_VECTOR (31 downto 0);
      in_BusB   : in  STD_LOGIC_VECTOR (31 downto 0);
      in_op     : in  STD_LOGIC_VECTOR (0 downto 0);
      
      --Salidas
      out_flags : out  STD_LOGIC_VECTOR (0 downto 0);
      out_busO  : out  STD_LOGIC_VECTOR (31 downto 0)
   );
end ALU;

architecture Behavioral of ALU is

   constant zeros : std_logic_vector(31 downto 0) := (others =>'0');

   signal s_busO : STD_LOGIC_VECTOR (31 downto 0);
   signal s_flags : STD_LOGIC_VECTOR (0 downto 0);

begin

---------------------------------SUMA-RESTA---------------------------------
p_operation: process(in_BusA, in_BusB, in_op) 
   begin
      if in_op="0" then
         s_busO <= std_logic_vector(signed(in_BusA) + signed(in_BusB));
      else
         s_busO <= std_logic_vector(signed(in_BusA) - signed(in_BusB));
      end if;
   end process;
   out_busO <= s_busO;
---------------------------------SUMA-RESTA---------------------------------

---------------------------------Comparacion---------------------------------
p_flags: process(s_busO) 
   begin
      if signed(s_busO) = to_signed(0, s_busO'length) then
         s_flags <= "1";
      else
         s_flags <= "0";
      end if;
   end process;
   out_flags <= s_flags;
---------------------------------Comparacion---------------------------------

end Behavioral;

