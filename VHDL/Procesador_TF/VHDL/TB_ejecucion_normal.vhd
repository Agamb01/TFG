----------------------------------------------------------------------------------
-- Company: Universidad Complutense de Madrid
-- Engineer: Andres Gamboa Melendez
-- 
-- Module Name: TB_ejecucion_normal - Testbench 
-- Project Name: ARM compatible micro-processor
-- Target Devices: Nexys4
-- Tool versions: Xilinx ISE Webpack 14.4
-- Description: Prueba de control para la ejecucion del programa multiplicacion 
--              basado en bucle de sumas.
-- 
-- VHDL Test Bench Created by ISE for module: cpu
-- 
--------------------------------------------------------------------------------
library modelsim_lib;
use modelsim_lib.util.all;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY TB_ejecucion_normal IS
END TB_ejecucion_normal;
 
ARCHITECTURE behavior OF TB_ejecucion_normal IS 
 
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

   --Spy signals
   signal spy_R0, spy_R1, spy_R2, spy_R3, spy_R4, spy_R5 : std_logic_vector(31 downto 0);
   signal spy_M0, spy_M5 : std_logic_vector(31 downto 0);
   signal spy_PC         : std_logic_vector(31 downto 0);
   signal spy_INSTR      : std_logic_vector(31 downto 0);


   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: cpu PORT MAP (
          clk => clk,
          rst => rst,
          led => led
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
    -- Configurar señales espías
   spy_init : process
   begin
      init_signal_spy("/TB_ejecucion_normal/uut/i_ID/i_pID/i_RegisterBank/regs(0)","/TB_ejecucion_normal/spy_R0", 1);
      init_signal_spy("/TB_ejecucion_normal/uut/i_ID/i_pID/i_RegisterBank/regs(1)","/TB_ejecucion_normal/spy_R1", 1);
      init_signal_spy("/TB_ejecucion_normal/uut/i_ID/i_pID/i_RegisterBank/regs(2)","/TB_ejecucion_normal/spy_R2", 1);
      init_signal_spy("/TB_ejecucion_normal/uut/i_ID/i_pID/i_RegisterBank/regs(3)","/TB_ejecucion_normal/spy_R3", 1);
      init_signal_spy("/TB_ejecucion_normal/uut/i_ID/i_pID/i_RegisterBank/regs(4)","/TB_ejecucion_normal/spy_R4", 1);
      init_signal_spy("/TB_ejecucion_normal/uut/i_ID/i_pID/i_RegisterBank/regs(5)","/TB_ejecucion_normal/spy_R5", 1);
   
      init_signal_spy("/TB_ejecucion_normal/uut/i_MEM/i_pMEM/i_MemData/mem(0)","/TB_ejecucion_normal/spy_M0",1);
      init_signal_spy("/TB_ejecucion_normal/uut/i_MEM/i_pMEM/i_MemData/mem(5)","/TB_ejecucion_normal/spy_M5",1);
      
      init_signal_spy("/TB_ejecucion_normal/uut/IF_out_pc_reg","/TB_ejecucion_normal/spy_PC",1);
      init_signal_spy("/TB_ejecucion_normal/uut/IF_out_inst_reg","/TB_ejecucion_normal/spy_INSTR",1);
    wait;
   end process spy_init;
 
 
   -- Test de funcionamiento
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
      assert spy_R2 = std_logic_vector(to_unsigned(5, 32)) report "ERROR: LDR R2, R0, #5" severity ERROR;
    wait for clk_period;
--MOV R1, #25
      assert spy_PC = std_logic_vector(to_unsigned(24, 32)) report "ERROR: PC 24" severity ERROR;
      assert spy_R1 = std_logic_vector(to_unsigned(25, 32)) report "ERROR: MOV R1, #25" severity ERROR;
    wait for clk_period;
--MOV R3, #0
      assert spy_PC = std_logic_vector(to_unsigned(28, 32)) report "ERROR: PC 28" severity ERROR;
      assert spy_R3 = std_logic_vector(to_unsigned(0, 32)) report "ERROR: MOV R3, #0" severity ERROR;
    wait for clk_period;
--MOV R5, #1
      assert spy_PC = std_logic_vector(to_unsigned(32, 32)) report "ERROR: PC 32" severity ERROR;
      assert spy_R5 = std_logic_vector(to_unsigned(1, 32)) report "ERROR: MOV R5, #1" severity ERROR;
    wait for clk_period;
--MOV R4, R2
      assert spy_PC = std_logic_vector(to_unsigned(36, 32)) report "ERROR: PC 36" severity ERROR;
      assert spy_R4 = std_logic_vector(to_unsigned(5, 32)) report "ERROR: MOV R4, R2" severity ERROR;
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
      assert spy_R3 = std_logic_vector(to_unsigned(25, 32)) report "ERROR: ADD R3, R3, R1(25)" severity ERROR;
    wait for clk_period;
--SUB R4, R4, R5
      assert spy_PC = std_logic_vector(to_unsigned(36, 32)) report "ERROR: PC 76" severity ERROR;
      assert spy_R4 = std_logic_vector(to_unsigned(4, 32)) report "ERROR: SUB R4, R4, R5(4)" severity ERROR;
--CMP R4, R0 
--BEQ # 24 
--NOP 
--NOP 
--NOP
    wait for clk_period*10;
--ADD R3, R3, R1
      assert spy_PC = std_logic_vector(to_unsigned(32, 32)) report "ERROR: PC 116" severity ERROR;
      assert spy_R3 = std_logic_vector(to_unsigned(50, 32)) report "ERROR: ADD R3, R3, R1(50)" severity ERROR;
    wait for clk_period;
--SUB R4, R4, R5
      assert spy_PC = std_logic_vector(to_unsigned(36, 32)) report "ERROR: PC 120" severity ERROR;
      assert spy_R4 = std_logic_vector(to_unsigned(3, 32)) report "ERROR: SUB R4, R4, R5(3)" severity ERROR;
--CMP R4, R0 
--BEQ # 24 
--NOP 
--NOP 
--NOP
    wait for clk_period*10;
--ADD R3, R3, R1
      assert spy_PC = std_logic_vector(to_unsigned(32, 32)) report "ERROR: PC 160" severity ERROR;
      assert spy_R3 = std_logic_vector(to_unsigned(75, 32)) report "ERROR: ADD R3, R3, R1(75)" severity ERROR;
    wait for clk_period;
--SUB R4, R4, R5
      assert spy_PC = std_logic_vector(to_unsigned(36, 32)) report "ERROR: PC 164" severity ERROR;
      assert spy_R4 = std_logic_vector(to_unsigned(2, 32)) report "ERROR: SUB R4, R4, R5(2)" severity ERROR;
--CMP R4, R0 
--BEQ # 24 
--NOP 
--NOP 
--NOP
    wait for clk_period*10;
--ADD R3, R3, R1
      assert spy_PC = std_logic_vector(to_unsigned(32, 32)) report "ERROR:PC 204" severity ERROR;
      assert spy_R3 = std_logic_vector(to_unsigned(100, 32)) report "ERROR: ADD R3, R3, R1(100)" severity ERROR;
    wait for clk_period;
--SUB R4, R4, R5
      assert spy_PC = std_logic_vector(to_unsigned(36, 32)) report "ERROR: PC 208" severity ERROR;
      assert spy_R4 = std_logic_vector(to_unsigned(1, 32)) report "ERROR: SUB R4, R4, R5(1)" severity ERROR;
    wait for clk_period;
--CMP R4, R0 
--BEQ # 24 
--NOP 
--NOP 
--NOP
    wait for clk_period*9;
--ADD R3, R3, R1
      assert spy_PC = std_logic_vector(to_unsigned(32, 32)) report "ERROR: PC 248" severity ERROR;
      assert spy_R3 = std_logic_vector(to_unsigned(125, 32)) report "ERROR: ADD R3, R3, R1(125)" severity ERROR;
    wait for clk_period;
--SUB R4, R4, R5
      assert spy_PC = std_logic_vector(to_unsigned(36, 32)) report "ERROR: PC 252" severity ERROR;
      assert spy_R4 = std_logic_vector(to_unsigned(0, 32)) report "ERROR: SUB R4, R4, R5(0)" severity ERROR;
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
      assert spy_M0 = std_logic_vector(to_unsigned(125, 32)) report "ERROR: STR R3, R0, #0" severity ERROR;
    wait;
   end process;
   
END;
