--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:10:39 12/11/2014
-- Design Name:   
-- Module Name:   C:/TFG/TFG/VHDL/Processor/TB_ControlPrincipal.vhd
-- Project Name:  Processor
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ControlPrincipal
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
 
ENTITY TB_ControlPrincipal IS
END TB_ControlPrincipal;
 
ARCHITECTURE behavior OF TB_ControlPrincipal IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ControlPrincipal
    PORT(
         in_inst : IN  std_logic_vector(31 downto 0);
         out_WB_ctr : OUT  std_logic_vector(11 downto 0);
         out_MEM_ctr : OUT  std_logic_vector(9 downto 0);
         out_EXE_ctr : OUT  std_logic_vector(9 downto 0);
         out_test : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal in_inst : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal out_WB_ctr : std_logic_vector(11 downto 0);
   signal out_MEM_ctr : std_logic_vector(9 downto 0);
   signal out_EXE_ctr : std_logic_vector(9 downto 0);
   signal out_test : std_logic_vector(4 downto 0);
 
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ControlPrincipal PORT MAP (
          in_inst => in_inst,
          out_WB_ctr => out_WB_ctr,
          out_MEM_ctr => out_MEM_ctr,
          out_EXE_ctr => out_EXE_ctr,
          out_test => out_test
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

--ADD R1, R1, #4 --out_test esperado: "10000"
      in_inst(31 downto 16) <= "1111001000000001";
      in_inst(15 downto 0) <= "0000000100000100";
      wait for 100 ns;	

--SUB R1, R1, #8 --out_test esperado: "10000"
      in_inst(31 downto 16) <= "1111001010100001";
      in_inst(15 downto 0) <= "0000000100001000";
      wait for 100 ns;	

--MOV R1, #13    --out_test esperado: "01000"
      in_inst(31 downto 16) <= "1111001001000000";
      in_inst(15 downto 0) <= "0000000100001101";
      wait for 100 ns;	

--MOVT R1, #15   --out_test esperado: "01000"
      in_inst(31 downto 16) <= "1111001011000000";
      in_inst(15 downto 0) <= "0000000100001111";
      wait for 100 ns;	

--LDR R1, R2, #0 --out_test esperado: "00100"
      in_inst(31 downto 16) <= "1111100010010001";
      in_inst(15 downto 0) <= "0010000000000000";
      wait for 100 ns;	
      
--STR R2, R3, #2 --out_test esperado: "00100"
      in_inst(31 downto 16) <= "1111100010000010";
      in_inst(15 downto 0) <= "0011000000000010";
      wait for 100 ns;	

--B #<+768>      --out_test esperado: "00010"
      in_inst(31 downto 16) <= "1111000000000000";
      in_inst(15 downto 0) <= "1001000110000000"; 
      wait for 100 ns;	
      wait;
   end process;

END;
