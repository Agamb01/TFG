--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:12:56 12/19/2014
-- Design Name:   
-- Module Name:   C:/TFG/TFG/VHDL/Evita_conflictos/TB_main.vhd
-- Project Name:  Evita_conflictos
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: main
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TB_main IS
END TB_main;
 
ARCHITECTURE behavior OF TB_main IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT main
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         in_nada : IN  std_logic;
         in_paradas : IN  std_logic_vector(0 to 4);
         out_nada : OUT  std_logic_vector(0 to 4);
         out_enable : OUT  std_logic_vector(0 to 4)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal in_nada : std_logic := '0';
   signal in_paradas : std_logic_vector(0 to 4) := (others => '0');

 	--Outputs
   signal out_nada : std_logic_vector(0 to 4);
   signal out_enable : std_logic_vector(0 to 4);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: main PORT MAP (
          clk => clk,
          rst => rst,
          in_nada => in_nada,
          in_paradas => in_paradas,
          out_nada => out_nada,
          out_enable => out_enable
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 



END;
