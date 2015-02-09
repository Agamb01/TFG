--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:23:48 01/14/2015
-- Design Name:   
-- Module Name:   C:/TFG/TFG/VHDL/Votador1bit/TB_votador1bit.vhd
-- Project Name:  Votador1bit
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: votador1bit
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
 
ENTITY TB_votador1bit IS
END TB_votador1bit;
 
ARCHITECTURE behavior OF TB_votador1bit IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT votador1bit
    PORT(
         A : IN  std_logic;
         B : IN  std_logic;
         C : IN  std_logic;
         Z : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic := '0';
   signal B : std_logic := '0';
   signal C : std_logic := '0';

 	--Outputs
   signal Z : std_logic;

   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: votador1bit PORT MAP (
          A => A,
          B => B,
          C => C,
          Z => Z
        );

   -- Stimulus process
stim_proc: process
 begin		
      A <= '0';
      B <= '0';
      C <= '0';
   wait for clk_period;
      A <= '0';
      B <= '0';
      C <= '1';
   wait for clk_period;
      A <= '0';
      B <= '1';
      C <= '0';
   wait for clk_period;
      A <= '0';
      B <= '1';
      C <= '1';
   wait for clk_period;
      A <= '1';
      B <= '0';
      C <= '0';
   wait for clk_period;
      A <= '1';
      B <= '0';
      C <= '1';
   wait for clk_period;
      A <= '1';
      B <= '1';
      C <= '0';
   wait for clk_period;
      A <= '1';
      B <= '1';
      C <= '1';
      wait;
 end process;

   -- Assert process
assert_proc: process
 begin	
   wait for clk_period/2;
      Assert Z = '0'
      Report "¬A¬B¬C deberia salir Z=0"
      Severity ERROR;
   wait for clk_period;
      Assert Z = '0'
      Report "¬A¬B C deberia salir Z=0"
      Severity ERROR;
   wait for clk_period;
      Assert Z = '0'
      Report "¬A B¬C deberia salir Z=0"
      Severity ERROR;
   wait for clk_period;
      Assert Z = '1'
      Report "¬A B C deberia salir Z=1"
      Severity ERROR;
   wait for clk_period;
      Assert Z = '0'
      Report " A¬B¬C deberia salir Z=0"
      Severity ERROR;
   wait for clk_period;
      Assert Z = '1'
      Report " A¬B C deberia salir Z=1"
      Severity ERROR;
   wait for clk_period;
      Assert Z = '1'
      Report " A B¬C deberia salir Z=1"
      Severity ERROR;
   wait for clk_period;
      Assert Z = '1'
      Report " A B C deberia salir Z=1"
      Severity ERROR;
      wait;
 end process;

END;
