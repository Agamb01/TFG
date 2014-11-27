--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:35:43 11/27/2014
-- Design Name:   
-- Module Name:   D:/TFG/TFG/VHDL/Processor/TB_MemInstruction.vhd
-- Project Name:  Processor
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MemInstruction
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
 
ENTITY TB_MemInstruction IS
END TB_MemInstruction;
 
ARCHITECTURE behavior OF TB_MemInstruction IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MemInstruction
    PORT(
         in_pc : IN  std_logic_vector(31 downto 0);
         out_instruction : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal in_pc : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal out_instruction : std_logic_vector(31 downto 0);
 
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MemInstruction PORT MAP (
          in_pc => in_pc,
          out_instruction => out_instruction
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;
      
      -- insert stimulus here 
      in_pc <= (others=>'0');
      wait for clk_period*10;
      in_pc <= (others=>'1');
      wait for clk_period*10;
      in_pc <= (others=>'0');   
      
      wait;
   end process;

END;
