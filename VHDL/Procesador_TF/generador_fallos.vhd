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
   constant num_fallos : integer := 16;
   type array_fallos is array (0 to num_fallos-1) of t_Fallo;
   type array_ciclo_inserta is array (0 to num_fallos-1) of Std_logic_vector(31 downto 0);

   signal fallos : array_fallos;
   signal ciclo_inserta : array_ciclo_inserta;

   -- Contadores
   signal cuenta_ciclos_reg : Std_logic_vector(31 downto 0);
   signal cuenta_fallos_reg : Std_logic_vector(4 downto 0);

   signal enable : std_logic;
begin


-- Contador de ciclos, Cuenta cada ciclo para 
p_cuenta_ciclos: process (clk, rst)
   begin
      if rst='0' then 
         cuenta_ciclos_reg <= (others =>'0');
      elsif rising_edge(clk) then
         cuenta_ciclos_reg <= std_logic_vector(unsigned(cuenta_ciclos_reg) + 1);
      end if;
   end process;


-- Inserta fallos
p_fallos: process(clk, rst)
   begin
      if rst='0' then -- Reinicia la cuenta del fallo a insertar
         -- Empieza en 1 porque debe decidirse si se inserta un fallo en el siguiente ciclo de reloj
         cuenta_fallos_reg <= std_logic_vector(to_unsigned(1,5));
         enable <= '1';
      elsif rising_edge(clk) then
         -- Si se habilita la inserción y se debe insertar un fallo en el ciclo siguiente
         if enable = '1' and cuenta_ciclos_reg = ciclo_inserta(to_integer(unsigned(cuenta_fallos_reg))) then
            -- Se asigna el fallo a la salida
            fallo <= fallos(to_integer(unsigned(cuenta_fallos_reg)));
            -- Si llegamos al final de la memoria de fallos, se dehabilita la inserción
            if to_integer(unsigned(cuenta_fallos_reg)) = num_fallos-1 then
               enable <= '0';
            else -- E.o.c. se continúa la cuenta
               cuenta_fallos_reg <= std_logic_vector(unsigned(cuenta_fallos_reg) + 1);
            end if;
         else
         -- Si se dehabilita la inserción de fallos, se inserta un fallo nulo, sin registro asignado
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

