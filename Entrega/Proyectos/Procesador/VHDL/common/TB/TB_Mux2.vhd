--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:26:35 11/29/2014
-- Design Name:   
-- Module Name:   C:/TFG/TFG/VHDL/Processor/TB_mux2.vhd
-- Project Name:  Processor
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mux2
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
 
ENTITY TB_mux2 IS
END TB_mux2;
 
ARCHITECTURE behavior OF TB_mux2 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mux2
    PORT(
         in_A : IN  std_logic_vector(31 downto 0);
         in_B : IN  std_logic_vector(31 downto 0);
         sel : IN  std_logic;
         out_C : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal in_A : std_logic_vector(31 downto 0) := (others => '0');
   signal in_B : std_logic_vector(31 downto 0) := (others => '0');
   signal sel : std_logic := '0';

 	--Outputs
   signal out_C : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mux2 PORT MAP (
          in_A => in_A,
          in_B => in_B,
          sel => sel,
          out_C => out_C
        ); 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      in_A <= (others=>'0');
      in_B <= (others=>'1');
      sel <= '0';
      wait for clk_period*10;
      in_A(31 downto 16) <= (others=>'0');      
      in_A(15 downto 0) <= (others=>'1');      
      wait for clk_period*10;
      sel <= '1';
      -- insert stimulus here 

      wait;
   end process;

END;
