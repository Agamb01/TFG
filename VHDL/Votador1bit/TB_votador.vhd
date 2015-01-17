--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:36:04 01/14/2015
-- Design Name:   
-- Module Name:   C:/TFG/TFG/VHDL/Votador1bit/TB_votador.vhd
-- Project Name:  Votador1bit
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: votador
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
 
ENTITY TB_votadorNbits IS
END TB_votadorNbits;
 
ARCHITECTURE behavior OF TB_votadorNbits IS 
 
 constant N : INTEGER := 32;
 constant zeros : std_logic_vector(N-1 downto 0) := (others=>'0');
 constant ones : std_logic_vector(N-1 downto 0) := (others=>'1');
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT votadorNbits
    GENERIC(
         N : INTEGER := 1
        );
    PORT(
         A : IN  std_logic_vector(N-1 downto 0);
         B : IN  std_logic_vector(N-1 downto 0);
         C : IN  std_logic_vector(N-1 downto 0);
         Z : OUT  std_logic_vector(N-1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(N-1 downto 0) := (others => '0');
   signal B : std_logic_vector(N-1 downto 0) := (others => '0');
   signal C : std_logic_vector(N-1 downto 0) := (others => '0');

 	--Outputs
   signal Z : std_logic_vector(N-1 downto 0);
   -- No clocks detected in port list. Replace clk below with 
   -- appropriate port name 
 
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: votadorNbits 
      GENERIC MAP (
          N => N
        )
      PORT MAP (
          A => A,
          B => B,
          C => C,
          Z => Z
        ); 

   -- Stimulus process
stim_proc: process
 begin		
      A <= zeros;
      B <= zeros;
      C <= zeros;
   wait for clk_period;
      A <= zeros;
      B <= zeros;
      C <= ones;
   wait for clk_period;
      A <= zeros;
      B <= ones;
      C <= zeros;
   wait for clk_period;
      A <= zeros;
      B <= ones;
      C <= ones;
   wait for clk_period;
      A <= ones;
      B <= zeros;
      C <= zeros;
   wait for clk_period;
      A <= ones;
      B <= zeros;
      C <= ones;
   wait for clk_period;
      A <= ones;
      B <= ones;
      C <= zeros;
   wait for clk_period;
      A <= ones;
      B <= ones;
      C <= ones;
      wait;
 end process;

   -- Assert process
assert_proc: process
 begin	
   wait for clk_period/2;
      Assert Z = zeros
      Report "¬A¬B¬C deberia salir Z=0"
      Severity ERROR;
   wait for clk_period;
      Assert Z = zeros
      Report "¬A¬B C deberia salir Z=0"
      Severity ERROR;
   wait for clk_period;
      Assert Z = zeros
      Report "¬A B¬C deberia salir Z=0"
      Severity ERROR;
   wait for clk_period;
      Assert Z = ones
      Report "¬A B C deberia salir Z=1"
      Severity ERROR;
   wait for clk_period;
      Assert Z = zeros
      Report " A¬B¬C deberia salir Z=0"
      Severity ERROR;
   wait for clk_period;
      Assert Z = ones
      Report " A¬B C deberia salir Z=1"
      Severity ERROR;
   wait for clk_period;
      Assert Z = ones
      Report " A B¬C deberia salir Z=1"
      Severity ERROR;
   wait for clk_period;
      Assert Z = ones
      Report " A B C deberia salir Z=1"
      Severity ERROR;
      wait;
 end process;


END;
