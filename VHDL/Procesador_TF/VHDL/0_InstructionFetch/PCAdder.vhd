----------------------------------------------------------------------------------
-- Company: Universidad Complutense de Madrid
-- Engineer: Andrés Gamboa Meléndez
-- 
-- Module Name: PCAdder - Behavioral 
-- Project Name: ARM compatible micro-processor
-- Target Devices: Nexys4
-- Tool versions: Xilinx ISE Webpack 14.4
-- Description: Suma 4 a una señal de entrada de 32 bits
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


entity PCAdder is
   Generic(
      size : INTEGER := 32
   );
   Port ( 
      in_pc : in  STD_LOGIC_VECTOR (size-1 downto 0);
      out_pc : out  STD_LOGIC_VECTOR (size-1 downto 0)
   );
end PCAdder;

architecture Behavioral of PCAdder is
--constant four : STD_LOGIC_VECTOR(size-1 downto 0) := "00000000000000000000000000000100";

begin

   process(in_pc)
   begin
      out_pc <= std_logic_vector(signed(in_pc)+4);
   end process;
  
end Behavioral;

