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

use work.IDs_regs_fallos.all;

entity Sistema_Tolerancia_2 is
   Generic (
      size_data : integer := 32
   );
   Port ( 
      clk, rst : in STD_LOGIC;
      ID_const : in t_ID_reg;
      fallo_in : in t_Fallo;
      dato_in  : in STD_LOGIC_VECTOR (size_dato-1 downto 0);
      dato_out : out STD_LOGIC_VECTOR (size_dato-1 downto 0)
   );
end Sistema_Tolerancia_2;

architecture Behavioral of Sistema_Tolerancia_2 is

   signal regs : array_regs;

begin

   p_regs: process (clk, rst)
   begin
      if rst='0' then
         regs <= (others=> (others=>'0') );
      elsif rising_edge(clk) then
         for i in 0 to N_Tolerancia-1 loop -- Para cada registro
            if ID_const = fallo_in.ID and -- Si es el ID indicado
             fallo_in.reg(i) = '1' then  -- y el registro i se ve afectado entonces
               if fallo_in.tipo = '0' then -- Si el tipo de fallo es "forzar valor" entonces
                  -- Mantiene los bits que no se ve afectados
                  -- Fuerza los datos que si se ven afectados
                  regs(i) <= (dato_in and not fallo_in.bool) or (fallo_in.bool and fallo_in.dato);
               else -- En caso contrario (Tipo de fallo es "Invertir valores")
                  -- Invierte el dato
                  regs(i) <= fallo_in.bool xor dato_in;
               end if;
            else -- En caso contrario (No se aplica ningun fallo)
               regs(i) <= dato_in;
            end if;
         end loop;
      end if;
   end process;
   
   dato_out <= (regs(0) and regs(1)) or (regs(0) and regs(2)) or (regs(1) and regs(2)); 

end Behavioral;

