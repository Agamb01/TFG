-------------------------------------------------------------------------------
-- Company: 
-- Engineer:         Andrés Gamboa Meléndez
-- 
-- Create Date:      11:13:31 10/17/2014 
-- Design Name:      Procesador_TF
-- Module Name:      BrAdder - Behavioral 
-- Project Name:     Procesador tolerante a fallos transitorios
--                     compatible con ARM a nivel de instrucciones
-- Target Devices:   Digilent Nexys 4 - Artix 7 FPGA
-- Tool versions:    Xilinx ISE 14.4 (nt64)
-- Description:      Sumador de 32 bit, suma dos entradas
--
-- Dependencies:     
--
-- Additional Comments: 
--
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;



-------------------------------------------------------------------------------
--                                 BRAdder                                   --
-------------------------------------------------------------------------------
-- Suma dos operandos de entrada
--


entity BrAdder is
   Generic (
      op_size : INTEGER := 32
   );
   Port ( 
      in_A    : in  STD_LOGIC_VECTOR (op_size-1 downto 0);
      in_B    : in  STD_LOGIC_VECTOR (op_size-1 downto 0);
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

