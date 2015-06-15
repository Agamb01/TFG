----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:24:54 02/11/2015 
-- Design Name: 
-- Module Name:    Sistema_Tolerancia_2 - Behavioral 
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

entity Registro_TF is
   Generic (
      size     : INTEGER := 32
   );
   Port ( 
      clk, rst : in STD_LOGIC;
      dato_in  : in STD_LOGIC_VECTOR (size-1 downto 0);
      dato_out : out STD_LOGIC_VECTOR (size-1 downto 0)
   );
end Registro_TF;

architecture Behavioral of Registro_TF is

   constant N_Tolerancia : integer := 3;    
   type array_regs is array (0 to N_Tolerancia-1) of STD_LOGIC_VECTOR (size-1 downto 0);

   signal regs : array_regs;

begin

   -- Registro triplicado
   p_regs: process (clk, rst)
   begin
      if rst='0' then
         for i in 0 to N_Tolerancia-1 loop -- Para cada registro
            regs(i) <= (others=>'0');
         end loop;
      elsif rising_edge(clk) then
         for i in 0 to N_Tolerancia-1 loop -- Para cada registro
            regs(i) <= dato_in;
         end loop;
      end if;
   end process;
   
   -- Votador:
   dato_out <= (regs(0) and regs(1)) or (regs(0) and regs(2)) or (regs(1) and regs(2)); 

end Behavioral;

