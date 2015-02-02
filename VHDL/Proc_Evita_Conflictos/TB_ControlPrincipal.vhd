--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:48:35 02/02/2015
-- Design Name:   
-- Module Name:   D:/TFG/TFG/VHDL/Proc_Evita_Conflictos/TB_ControlPrincipal.vhd
-- Project Name:  Proc_Evita_Conflictos
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
         out_WB_control : OUT  std_logic_vector(1 downto 0);
         out_MEM_control : OUT  std_logic_vector(5 downto 0);
         out_EXE_control : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal in_inst : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal out_WB_control : std_logic_vector(1 downto 0);
   signal out_MEM_control : std_logic_vector(5 downto 0);
   signal out_EXE_control : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ControlPrincipal PORT MAP (
          in_inst => in_inst,
          out_WB_control => out_WB_control,
          out_MEM_control => out_MEM_control,
          out_EXE_control => out_EXE_control
        );

   -- Clock process definitions
   <clock>_process :process
   begin
		<clock> <= '0';
		wait for <clock>_period/2;
		<clock> <= '1';
		wait for <clock>_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
