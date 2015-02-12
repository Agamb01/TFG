----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:15:31 12/18/2014 
-- Design Name: 
-- Module Name:    modulo - Behavioral 
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
--   
---- Uncomment the following library declaration if using
---- arithmetic functions with Signed or Unsigned values
   use IEEE.NUMERIC_STD.ALL;

library work;
   use work.my_package.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


-- Entradas:
--    Clock de sistema
--    Reset de sistema
--    Array de paradas de la siguiente instrucción
--    Bit de instruccion "NADA" siguiente
--    

-- Salidas:
--    Array de paradas de esta instrucción
--    Bit de instrucción "NADA" actual
--    Enable para lógica de fase

entity modulo is
   Port( 
      clk, rst     : in STD_LOGIC;
      in_paradas   : in tipo_paradas;
      in_nada      : in STD_LOGIC;
      out_paradas  : out tipo_paradas;
      out_nada     : out STD_LOGIC;
      out_enable   : out STD_LOGIC
   );
end modulo;

architecture Behavioral of modulo is

   signal paradas_reg: tipo_paradas; -- Señales de cuantas paradas deben ejecutarse
   signal nada_reg: STD_LOGIC; -- Indica si la instrucción guardada en "NADA"

begin

   -- Si la instrucción actual es "NADA" o no necesita realizar ninguna parada, 
   -- carga valores para la siguiente instrucción
   p_carga: process(clk, rst)
   begin
      -- Si hay reset carga instrucción "NADA" 
      if rst = '0' then
         nada_reg <= '1';
      elsif rising_edge(clk) then
         -- Si la instrucción es "NADA" o no tiene que esperar carga valores de entrada
         if (nada_reg = '1') or (unsigned(paradas_reg(0)) = 0) then
            paradas_reg(0 to Numero_Fases) <= in_paradas(0 to Numero_Fases);
            nada_reg <= in_nada;
         elsif (unsigned(paradas_reg(0)) > 0) then 
            paradas_reg(0) <= std_logic_vector( unsigned(paradas_reg(0)) - 1 );
--            nada_reg <= nada_reg;         
         end if;
      end if;
   end process;
   
   p_salida: process(paradas_reg, nada_reg)
   begin
      out_paradas(0 to Numero_Fases-1) <= paradas_reg(1 to Numero_Fases);
      out_paradas(Numero_Fases) <= (others => '0');
      
      -- Se habilita el funcionamiento del modulo interno 
      -- si existe una instruccion valida
      out_enable <= not nada_reg; 

   -- La instruccion se propaga solo si es el ultimo ciclo de la instruccion en esta fase
      if (unsigned(paradas_reg(0)) = 0) and nada_reg = '0' then
         out_nada <= '0';
      else
         out_nada <= '1';
      end if;
   end process;
   

end Behavioral;

