--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:35:56 02/07/2015
-- Design Name:   
-- Module Name:   D:/TFG/TFG/VHDL/Proc_Evita_Conflictos/TB_Programa1.vhd
-- Project Name:  Proc_Evita_Conflictos
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
library modelsim_lib;
use modelsim_lib.util.all;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY TB_main IS
END TB_main;
 
ARCHITECTURE behavior OF TB_main IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT cpu
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         led : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal led : std_logic_vector(15 downto 0);

   type register_array is array (0 to 15) of std_logic_vector(31 downto 0);
   type memory_array is array (0 to 31) of std_logic_vector(31 downto 0);

   --Spy signals
   signal spy_regs : register_array;
   signal spy_mem : memory_array;
   signal spy_PC : std_logic_vector(31 downto 0);
   signal spy_INSTR : std_logic_vector(31 downto 0);
   
   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: cpu PORT MAP (
          clk => clk,
          rst => rst,
          led => led
        );

   -- Spy process
   spy_process : process
   begin
      init_signal_spy("/TB_main/uut/i_ID/i_pID/i_RegisterBank/regs","/TB_main/spy_regs",1);
      init_signal_spy("/TB_main/uut/i_MEM/i_pMEM/i_MemData/mem","/TB_main/spy_mem",1);
      init_signal_spy("/TB_main/uut/IF_out_pc_reg","/TB_main/spy_PC",1);
      init_signal_spy("/TB_main/uut/IF_out_inst_reg","/TB_main/spy_INSTR",1);
    wait;
   end process spy_process;

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
      -- hold reset state for 100 ns.
      rst <= '0';
      wait for 100 ns;	
      rst <= '1';
      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
