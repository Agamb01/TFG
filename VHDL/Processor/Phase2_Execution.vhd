----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:28:11 11/14/2014 
-- Design Name: 
-- Module Name:    PhaseExecution - Behavioral 
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

entity Phase2_Execution is
   port ( clk, rst : in STD_LOGIC;  
         
          --in_Señales de control
          in_PC : in STD_LOGIC_VECTOR(31 downto 0);
          in_entero : in STD_LOGIC_VECTOR(31 downto 0);
          in_busA : in STD_LOGIC_VECTOR(31 downto 0);
          in_busB : in STD_LOGIC_VECTOR(31 downto 0);
          in_RW : in STD_LOGIC_VECTOR(3 downto 0);
          
          --out_Señales de control
          out_PC_salto_reg : out STD_LOGIC_VECTOR(31 downto 0);
          out_flagsALU_reg : out STD_LOGIC_VECTOR(3 downto 0);
          out_busALU_reg : out STD_LOGIC_VECTOR(31 downto 0);
          out_busB_reg : out STD_LOGIC_VECTOR(31 downto 0);
          out_RW_reg : out STD_LOGIC_VECTOR(3 downto 0)
         );
end Phase2_Execution;

architecture Behavioral of Phase2_Execution is

begin


end Behavioral;

