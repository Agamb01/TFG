----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:14:10 12/18/2014 
-- Design Name: 
-- Module Name:    main - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main is
   Port(
      clk, rst    : in STD_LOGIC;
      in_nada     : in STD_LOGIC;
      in_paradas  : in tipo_paradas;
      
      out_nada    : out STD_LOGIC_VECTOR(0 to Numero_Fases);
      out_paradas : out set_tipo_paradas;
      out_enable  : out STD_LOGIC_VECTOR(0 to Numero_Fases)
   );
end main;

architecture Behavioral of main is

component modulo is
   Port( 
      clk, rst     : in STD_LOGIC;
      in_paradas   : in tipo_paradas;
      in_nada      : in STD_LOGIC;
      out_paradas  : out tipo_paradas;
      out_nada     : out STD_LOGIC;
      out_enable   : out STD_LOGIC
   );
end component;


   signal set_paradas : set_tipo_paradas;
   signal set_nada    : STD_LOGIC_VECTOR(0 to Numero_Fases+1);
   signal set_enable  : STD_LOGIC_VECTOR(0 to Numero_Fases);
   
begin
   
   set_nada(0) <= in_nada;
   set_paradas(0) <= in_paradas;
   
    GEN: 
    for i in 0 to Numero_Fases generate
     M: modulo port map (
         clk         => clk,
         rst         => rst,
         in_paradas  => set_paradas(i),
         in_nada     => set_nada(i),
         out_paradas => set_paradas(i+1),
         out_nada    => set_nada(i+1),
         out_enable  => set_enable(i)
      );
   end generate GEN;
      
--   out_paradas <= set_paradas(Numero_Fases+1);
   out_paradas <= set_paradas;
   out_nada <= set_nada(1 to Numero_Fases+1);
   out_enable <= set_enable;
   
end Behavioral;

