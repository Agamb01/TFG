----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:43:24 02/09/2015 
-- Design Name: 
-- Module Name:    Sistema_Tolerancia - Behavioral 
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

entity Sistema_Tolerancia_PRE is
   Generic (
      size_data  : integer := 32;
      size_fallo : integer := 3;
      N          : integer := 3
   );
   Port ( 
      clk, rst     : in STD_LOGIC;
      forzar_fallo : in force_regs;
      data_in      : in STD_LOGIC_VECTOR (size_data-1 downto 0);
      data_out   : out STD_LOGIC_VECTOR (size_data-1 downto 0)
--      data_out_2   : out STD_LOGIC_VECTOR (size_data-1 downto 0)
   );
end Sistema_Tolerancia_PRE;

architecture Behavioral of Sistema_Tolerancia_PRE is

  -- type array_regs is array (0 to 2) of STD_LOGIC_VECTOR (size_fallo-1 downto 0);
   
   signal regs : array_regs;
   
--   signal A_reg : STD_LOGIC_VECTOR(size_data-1 downto 0);
--   signal B_reg : STD_LOGIC_VECTOR(size_data-1 downto 0);
--   signal C_reg : STD_LOGIC_VECTOR(size_data-1 downto 0);

begin

-- Insertar error antes de guardar en procesador

   p_regs: process (clk, rst)
   begin
      if rst='0' then
         regs <= (others=> (others=>'0') );
      elsif rising_edge(clk) then
         for i in 0 to N-1 loop
            case forzar_fallo(i) is -- "01N"
               when "000" =>
                  regs(i) <= data_in;
               when "001" =>
                  regs(i) <= not data_in;
               when "010" =>
                  regs(i) <= (others=>'1');
               when "100" =>
                  regs(i) <= (others=>'0');
               when others =>
                  regs(i) <= data_in;
            end case;
         end loop;
      end if;
   end process;
   
   data_out <= (regs(0) and regs(1)) or (regs(0) and regs(2)) or (regs(1) and regs(2)); 

--   p_reg_A: process (clk, rst)
--   begin
--      if rst='0' then
--         A_reg <= (others=>'0');
--      elsif rising_edge(clk) then
--         case forzar_fallo(0) is -- "01N"
--            when "000" =>
--               A_reg <= data_in;
--            when "001" =>
--               A_reg <= not data_in;
--            when "010" =>
--               A_reg <= (others=>'1');
--            when "100" =>
--               A_reg <= (others=>'0');
--            when others =>
--               A_reg <= data_in;
--         end case;
--      end if;   
--   end process;
--
--   p_reg_B: process (clk, rst)
--   begin
--      if rst='0' then
--         B_reg <= (others=>'0');
--      elsif rising_edge(clk) then
--         case forzar_fallo(1) is -- "01N"
--            when "000" =>
--               B_reg <= data_in;
--            when "001" =>
--               B_reg <= not data_in;
--            when "010" =>
--               B_reg <= (others=>'1');
--            when "100" =>
--               B_reg <= (others=>'0');
--            when others =>
--               B_reg <= data_in;
--         end case;
--      end if;   
--   end process;
--
--   p_reg_C: process (clk, rst)
--   begin
--      if rst='0' then
--         C_reg <= (others=>'0');
--      elsif rising_edge(clk) then
--         case forzar_fallo(2) is -- "01N"
--            when "000" =>
--               C_reg <= data_in;
--            when "001" =>
--               C_reg <= not data_in;
--            when "010" =>
--               C_reg <= (others=>'1');
--            when "100" =>
--               C_reg <= (others=>'0');
--            when others =>
--               C_reg <= data_in;
--         end case;
--      end if;   
--   end process;
--
--   data_out_2 <= (A_reg and B_reg) or (A_reg and C_reg) or (B_reg and C_reg); 

end Behavioral;

