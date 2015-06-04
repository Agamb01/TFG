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
 
use work.IDs_regs_fallos.all;

ENTITY TB_Programa3 IS
END TB_Programa3;
 
ARCHITECTURE behavior OF TB_Programa3 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT main
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         led : OUT led
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   
 	--Outputs
--   signal out_test : std_logic_vector(31 downto 0);

   type register_array is array (0 to 15) of std_logic_vector(31 downto 0);
   type memory_array is array (0 to 31) of std_logic_vector(31 downto 0);

   --Spy signals
   signal spy_regs  : register_array;
   signal spy_mem   : memory_array;
   signal spy_PC    : std_logic_vector(31 downto 0);
   signal spy_INSTR : std_logic_vector(31 downto 0);
   
   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: main PORT MAP (
          clk => clk,
          rst => rst,
          led => led
        );

   -- Spy process
   spy_process : process
   begin
      init_signal_spy("/TB_Programa3/uut/i_ID/i_pID/i_RegisterBank/regs","/TB_Programa3/spy_regs", 1);
      init_signal_spy("/TB_Programa3/uut/i_MEM/i_pMEM/i_MemData/mem","/TB_Programa3/spy_mem",1);
      init_signal_spy("/TB_Programa3/uut/IF_out_pc_reg","/TB_Programa3/spy_PC",1);
      init_signal_spy("/TB_Programa3/uut/IF_out_inst_reg","/TB_Programa3/spy_INSTR",1);
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
 
   -- Test espía
   spy_proc: process
   begin		
      -- hold reset state for 100 ns.
      rst <= '0';
    wait for 100 ns;	
      rst <= '1';

      assert spy_PC = std_logic_vector(to_unsigned(0, 32)) report "ERROR: Inicio" severity ERROR;      
    wait for clk_period*5; -- Espera para que tengan efecto los cambios (Procesador de cinco ciclos)
--LDR R2, R0, #5
      assert spy_PC = std_logic_vector(to_unsigned(20, 32)) report "ERROR: PC 20" severity ERROR;
      assert spy_regs(2) = std_logic_vector(to_unsigned(5, 32)) report "ERROR: LDR R2, R0, #5" severity ERROR;
    wait for clk_period;
--MOV R1, #25
      assert spy_PC = std_logic_vector(to_unsigned(24, 32)) report "ERROR: PC 24" severity ERROR;
      assert spy_regs(1) = std_logic_vector(to_unsigned(25, 32)) report "ERROR: MOV R1, #25" severity ERROR;
    wait for clk_period;
--MOV R3, #0
      assert spy_PC = std_logic_vector(to_unsigned(28, 32)) report "ERROR: PC 28" severity ERROR;
      assert spy_regs(3) = std_logic_vector(to_unsigned(0, 32)) report "ERROR: MOV R3, #0" severity ERROR;
    wait for clk_period;
--MOV R5, #1
      assert spy_PC = std_logic_vector(to_unsigned(32, 32)) report "ERROR: PC 32" severity ERROR;
      assert spy_regs(5) = std_logic_vector(to_unsigned(1, 32)) report "ERROR: MOV R5, #1" severity ERROR;
    wait for clk_period;
--MOV R4, R2
      assert spy_PC = std_logic_vector(to_unsigned(36, 32)) report "ERROR: PC 36" severity ERROR;
      assert spy_regs(4) = std_logic_vector(to_unsigned(5, 32)) report "ERROR: MOV R4, R2" severity ERROR;
--NOP 
--NOP 
--NOP 
--CMP R4, R0 
--BEQ # 24 
--NOP 
--NOP 
--NOP
    wait for clk_period*10;
--ADD R3, R3, R1
      assert spy_PC = std_logic_vector(to_unsigned(32, 32)) report "ERROR: PC 72" severity ERROR;
      assert spy_regs(3) = std_logic_vector(to_unsigned(25, 32)) report "ERROR: ADD R3, R3, R1(25)" severity ERROR;
    wait for clk_period;
