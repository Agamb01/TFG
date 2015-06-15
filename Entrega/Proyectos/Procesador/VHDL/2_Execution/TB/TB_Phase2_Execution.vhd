--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:17:27 01/23/2015
-- Design Name:   
-- Module Name:   C:/TFG/TFG/VHDL/Proc_Evita_Conflictos/TB_Phase2_Execution.vhd
-- Project Name:  Proc_Evita_Conflictos
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Phase2_Execution
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
 
ENTITY TB_Phase2_Execution IS
END TB_Phase2_Execution;
 
ARCHITECTURE behavior OF TB_Phase2_Execution IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Phase2_Execution
    PORT(
         in_PC : IN  std_logic_vector(31 downto 0);
         in_entero : IN  std_logic_vector(31 downto 0);
         in_busA : IN  std_logic_vector(31 downto 0);
         in_busB : IN  std_logic_vector(31 downto 0);
         out_PC_salto : OUT  std_logic_vector(31 downto 0);
         out_ALU_bus : OUT  std_logic_vector(31 downto 0);
         out_ALU_flags : OUT  std_logic_vector(1 downto 0);
         in_EXE_control : IN  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal in_PC : std_logic_vector(31 downto 0) := (others => '0');
   signal in_entero : std_logic_vector(31 downto 0) := (others => '0');
   signal in_busA : std_logic_vector(31 downto 0) := (others => '0');
   signal in_busB : std_logic_vector(31 downto 0) := (others => '0');
   signal in_EXE_control : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal out_PC_salto : std_logic_vector(31 downto 0);
   signal out_ALU_bus : std_logic_vector(31 downto 0);
   signal out_ALU_flags : std_logic_vector(1 downto 0);

   signal clk : std_logic;
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Phase2_Execution PORT MAP (
          in_PC => in_PC,
          in_entero => in_entero,
          in_busA => in_busA,
          in_busB => in_busB,
          out_PC_salto => out_PC_salto,
          out_ALU_bus => out_ALU_bus,
          out_ALU_flags => out_ALU_flags,
          in_EXE_control => in_EXE_control
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
-- Tabla operaciones
-- ADD  000
-- SUB  001
-- MOV  010
-- MOVT 011

-- AND  100
-- ORR  101
-- EOR  110
-- CMP  111

   -- Stimulus process
   stim_proc: process
   begin		
   -- RESET
       in_PC          <= std_logic_vector(to_signed(0, 32));
       in_entero      <= std_logic_vector(to_signed(0, 32));
       in_busA        <= std_logic_vector(to_signed(0, 32));
       in_busB        <= std_logic_vector(to_signed(0, 32));
       in_EXE_control <= "0000"; -- ADD, bus | (ALUop, ALUctr)
   
   -- ADD bus, BR=4+12=16 ALU=4+8=12
      wait for clk_period;
       in_PC          <= std_logic_vector(to_signed(4, 32));
       in_entero      <= std_logic_vector(to_signed(12, 32));
       in_busA        <= std_logic_vector(to_signed(8, 32));
       in_busB        <= std_logic_vector(to_signed(4, 32));
       in_EXE_control <= "0000"; -- ADD, bus | (ALUop, ALUctr)

   -- ADD entero, BR=8+12=20 ALU=4+12=16
      wait for clk_period;
       in_PC          <= std_logic_vector(to_signed(8, 32));
       in_entero      <= std_logic_vector(to_signed(12, 32));
       in_busA        <= std_logic_vector(to_signed(4, 32));
       in_busB        <= std_logic_vector(to_signed(8, 32));
       in_EXE_control <= "0001"; -- ADD, entero | (ALUop, ALUctr)

   -- SUB bus, BR=8+12=20 ALU=4-8=-4
      wait for clk_period;
       in_PC          <= std_logic_vector(to_signed(8, 32));
       in_entero      <= std_logic_vector(to_signed(12, 32));
       in_busA        <= std_logic_vector(to_signed(4, 32));
       in_busB        <= std_logic_vector(to_signed(8, 32));
       in_EXE_control <= "0010"; -- SUB, bus | (ALUop, ALUctr)

   -- SUB entero, BR=8+12=20 ALU=4-12=-8
      wait for clk_period;
       in_PC          <= std_logic_vector(to_signed(8, 32));
       in_entero      <= std_logic_vector(to_signed(12, 32));
       in_busA        <= std_logic_vector(to_signed(4, 32));
       in_busB        <= std_logic_vector(to_signed(8, 32));
       in_EXE_control <= "0011"; -- SUB, entero | (ALUop, ALUctr)

   -- AND bus, BR=28+(-12)=16 ALU=5&&3=1
      wait for clk_period;
       in_PC          <= std_logic_vector(to_signed(28, 32));
       in_entero      <= std_logic_vector(to_signed(-12, 32));
       in_busA        <= std_logic_vector(to_signed(5, 32));
       in_busB        <= std_logic_vector(to_signed(3, 32));
       in_EXE_control <= "1000"; -- AND, bus | (ALUop, ALUctr)

   -- ORR bus, BR=28+(-12)=16 ALU=5||3=7
      wait for clk_period;
       in_PC          <= std_logic_vector(to_signed(28, 32));
       in_entero      <= std_logic_vector(to_signed(-12, 32));
       in_busA        <= std_logic_vector(to_signed(5, 32));
       in_busB        <= std_logic_vector(to_signed(3, 32));
       in_EXE_control <= "1010"; -- ORR, bus | (ALUop, ALUctr)

   -- EOR bus, BR=28+(-12)=16 ALU=5(xor)3=6
      wait for clk_period;
       in_PC          <= std_logic_vector(to_signed(28, 32));
       in_entero      <= std_logic_vector(to_signed(-12, 32));
       in_busA        <= std_logic_vector(to_signed(5, 32));
       in_busB        <= std_logic_vector(to_signed(3, 32));
       in_EXE_control <= "1100"; -- EOR, bus | (ALUop, ALUctr)

   -- CMP bus, BR=28+(-12)=16 ALU=0 (00)
      wait for clk_period;
       in_PC          <= std_logic_vector(to_signed(28, 32));
       in_entero      <= std_logic_vector(to_signed(-12, 32));
       in_busA        <= std_logic_vector(to_signed(5, 32));
       in_busB        <= std_logic_vector(to_signed(3, 32));
       in_EXE_control <= "1110"; -- CMP, bus | (ALUop, ALUctr)

   -- CMP bus, BR=28+(-12)=16 ALU=0 (01)
      wait for clk_period;
       in_PC          <= std_logic_vector(to_signed(28, 32));
       in_entero      <= std_logic_vector(to_signed(-12, 32));
       in_busA        <= std_logic_vector(to_signed(5, 32));
       in_busB        <= std_logic_vector(to_signed(5, 32));
       in_EXE_control <= "1110"; -- CMP, bus | (ALUop, ALUctr)

   -- CMP bus, BR=28+(-12)=16 ALU=0 (10)
      wait for clk_period;
       in_PC          <= std_logic_vector(to_signed(28, 32));
       in_entero      <= std_logic_vector(to_signed(-12, 32));
       in_busA        <= std_logic_vector(to_signed(3, 32));
       in_busB        <= std_logic_vector(to_signed(5, 32));
       in_EXE_control <= "1111"; -- CMP, entero | (ALUop, ALUctr)

   -- MOV entero, BR=28+12=40 ALU=65536,12=65548
      wait for clk_period;
       in_PC          <= std_logic_vector(to_signed(28, 32));
       in_entero      <= std_logic_vector(to_signed(12, 32));
       in_busA        <= std_logic_vector(to_signed(65536, 32));
       in_busB        <= std_logic_vector(to_signed(12, 32));
       in_EXE_control <= "0101"; -- MOV, entero | (ALUop, ALUctr)

   -- MOVT entero, BR=28+12=40 ALU=1,786432=786433
      wait for clk_period;
       in_PC          <= std_logic_vector(to_signed(28, 32));
       in_entero      <= std_logic_vector(to_signed(12, 32));
       in_busA        <= std_logic_vector(to_signed(1, 32));
       in_busB        <= std_logic_vector(to_signed(12, 32));
       in_EXE_control <= "0111"; -- MOVT, entero | (ALUop, ALUctr)


      wait;
   end process;

   -- Asserts process
   assert_proc: process
   begin		
   -- out_PC_salto 
   -- out_ALU_bus 
   -- out_ALU_flags 

-- Instrucciones:
   -- RESET
   -- ADD bus, BR=4+12=16 ALU=4+8=12
   -- ADD entero, BR=8+12=20 ALU=4+12=16
   -- SUB bus, BR=8+12=20 ALU=4-8=-4
   -- SUB entero, BR=8+12=20 ALU=4-12=-8
   -- AND bus, BR=28+(-12)=16 ALU=5&&3=1
   -- ORR bus, BR=28+(-12)=16 ALU=5||3=7
   -- EOR bus, BR=28+(-12)=16 ALU=5(xor)3=6
   -- CMP bus, BR=28+(-12)=16 ALU=0 (00)
   -- CMP bus, BR=28+(-12)=16 ALU=0 (01)
   -- CMP bus, BR=28+(-12)=16 ALU=0 (10)
   -- MOV entero, BR=28+(-12)=16 ALU=65536,12=65548
   -- MOVT entero, BR=28+(-12)=16 ALU=1,786432=786433

   -- RESET
   wait for clk_period/2; -- Espera medio ciclo de reloj para sincornizar las comprobaciones
      Assert out_PC_salto = std_logic_vector(to_signed(0, 32))
      report "Salto(0) RST: Resultado deberia ser 0"
      severity ERROR;
      Assert out_ALU_bus = std_logic_vector(to_signed(0, 32))
      report "ALU(0) RST: Resultado deberia ser 0"
      severity ERROR;
      Assert out_ALU_flags = "00" -- (N,Z)
      report "Flags(0) RST: Resultado deberia ser '00' (N,Z)"
      severity ERROR;
      
   -- ADD bus, BR=4+12=16 ALU=4+8=12
   wait for clk_period; 
      Assert out_PC_salto = std_logic_vector(to_signed(16, 32))
      report "Salto(1) ADD: Resultado deberia ser 16"
      severity ERROR;
      Assert out_ALU_bus = std_logic_vector(to_signed(12, 32))
      report "ALU(1) ADD: Resultado deberia ser 12"
      severity ERROR;
      Assert out_ALU_flags = "00" -- (N,Z)
      report "Flags(1) ADD: Resultado deberia ser '00' (N,Z)"
      severity ERROR;
       
   -- ADD entero, BR=8+12=20 ALU=4+12=16
   wait for clk_period; 
      Assert out_PC_salto = std_logic_vector(to_signed(20, 32))
      report "Salto(2) ADD: Resultado deberia ser 20"
      severity ERROR;
      Assert out_ALU_bus = std_logic_vector(to_signed(16, 32))
      report "ALU(2) ADD: Resultado deberia ser 16"
      severity ERROR;
      Assert out_ALU_flags = "00" -- (N,Z)
      report "Flags(2) ADD: Resultado deberia ser '00' (N,Z)"
      severity ERROR;

   -- SUB bus, BR=8+12=20 ALU=4-8=-4
   wait for clk_period; 
      Assert out_PC_salto = std_logic_vector(to_signed(20, 32))
      report "Salto(3) SUB: Resultado deberia ser 20"
      severity ERROR;
      Assert out_ALU_bus = std_logic_vector(to_signed(-4, 32))
      report "ALU(3) SUB: Resultado deberia ser -4"
      severity ERROR;
      Assert out_ALU_flags = "00" -- (N,Z)
      report "Flags(3) SUB: Resultado deberia ser '00' (N,Z)"
      severity ERROR;

   -- SUB entero, BR=8+12=20 ALU=4-12=-8
   wait for clk_period; 
      Assert out_PC_salto = std_logic_vector(to_signed(20, 32))
      report "Salto(4) SUB: Resultado deberia ser 20"
      severity ERROR;
      Assert out_ALU_bus = std_logic_vector(to_signed(-8, 32))
      report "ALU(4) SUB: Resultado deberia ser -8"
      severity ERROR;
      Assert out_ALU_flags = "00" -- (N,Z)
      report "Flags(4) SUB: Resultado deberia ser '00' (N,Z)"
      severity ERROR;

   -- AND bus, BR=28+(-12)=16 ALU=5&&3=1
   wait for clk_period; 
      Assert out_PC_salto = std_logic_vector(to_signed(16, 32))
      report "Salto(5) AND: Resultado deberia ser 16"
      severity ERROR;
      Assert out_ALU_bus = std_logic_vector(to_signed(1, 32))
      report "ALU(5) AND: Resultado deberia ser 1"
      severity ERROR;
      Assert out_ALU_flags = "00" -- (N,Z)
      report "Flags(5) AND: Resultado deberia ser '00' (N,Z)"
      severity ERROR;

   -- ORR bus, BR=28+(-12)=16 ALU=5||3=7
   wait for clk_period; 
      Assert out_PC_salto = std_logic_vector(to_signed(16, 32))
      report "Salto(6) ORR: Resultado deberia ser 16"
      severity ERROR;
      Assert out_ALU_bus = std_logic_vector(to_signed(7, 32))
      report "ALU(6) ORR: Resultado deberia ser 7"
      severity ERROR;
      Assert out_ALU_flags = "00" -- (N,Z)
      report "Flags(6) ORR: Resultado deberia ser '00' (N,Z)"
      severity ERROR;

   -- EOR bus, BR=28+(-12)=16 ALU=5(xor)3=6
   wait for clk_period; 
      Assert out_PC_salto = std_logic_vector(to_signed(16, 32))
      report "Salto(7) EOR: Resultado deberia ser 16"
      severity ERROR;
      Assert out_ALU_bus = std_logic_vector(to_signed(6, 32))
      report "ALU(7) EOR: Resultado deberia ser 6"
      severity ERROR;
      Assert out_ALU_flags = "00" -- (N,Z)
      report "Flags(7) EOR: Resultado deberia ser '00' (N,Z)"
      severity ERROR;

   -- CMP bus, BR=28+(-12)=16 ALU=0 (00)
   wait for clk_period; 
      Assert out_PC_salto = std_logic_vector(to_signed(16, 32))
      report "Salto(8) CMP: Resultado deberia ser 16"
      severity ERROR;
      Assert out_ALU_bus = std_logic_vector(to_signed(0, 32))
      report "ALU(8) CMP: Resultado deberia ser 0"
      severity ERROR;
      Assert out_ALU_flags = "00" -- (N,Z)
      report "Flags(8) CMP: Resultado deberia ser '00' (N,Z)"
      severity ERROR;

   -- CMP bus, BR=28+(-12)=16 ALU=0 (01)
   wait for clk_period; 
      Assert out_PC_salto = std_logic_vector(to_signed(16, 32))
      report "Salto(9) CMP: Resultado deberia ser 16"
      severity ERROR;
      Assert out_ALU_bus = std_logic_vector(to_signed(0, 32))
      report "ALU(9) CMP: Resultado deberia ser 0"
      severity ERROR;
      Assert out_ALU_flags = "01" -- (N,Z)
      report "Flags(9) CMP: Resultado deberia ser '01' (N,Z)"
      severity ERROR;

   -- CMP bus, BR=28+(-12)=16 ALU=0 (10)
   wait for clk_period; 
      Assert out_PC_salto = std_logic_vector(to_signed(16, 32))
      report "Salto(10) CMP: Resultado deberia ser 0"
      severity ERROR;
      Assert out_ALU_bus = std_logic_vector(to_signed(0, 32))
      report "ALU(10) CMP: Resultado deberia ser 0"
      severity ERROR;
      Assert out_ALU_flags = "10" -- (N,Z)
      report "Flags(10) CMP: Resultado deberia ser '10' (N,Z)"
      severity ERROR;

   -- MOV entero, BR=28+12=40 ALU=65536,12=65548
   wait for clk_period; 
      Assert out_PC_salto = std_logic_vector(to_signed(40, 32))
      report "Salto(11) MOV: Resultado deberia ser 40"
      severity ERROR;
      Assert out_ALU_bus = std_logic_vector(to_signed(65548, 32))
      report "ALU(11) MOV: Resultado deberia ser 65548"
      severity ERROR;
      Assert out_ALU_flags = "00" -- (N,Z)
      report "Flags(11) MOV: Resultado deberia ser '00' (N,Z)"
      severity ERROR;

   -- MOVT entero, BR=28+12=40 ALU=1,786432=786433
   wait for clk_period; 
      Assert out_PC_salto = std_logic_vector(to_signed(40, 32))
      report "Salto(12) MOVT: Resultado deberia ser 40"
      severity ERROR;
      Assert out_ALU_bus = std_logic_vector(to_signed(786433, 32))
      report "ALU(12) MOVT: Resultado deberia ser 786433"
      severity ERROR;
      Assert out_ALU_flags = "00" -- (N,Z)
      report "Flags(12) MOVT: Resultado deberia ser '00' (N,Z)"
      severity ERROR;

   wait;
   end process;

END;
