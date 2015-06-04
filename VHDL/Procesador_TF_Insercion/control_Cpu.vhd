----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:20:20 02/24/2015 
-- Design Name: 
-- Module Name:    control_Cpu - Behavioral 
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
library work;
   use work.my_package.all;
   use work.IDs_regs_fallos.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity control_Cpu is
   Port(
      clk, rst : in STD_LOGIC;
      led : out STD_LOGIC_VECTOR (15 downto 0);
      datos : in STD_LOGIC_VECTOR (7 downto 0);
      pausa: in std_logic;
      load: in std_logic;
      tipoload : in STD_LOGIC_VECTOR (2 downto 0)
   );
end control_Cpu;

architecture Behavioral of control_Cpu is

component cpu is
   Port(
      clk, rst : in STD_LOGIC;
      led : out STD_LOGIC_VECTOR (15 downto 0);
      fallo : in t_Fallo
   );
end component;

signal tipo : std_logic;
signal bool : STD_LOGIC_VECTOR(31 downto 0);
signal dato : STD_LOGIC_VECTOR(31 downto 0);

begin

tipo <= '0';

--process(clk,load,tipoload)
--begin
--   if clk'event and clk='1' then
--      if (load ='1') then
--         case tipoload is
--            when "000" => bool(31 downto 24) <= datos;
--            when "001" => bool(23 downto 16) <= datos;
--            when "010" => bool(15 downto 8)  <= datos;
--            when "011" => bool(7 downto 0)   <= datos;
--            when "100" => dato(31 downto 24) <= datos;
--            when "101" => dato(23 downto 16) <= datos;
--            when "110" => dato(15 downto 8)  <= datos;
--            when "111" => dato(7 downto 0)   <= datos;
--            when others => dato(7 downto 0)  <= datos;
--         end case;
--      end if;
--   end if;
--end process;

cpu1: cpu port map(
      clk=>clk,
      rst => rst,
      led => led (15 downto 0),
      fallo.ID => id_IF_out_pc_reg,-- 5 bits
     -- Registros afectados por el error:
      -- 000 -> Ningun afectado
      -- 100, 010, 001 -> Uno afectado
      -- 110, 101, 011 -> Dos afectados
      -- 111 -> Todos afectados
      fallo.reg => "100",
     -- Tipo de error:
       -- 0 -> Fuerza los bits seleccionados(bool[x]=1) del valor dato al registro seleccionado(reg)
       -- 1 -> Invierte los bits seleccionados(bool[x]=1) del registro seleccionado(reg)
      fallo.tipo => '0',--tipo, 
     -- Seleccion de bits afectados.
      fallo.bool => bool(31 downto 0),
     -- Valor forzado si existe fallo.
      fallo.dato => dato(31 downto 0)
   );

end Behavioral;