--SUB R4, R4, R5
      assert spy_PC = std_logic_vector(to_unsigned(36, 32)) report "ERROR: PC 76" severity ERROR;
      assert spy_regs(4) = std_logic_vector(to_unsigned(4, 32)) report "ERROR: SUB R4, R4, R5(4)" severity ERROR;
--CMP R4, R0 
--BEQ # 24 
--NOP 
--NOP 
--NOP
    wait for clk_period*10;
--ADD R3, R3, R1
      assert spy_PC = std_logic_vector(to_unsigned(32, 32)) report "ERROR: PC 116" severity ERROR;
      assert spy_regs(3) = std_logic_vector(to_unsigned(50, 32)) report "ERROR: ADD R3, R3, R1(50)" severity ERROR;
    wait for clk_period;
--SUB R4, R4, R5
      assert spy_PC = std_logic_vector(to_unsigned(36, 32)) report "ERROR: PC 120" severity ERROR;
      assert spy_regs(4) = std_logic_vector(to_unsigned(3, 32)) report "ERROR: SUB R4, R4, R5(3)" severity ERROR;
--CMP R4, R0 
--BEQ # 24 
--NOP 
--NOP 
--NOP
    wait for clk_period*10;
--ADD R3, R3, R1
      assert spy_PC = std_logic_vector(to_unsigned(32, 32)) report "ERROR: PC 160" severity ERROR;
      assert spy_regs(3) = std_logic_vector(to_unsigned(75, 32)) report "ERROR: ADD R3, R3, R1(75)" severity ERROR;
    wait for clk_period;
--SUB R4, R4, R5
      assert spy_PC = std_logic_vector(to_unsigned(36, 32)) report "ERROR: PC 164" severity ERROR;
      assert spy_regs(4) = std_logic_vector(to_unsigned(2, 32)) report "ERROR: SUB R4, R4, R5(2)" severity ERROR;
--CMP R4, R0 
--BEQ # 24 
--NOP 
--NOP 
--NOP
    wait for clk_period*10;
--ADD R3, R3, R1
      assert spy_PC = std_logic_vector(to_unsigned(32, 32)) report "ERROR:PC 204" severity ERROR;
      assert spy_regs(3) = std_logic_vector(to_unsigned(100, 32)) report "ERROR: ADD R3, R3, R1(100)" severity ERROR;
    wait for clk_period;
--SUB R4, R4, R5
      assert spy_PC = std_logic_vector(to_unsigned(36, 32)) report "ERROR: PC 208" severity ERROR;
      assert spy_regs(4) = std_logic_vector(to_unsigned(1, 32)) report "ERROR: SUB R4, R4, R5(1)" severity ERROR;
    wait for clk_period;
--CMP R4, R0 
--BEQ # 24 
--NOP 
--NOP 
--NOP
    wait for clk_period*9;
--ADD R3, R3, R1
      assert spy_PC = std_logic_vector(to_unsigned(32, 32)) report "ERROR: PC 248" severity ERROR;
      assert spy_regs(3) = std_logic_vector(to_unsigned(125, 32)) report "ERROR: ADD R3, R3, R1(125)" severity ERROR;
    wait for clk_period;
--SUB R4, R4, R5
      assert spy_PC = std_logic_vector(to_unsigned(36, 32)) report "ERROR: PC 252" severity ERROR;
      assert spy_regs(4) = std_logic_vector(to_unsigned(0, 32)) report "ERROR: SUB R4, R4, R5(0)" severity ERROR;
--B # -32
--NOP
--NOP
--NOP
--CMP R4, R0 
--BEQ # 24 
--NOP
--NOP
--NOP
--STR R3, R0, #0
    wait for clk_period*12;
      assert spy_PC = std_logic_vector(to_unsigned(96, 32)) report "ERROR: PC 296" severity ERROR;
      assert spy_mem(0) = std_logic_vector(to_unsigned(125, 32)) report "ERROR: STR R3, R0, #0" severity ERROR;
    wait;
   end process;

END;
