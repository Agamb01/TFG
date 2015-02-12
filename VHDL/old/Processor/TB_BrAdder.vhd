--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:10:30 12/11/2014
-- Design Name:   
-- Module Name:   C:/TFG/TFG/VHDL/Processor/TB_BrAdder.vhd
-- Project Name:  Processor
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: BrAdder
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
USE ieee.numeric_std.ALL;
 
ENTITY TB_BrAdder IS
END TB_BrAdder;
 
ARCHITECTURE behavior OF TB_BrAdder IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT BrAdder
    PORT(
         in_A : IN  std_logic_vector(31 downto 0);
         in_B : IN  std_logic_vector(31 downto 0);
         out_res : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal in_A : std_logic_vector(31 downto 0) := (others => '0');
   signal in_B : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal out_res : std_logic_vector(31 downto 0);
 
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: BrAdder PORT MAP (
          in_A => in_A,
          in_B => in_B,
          out_res => out_res
        ); 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      in_A <= std_logic_vector(to_signed(32,32));
      in_B <= std_logic_vector(to_signed(12,32));
      wait for clk_period;
      in_A <= std_logic_vector(to_signed(24,32));
      in_B <= std_logic_vector(to_signed(-16,32));
      wait;
   end process;

END;
