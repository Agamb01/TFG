--
--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 
--
--   To use any of the example code shown below, uncomment the lines and modify as necessary
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;

package my_package is

   constant Numero_Fases : INTEGER := 5;

   type tipo_paradas is array(0 to Numero_Fases) of STD_LOGIC_VECTOR(1 downto 0);

end my_package;

package body my_package is

end my_package;
