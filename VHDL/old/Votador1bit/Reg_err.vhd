----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:44:18 01/15/2015 
-- Design Name: 
-- Module Name:    Reg_err - Behavioral 
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

entity Reg_err is
   Generic (
      size : INTEGER := 32
   );
   Port (
      clk, rst : in STD_LOGIC;
      in_enable : in STD_LOGIC;
      in_data : in STD_LOGIC_VECTOR(size-1 downto 0);
      in_force : in STD_LOGIC_VECTOR(2 downto 0);
      out_data : out  STD_LOGIC_VECTOR (size-1 downto 0)
   );
end Reg_err;

architecture Behavioral of Reg_err is

   signal s_set : STD_LOGIC; -- Fuerza el valor a 1
   signal s_reset : STD_LOGIC; -- Fuerza el valor a 0
   signal s_switch : STD_LOGIC; -- Invierte el valor del dato de entrada

   signal s_reg : STD_LOGIC_VECTOR(size-1 downto 0); -- Señal registro 

begin

   out_data <= s_reg;

   s_set <= in_force(2);
   s_reset <= in_force(1);
   s_switch <= in_force(0);

   -- Proceso principal, registro con reset asíncrono
   process(clk, rst)
   begin
      if rst='0' then
         s_reg <= (others => '0');
      elsif rising_edge(clk) then
         if in_enable='1' then
            if s_set='1' then
               s_reg <= (others=>'1');
            elsif s_reset='1' then
               s_reg <= (others=>'0');
            elsif s_switch='1' then
               s_reg <= not in_data;
            else
               s_reg <= in_data;
            end if;
         end if;
      end if;
   end process;

end Behavioral;

