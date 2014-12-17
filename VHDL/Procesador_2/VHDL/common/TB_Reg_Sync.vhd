--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:27:01 11/29/2014
-- Design Name:   
-- Module Name:   C:/TFG/TFG/VHDL/Processor/TB_reg.vhd
-- Project Name:  Processor
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: reg
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
 
ENTITY TB_reg_sync IS
END TB_reg_sync;
 
ARCHITECTURE behavior OF TB_reg_sync IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT reg_sync
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         enable : IN  std_logic;
         in_data : IN  std_logic_vector(31 downto 0);
         out_data : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal enable : std_logic := '0';
   signal in_data : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal out_data : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: reg_sync PORT MAP (
          clk => clk,
          rst => rst,
          enable => enable,
          in_data => in_data,
          out_data => out_data
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
   
      in_data <= (others=>'0');
      enable <= '0';
      rst <= '0';
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      rst <= '1';
      wait for clk_period;
      in_data <= (others=>'1');
      enable <= '1';
      wait for clk_period;
      in_data <= (others=>'0');
      enable <= '1';
      wait for clk_period;
      in_data <= (others=>'1');
      enable <= '0';
      wait for clk_period;
      enable <= '1';

      wait;
   end process;

END;
