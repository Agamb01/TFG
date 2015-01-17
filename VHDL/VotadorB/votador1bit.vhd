----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:18:19 01/14/2015 
-- Design Name: 
-- Module Name:    votador - Behavioral 
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

-- Un votabor simple de 3 entradas de N bits. 
-- La salida se compone de comparar las entradas bit a bit y seleccionar el valor 
-- más repetido para cada bit.


entity votador is
   Port ( 
      A : in  STD_LOGIC;
      B : in  STD_LOGIC;
      C : in  STD_LOGIC;
      Z : out  STD_LOGIC
   );
end votador1bit;

architecture Behavioral of votador1bit is

---------------------------------------
-- C\AB | 00 | 01 | 11 | 10
-- 0    |  0 |  0 |  1 |  0
-- 1    |  0 |  1 |  1 |  1
-- Z <= ABC or (¬A)BC or A(¬B)C or AB(¬C)
-- ABC or (¬A)BC = ((A or (¬A)) and BC ) = BC
-- Z <= BC or AC or AB
---------------------------------------

begin

   Z <= (A and B) or (A and C) or (B and C); 

end Behavioral;

