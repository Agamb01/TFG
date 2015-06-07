----------------------------------------------------------------------------------
-- Company: Universidad Complutense de Madrid
-- Engineer: Andrés Gamboa Meléndez
-- 
-- Module Name: RegisterBank - Behavioral 
-- Project Name: ARM compatible micro-processor
-- Target Devices: Nexys4
-- Tool versions: Xilinx ISE Webpack 14.4
-- Description: Módulo de lectura y escritura de los registros del procesador.
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
      in_WREnable : in STD_LOGIC;                        -- Señal de control, habilitar escritura
      out_busA    : out STD_LOGIC_VECTOR(31 downto 0);   -- Bus de datos de registro A
      out_busB    : out STD_LOGIC_VECTOR(31 downto 0)    -- Bus de datos de registro B
   );
end RegisterBank;

architecture Behavioral of RegisterBank is

   type register_array is array (0 to 15) of std_logic_vector(31 downto 0);
   constant regs_rst : register_array := (
        "00000000000000000000000000000000",
        "00000000000000000000000000000001",
        "00000000000000000000000000000010",
        "00000000000000000000000000000011",
        "00000000000000000000000000000100",
        "00000000000000000000000000000101",
        "00000000000000000000000000000110",
        "00000000000000000000000000000111",
        "00000000000000000000000000001000",
        "00000000000000000000000000001001",
        "00000000000000000000000000001010",
        "00000000000000000000000000001011",
        "00000000000000000000000000001100",
        "00000000000000000000000000001101",
        "00000000000000000000000000001110",
        "00000000000000000000000000001111"
        );
        
   signal regs : register_array := regs_rst;

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
      if rst = '0' then
         regs <= regs_rst;
      elsif rising_edge(clk) then
         if in_WREnable='1' then
            regs(to_integer(unsigned(in_regW))) <= in_busW;
         end if;
      end if;
   end process;



end Behavioral;

