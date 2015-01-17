--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:28:05 01/12/2015
-- Design Name:   
-- Module Name:   C:/TFG/TFG/VHDL/Proc_Evita_Conflictos/TB_Phase1_InstructionDecode.vhd
-- Project Name:  Proc_Evita_Conflictos
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Phase1_InstructionDecode
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
 
ENTITY TB_Phase1_InstructionDecode IS
END TB_Phase1_InstructionDecode;
 
ARCHITECTURE behavior OF TB_Phase1_InstructionDecode IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Phase1_InstructionDecode
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         in_inst : IN  std_logic_vector(31 downto 0);
         out_busA : OUT  std_logic_vector(31 downto 0);
         out_busB : OUT  std_logic_vector(31 downto 0);
         out_regW : OUT  std_logic_vector(3 downto 0);
         out_entero : OUT  std_logic_vector(31 downto 0);
         in_WREnable : IN  std_logic;
         in_regW : IN  std_logic_vector(3 downto 0);
         in_busW : IN  std_logic_vector(31 downto 0);
         out_WB_control : OUT  std_logic_vector(11 downto 0);
         out_MEM_control : OUT  std_logic_vector(9 downto 0);
         out_EXE_control : OUT  std_logic_vector(9 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal in_inst : std_logic_vector(31 downto 0) := (others => '0');
   signal in_WREnable : std_logic := '0';
   signal in_regW : std_logic_vector(3 downto 0) := (others => '0');
   signal in_busW : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal out_busA : std_logic_vector(31 downto 0);
   signal out_busB : std_logic_vector(31 downto 0);
   signal out_regW : std_logic_vector(3 downto 0);
   signal out_entero : std_logic_vector(31 downto 0);
   signal out_WB_control : std_logic_vector(11 downto 0);
   signal out_MEM_control : std_logic_vector(9 downto 0);
   signal out_EXE_control : std_logic_vector(9 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Phase1_InstructionDecode PORT MAP (
          clk => clk,
          rst => rst,
          in_inst => in_inst,
          out_busA => out_busA,
          out_busB => out_busB,
          out_regW => out_regW,
          out_entero => out_entero,
          in_WREnable => in_WREnable,
          in_regW => in_regW,
          in_busW => in_busW,
          out_WB_control => out_WB_control,
          out_MEM_control => out_MEM_control,
          out_EXE_control => out_EXE_control
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
      -- hold reset state for 100 ns.
      rst <= '0';
      in_inst <= (others=>'0');
      in_WREnable <= '0';
      in_regW <= (others=>'0');
      in_busW <= (others=>'0');
   wait for 100 ns;	
      
   wait for clk_period/2;
      rst <= '1';
   
   -- Instruccion 0, MOV R1, #24
      in_inst <= "11110010010000000000000100011000";
      
   wait for clk_period/2;
   -- Comprobar salida para instruccion 0
   -- out_busA = X -- No importa, pero debería salir 0
   -- out_busB = X -- No importa, pero debería salir 8
   -- out_regW = 1
   -- out_entero = 24
      assert out_busA = std_logic_vector(to_signed(0, 32))
      report "I0: Bus A erroneo"
      severity WARNING;
      assert out_busB = std_logic_vector(to_signed(8, 32))
      report "I0: Bus B erroneo"
      severity WARNING;
      assert out_regW = std_logic_vector(to_unsigned(1, 4))
      report "I0: Registro destino erroneo"
      severity ERROR;
      assert out_entero = std_logic_vector(to_signed(24, 32))
      report "I0: Entero erroneo"
      severity ERROR;
      
      
   wait for clk_period/2;
   -- Instruccion 4, ADD R3, R1, R2
      in_inst <= "11101011000000010000001100000010";

   wait for clk_period/2;
   -- Comprobar salida para instruccion 4
   -- out_busA = 1
   -- out_busB = 2
   -- out_regW = 3
   -- out_entero = X -- No importa, pero debería salir 0
      assert out_busA = std_logic_vector(to_signed(1, 32))
      report "I4: Bus A erroneo"
      severity ERROR;
      assert out_busB = std_logic_vector(to_signed(2, 32))
      report "I4: Bus B erroneo"
      severity ERROR;
      assert out_regW = std_logic_vector(to_unsigned(3, 4))
      report "I4: Registro destino erroneo"
      severity ERROR;
      assert out_entero = std_logic_vector(to_signed(0, 32))
      report "I4: Entero erroneo"
      severity WARNING;


   wait for clk_period/2;
   -- Instruccion 5, SUB R4, R2, R1
      in_inst <= "11101011101000100000010000000001";
     
   wait for clk_period/2;
   -- Comprobar salida para instruccion 5
   -- out_busA = 2
   -- out_busB = 1
   -- out_regW = 4
   -- out_entero = X -- No importa, pero debería salir 0
      assert out_busA = std_logic_vector(to_signed(2, 32))
      report "I5: Bus A erroneo"
      severity ERROR;
      assert out_busB = std_logic_vector(to_signed(1, 32))
      report "I5: Bus B erroneo"
      severity ERROR;
      assert out_regW = std_logic_vector(to_unsigned(4, 4))
      report "I5: Registro destino erroneo"
      severity ERROR;
      assert out_entero = std_logic_vector(to_signed(0, 32))
      report "I5: Entero erroneo"
      severity WARNING;

   wait for clk_period/2;
   -- Instruccion 6, B #<-24>
      in_inst <= "11110111111111111011111111110100";
     
   wait for clk_period/2;
   -- Comprobar salida para instruccion 5
   -- out_busA = X -- No importa, pero debería salir 15
   -- out_busB = X -- No importa, pero debería salir 4
   -- out_regW = X -- No importa, pero debería salir 15
   -- out_entero = -24
      assert out_busA = std_logic_vector(to_signed(15, 32))
      report "I6: Bus A erroneo"
      severity WARNING;
      assert out_busB = std_logic_vector(to_signed(4, 32))
      report "I6: Bus B erroneo"
      severity WARNING;
      assert out_regW = std_logic_vector(to_unsigned(15, 4))
      report "I6: Registro destino erroneo"
      severity WARNING;
      assert out_entero = std_logic_vector(to_signed(-24, 32))
      report "I6: Entero erroneo"
      severity ERROR;

   wait for clk_period/2;
-- Prueba de escritura/lectura de registros
      rst <= '1';
      in_inst <= "00000000"&"00000111"&"00000000"&"00001011";
   wait for clk_period/2;
   -- Escribir -7 en el registro 7
      in_WREnable <= '1';
      in_regW <= "0111";
      in_busW <= std_logic_vector(to_signed(-7, 32));
   wait for clk_period;
      -- Escribir -11 en el registro 11
      in_WREnable <= '1';
      in_regW <= "1011";
      in_busW <= std_logic_vector(to_signed(-11, 32));
   wait for clk_period;
      -- Instruccion para leer registros 7 y 11
      -- RegA = "0111"
      -- RegB = "1011"
      in_WREnable <= '0';
      in_inst <= "00000000"&"00000111"&"00000000"&"00001011";
   wait for clk_period;
   -- Comprobar salida de registros
   -- out_busA = -7
   -- out_busB = -11
   -- out_regW = X -- No importa, pero debería salir 0
   -- out_entero = X -- No importa, pero debería salir 0
      assert out_busA = std_logic_vector(to_signed(-7, 32))
      report "Lectura: Bus A erroneo"
      severity ERROR;
      assert out_busB = std_logic_vector(to_signed(-11, 32))
      report "Lectura: Bus B erroneo"
      severity ERROR;
      assert out_regW = std_logic_vector(to_unsigned(0, 4))
      report "Lectura: Registro destino erroneo"
      severity WARNING;
      assert out_entero = std_logic_vector(to_signed(0, 32))
      report "Lectura: Entero erroneo"
      severity ERROR;
   wait;
   end process;

END;
