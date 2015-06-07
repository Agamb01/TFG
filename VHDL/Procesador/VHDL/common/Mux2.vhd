----------------------------------------------------------------------------------
-- Company: Universidad Complutense de Madrid
-- Engineer: Andres Gamboa Melendez
-- 
-- Module Name: Mux2 - Behavioral 
-- Project Name: ARM compatible micro-processor
-- Target Devices: Nexys4
-- Tool versions: Xilinx ISE Webpack 14.4
-- Description: Multiplexor de dos entradas
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

entity Mux2 is
   Generic (
      size : INTEGER := 32
   );
   Port ( 
      in_0 : in STD_LOGIC_VECTOR (size-1 downto 0);
      in_1 : in STD_LOGIC_VECTOR (size-1 downto 0);
      sel : in STD_LOGIC;
      out_0 : out STD_LOGIC_VECTOR (size-1 downto 0)
   );
end Mux2;

architecture Behavioral of Mux2 is

begin

-- Proceso principal, selecciona 
p_mux: process(in_0, in_1, sel)
	begin
		if sel='1' then
         out_0 <= in_1;
      else
         out_0 <= in_0;
      end if;
   end process;
end Behavioral;

