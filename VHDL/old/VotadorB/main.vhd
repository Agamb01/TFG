----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:17:41 01/14/2015 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main is
   Port(
      clk : in STD_LOGIC; -- , rst 
      input_A : in STD_LOGIC;
      input_B : in STD_LOGIC;
      output_Z : out STD_LOGIC
   );
end main;

architecture Behavioral of main is

   component comparador is
      Port ( 
         clk : in STD_LOGIC;
         A : in  STD_LOGIC;
         B : in  STD_LOGIC;
         Z : out  STD_LOGIC
      );
   end component;

   component votador is
      Port ( 
         A : in  STD_LOGIC;
         B : in  STD_LOGIC;
         C : in  STD_LOGIC;
         Z : out  STD_LOGIC
      );
   end component;

   signal data_A : STD_LOGIC;
   signal data_B : STD_LOGIC;
   signal data_C : STD_LOGIC;

begin

-- Comparadores, modulo sencillo
   i_comparador_A: comparador 
      port map(
         clk => clk,
         A => input_A,
         B => input_B,
         Z => data_A
      );
   i_comparador_B: comparador 
      port map(
         clk => clk,
         A => input_A,
         B => input_B,
         Z => data_B
      );
   i_comparador_C: comparador 
      port map(
         clk => clk,
         A => input_A,
         B => input_B,
         Z => data_C
      );

-- Registros A, B, C
-- Votador
   i_votador: votador
      port map(
         A => data_A,
         B => data_B,
         C => data_C,
         Z => output_Z
      );
     
end Behavioral;

