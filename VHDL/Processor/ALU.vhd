----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:21:02 11/17/2014 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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

entity ALU is
   Port ( 
      -- Entradas
      in_BusA   : in  STD_LOGIC_VECTOR (31 downto 0);
      in_BusB   : in  STD_LOGIC_VECTOR (31 downto 0);
      in_op     : in  STD_LOGIC_VECTOR (0 downto 0);
      
      --Salidas
      out_flags : out  STD_LOGIC_VECTOR (0 downto 0);
      out_busO  : out  STD_LOGIC_VECTOR (31 downto 0)
   );
end ALU;

architecture Behavioral of ALU is

begin


end Behavioral;

