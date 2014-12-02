----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:50:36 12/01/2014 
-- Design Name: 
-- Module Name:    ExtensioSigno - Behavioral 
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

entity ExtensioSigno is
   Port ( 
      in_instruction : in  STD_LOGIC_VECTOR (31 downto 0);
      out_entero : out STD_LOGIC_VECTOR(31 downto 0)
   );
end ExtensioSigno;

architecture Behavioral of ExtensioSigno is

   signal s_ctr_move : STD_LOGIC; -- Indica si es una operación MOVE

begin

---------Entero---------                                    --TODO: Revisar

--Operacion move si in_instruction(25 dwonto 22)="10X1"
   s_ctr_move <= (not in_instruction(24)) and (in_instruction(25) and in_instruction(22));

   p_integer: process(in_instruction, s_ctr_move)
   begin
      out_entero(7 downto 0) <= in_instruction(7 downto 0);
      out_entero(10 downto 8) <= in_instruction(14 downto 12);
      out_entero(11) <= in_instruction(26);
      if s_ctr_move='0' then
         out_entero(31 downto 12) <= (others=>in_instruction(26));
      else
         out_entero(15 downto 12) <= in_instruction(19 downto 16);
         out_entero(31 downto 16) <= (others=>in_instruction(19));
      end if;           
   end process;
---------Entero---------


end Behavioral;

