----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Andr�s Gamboa Mel�ndez
-- 
-- Create Date:    13:38:22 10/29/2014 
-- Design Name: 
-- Module Name:    RegisterBank - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: M�dulo de lectura y escritura de los registros del procesador.
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RegisterBank is
   port ( clk, rst : in STD_LOGIC;
      in_regA     : in STD_LOGIC_VECTOR(3 downto 0);     -- Registro A para lectura
      in_regB     : in STD_LOGIC_VECTOR(3 downto 0);     -- Registro B para lectura
      in_regW     : in STD_LOGIC_VECTOR(3 downto 0);     -- Registro para escritura
      in_busW     : in STD_LOGIC_VECTOR(31 downto 0);    -- Bus de datos para escritura
      in_WREnable : in STD_LOGIC;                        -- Se�al de control, habilitar escritura
      out_busA    : out STD_LOGIC_VECTOR(31 downto 0);   -- Bus de datos de registro A
      out_busB    : out STD_LOGIC_VECTOR(31 downto 0)    -- Bus de datos de registro B
   );
end RegisterBank;

architecture Behavioral of RegisterBank is

   type register_array is array (0 to 15) of std_logic_vector(31 downto 0);

   signal regs : register_array := (others=>(others=>'0'));

begin

-- proceso lectura, lectura asincrona
   p_lectura: process(regs, in_regA, in_regB)
   begin
      out_busA <= regs(to_integer(unsigned(in_regA)));
      out_busB <= regs(to_integer(unsigned(in_regB)));
   end process;

-- proceso escritura, escritura sincrona
   p_escritura: process(clk, rst)
   begin 
      if rising_edge(clk) then
         if rst = '0' then
            regs <= (others=>(others=>'0'));
         elsif in_WREnable='1' then
            regs(to_integer(unsigned(in_regW))) <= in_busW;
         end if;
      end if;
   end process;



end Behavioral;

