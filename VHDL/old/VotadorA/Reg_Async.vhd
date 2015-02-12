----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Andrés Gamboa Meléndez
-- 
-- Create Date:    11:57:41 11/24/2014 
-- Design Name: 
-- Module Name:    register - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Registro con reset asíncrono
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

entity Reg_Async is
   Generic (
      size : INTEGER := 32
   );
   Port (
      clk, rst : in STD_LOGIC;
      enable : in STD_LOGIC;
      in_data : in STD_LOGIC_VECTOR(size-1 downto 0);
      out_data : out  STD_LOGIC_VECTOR (size-1 downto 0)
   );
end Reg_Async;

architecture Behavioral of Reg_Async is

   signal s_reg : STD_LOGIC_VECTOR(size-1 downto 0); -- Señal registro 

begin

   out_data <= s_reg;

   -- Proceso principal, registro con reset asíncrono
   process(clk, rst)
   begin
      if rst='0' then
         s_reg <= (others => '0');
      elsif rising_edge(clk) then
         if enable='1' then
            s_reg <= in_data;
         end if;
      end if;
   end process;

end Behavioral;

