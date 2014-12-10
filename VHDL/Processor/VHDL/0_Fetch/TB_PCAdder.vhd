--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:31:32 11/27/2014
-- Design Name:   
-- Module Name:   D:/TFG/TFG/VHDL/Processor/TB_PCAdder.vhd
-- Project Name:  Processor
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PCAdder
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
 
ENTITY TB_PCAdder IS
END TB_PCAdder;
 
ARCHITECTURE behavior OF TB_PCAdder IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PCAdder
    PORT(
         in_pc : IN  std_logic_vector(31 downto 0);
         out_pc : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal in_pc : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal out_pc : std_logic_vector(31 downto 0);
   
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PCAdder PORT MAP (
          in_pc => in_pc,
          out_pc => out_pc
        );

   -- Stimulus process
   stim_proc: process
   begin			
      wait for 100 ns;	
      in_pc <= out_pc;
   end process;

END;
