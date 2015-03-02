----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:55:37 02/28/2015 
-- Design Name: 
-- Module Name:    generador_fallos - Behavioral 
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

library work;
   use work.my_package.all;
   use work.IDs_regs_fallos.all;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity generador_fallos is
   Port ( 
      clk, rst : in  STD_LOGIC;
      fallo : out t_Fallo
   );
end generador_fallos;

architecture Behavioral of generador_fallos is

   -- Fallos
   constant num_fallos : integer := 15;
   type array_fallos is array (0 to 15) of t_Fallo;
   type array_activa_fallos is array (0 to 15) of Std_logic_vector(31 downto 0)
      := ( (ID_0, "", "")
      
      
      );

   signal fallos : array_fallos;
   signal activa_fallos : array_activa_fallos;

   -- Contador
   signal cuenta_pc_reg : Std_logic_vector(31 downto 0);
   signal cuenta_fallos_reg : Std_logic_vector(4 downto 0);

   signal enable : std_logic;
begin

p_cuenta_pc: process (clk, rst)
   begin
      if rst='0' then 
         cuenta_pc_reg <= (others =>'0');
      elsif rising_edge(clk) then
         cuenta_pc_reg <= std_logic_vector(unsigned(cuenta_pc_reg) + 4);
      end if;
   end process;

p_fallos: process(clk, rst)
   begin
      if rst='0' then 
         cuenta_fallos_reg <= (others =>'0');
         enable <= '1';
      elsif rising_edge(clk) then
         if enable = '1' and cuenta_pc_reg = activa_fallos(to_integer(unsigned(cuenta_fallos_reg))) then
            fallo <= fallos(to_integer(unsigned(cuenta_fallos_reg)));
            if to_integer(unsigned(cuenta_fallos_reg)) = num_fallos then
               enable <= '0';
            else
               cuenta_fallos_reg <= std_logic_vector(unsigned(cuenta_fallos_reg) + 1);
            end if;
         else
            fallo <=( ID => ID_0,
                      reg => (others=>'0'),
                      tipo => '0',
                      bool => (others=>'0'),
                      dato => (others=>'0')
                     );
         end if;
      end if;
   end process;



end Behavioral;

