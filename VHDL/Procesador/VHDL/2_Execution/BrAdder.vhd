----------------------------------------------------------------------------------
-- Company: Universidad Complutense de Madrid
-- Engineer: Andres Gamboa Melendez
-- 
-- Module Name: BrAdder - Behavioral 
-- Project Name: ARM compatible micro-processor
-- Target Devices: Nexys4
-- Tool versions: Xilinx ISE Webpack 14.4
-- Description: Sumador de 32 bit, suma dos entradas
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

entity BrAdder is
   Generic (
      op_size : INTEGER := 32
   );
   Port ( 
      in_A : in  STD_LOGIC_VECTOR (op_size-1 downto 0);
      in_B : in  STD_LOGIC_VECTOR (op_size-1 downto 0);
      out_res : out  STD_LOGIC_VECTOR (op_size-1 downto 0)
   );
end BrAdder;

architecture Behavioral of BrAdder is

begin

   process(in_A, in_B)
   begin
      out_res <= std_logic_vector(signed(in_A)+signed(in_B));
   end process;

end Behavioral;

