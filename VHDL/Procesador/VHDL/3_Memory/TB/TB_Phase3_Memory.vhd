--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:26:58 01/25/2015
-- Design Name:   
-- Module Name:   C:/TFG/TFG/VHDL/Proc_Evita_Conflictos/TB_Phase3_Memory.vhd
-- Project Name:  Proc_Evita_Conflictos
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Phase3_Memory
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
 
ENTITY TB_Phase3_Memory IS
END TB_Phase3_Memory;
 
ARCHITECTURE behavior OF TB_Phase3_Memory IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Phase3_Memory
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         in_ALUbus : IN  std_logic_vector(31 downto 0);
         in_busB : IN  std_logic_vector(31 downto 0);
         in_flags : IN  std_logic_vector(1 downto 0);
         out_MEMbus : OUT  std_logic_vector(31 downto 0);
         out_BRctr : OUT  std_logic;
         in_MEM_control : IN  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal in_ALUbus : std_logic_vector(31 downto 0) := (others => '0');
   signal in_busB : std_logic_vector(31 downto 0) := (others => '0');
   signal in_flags : std_logic_vector(1 downto 0) := (others => '0');
   signal in_MEM_control : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal out_MEMbus : std_logic_vector(31 downto 0);
   signal out_BRctr : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Phase3_Memory PORT MAP (
          clk => clk,
          rst => rst,
          in_ALUbus => in_ALUbus,
          in_busB => in_busB,
          in_flags => in_flags,
          out_MEMbus => out_MEMbus,
          out_BRctr => out_BRctr,
          in_MEM_control => in_MEM_control
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
   -- Reset process 100 ns
   rst_process :process
   begin
      rst <= '0';
    wait for 100 ns;	
      rst <= '1';
    wait;
   end process;
 

   -- Stimulus1 process (Memoria de datos)
   stim1_proc: process
   begin		
   
   -- in_ALUbus      : IN  std_logic_vector(31 downto 0);
   -- in_busB        : IN  std_logic_vector(31 downto 0);
   -- in_flags       : IN  std_logic_vector(1 downto 0);
   -- in_MEM_control : IN  std_logic_vector(5 downto 0)
   
      -- hold reset state for 100 ns.
    wait for 100 ns;	
      
    --RESET
      in_ALUbus <= (others=>'0');
      in_busB <= (others=>'0');
      in_flags <= "00";
      in_MEM_control <= "000"&"0"&"00"; -- "conditional branch"&"incond branch"&"memRD,memWR"
      
--Pruebas acceso a Memoria
    wait for clk_period;
--    Report "Values: Inicio pruebas de memoria";
    --Read reg 9
      in_ALUbus <= std_logic_vector(to_unsigned(9, 32));
      in_busB <= std_logic_vector(to_signed(0, 32));
      in_MEM_control <= "000" & "0" & "10";
    wait for clk_period;

    --Read reg 18
      in_ALUbus <= std_logic_vector(to_unsigned(18, 32));
      in_busB <= std_logic_vector(to_signed(0, 32));
      in_MEM_control <= "000" & "0" & "10";
    wait for clk_period;
      
    --Read reg 27
      in_ALUbus <= std_logic_vector(to_unsigned(27, 32));
      in_busB <= std_logic_vector(to_signed(0, 32));
      in_MEM_control <= "000" & "0" & "10";
    wait for clk_period;
      
    --Write 121 a reg 9
      in_ALUbus <= std_logic_vector(to_unsigned(9, 32));
      in_busB <= std_logic_vector(to_signed(121, 32));
      in_flags <= "00";
      in_MEM_control <= "000" & "0" & "01";
    wait for clk_period;
      
    --Write 12321 a reg 21
      in_ALUbus <= std_logic_vector(to_unsigned(21, 32));
      in_busB <= std_logic_vector(to_signed(12321, 32));
      in_MEM_control <= "000" & "0" & "01";
    wait for clk_period;

    --Read reg 9
      in_ALUbus <= std_logic_vector(to_unsigned(9, 32));
      in_busB <= std_logic_vector(to_signed(0, 32));
      in_MEM_control <= "000" & "0" & "10";
    wait for clk_period;
      
    --Read reg 21
      in_ALUbus <= std_logic_vector(to_unsigned(21, 32));
      in_busB <= std_logic_vector(to_signed(0, 32));
      in_MEM_control <= "000" & "0" & "10";
    wait for clk_period;
    
-- Fin prueba memoria
      in_ALUbus <= std_logic_vector(to_unsigned(0, 32));
      in_busB <= std_logic_vector(to_signed(0, 32));
      in_MEM_control <= "000" & "0" & "00";
    
--Pruebas de Salto
    wait for 20ns;
--    Report "Values: Inicio pruebas de salto";
    
   -- Sin Salto
      in_flags <= "00";
      in_MEM_control <= "000" & "0" & "00";
    wait for clk_period;
    
   -- Salto incondicional
      in_flags <= "00";
      in_MEM_control <= "000" & "1" & "00";
    wait for clk_period;

   -- Salto condicional positivo (A>B)
      in_flags <= "00";
      in_MEM_control <= "001" & "0" & "00";
    wait for clk_period;

   -- Salto condicional zero (A=B)
      in_flags <= "01";
      in_MEM_control <= "011" & "0" & "00";
    wait for clk_period;

   -- Salto condicional negativo (A<B)
      in_flags <= "10";
      in_MEM_control <= "101" & "0" & "00";
    wait for clk_period;

    wait;
   end process;
   
   -- Asserts1 process (Memoria de datos)
   assert1_proc: process
   begin		
 
    wait for 100 ns;	
    wait for clk_period/2;
    
    --RESET
      ASSERT out_MEMbus = std_logic_vector(to_signed(0, 32))
      REPORT "Ciclo(0): Resultado esperado 0"
      SEVERITY ERROR;
    wait for clk_period;
      
--    Report "Assert: Inicio pruebas de memoria";
    --Read reg 9
      ASSERT out_MEMbus = std_logic_vector(to_signed(9, 32))
      REPORT "Ciclo(1): Resultado esperado 9"
      SEVERITY ERROR;
    wait for clk_period;
      
    --Read reg 18
      ASSERT out_MEMbus = std_logic_vector(to_signed(18, 32))
      REPORT "Ciclo(2): Resultado esperado 18"
      SEVERITY ERROR;
    wait for clk_period;
      
    --Read reg 27
      ASSERT out_MEMbus = std_logic_vector(to_signed(27, 32))
      REPORT "Ciclo(3): Resultado esperado 27"
      SEVERITY ERROR;
   -- Read Sin salto
      ASSERT out_BRctr = '0'
      REPORT "Ciclo(3): Salto esperado 0"
      SEVERITY ERROR;

    wait for clk_period;
      
    --Write 121 a reg 9
      ASSERT out_MEMbus = std_logic_vector(to_signed(0, 32))
      REPORT "Ciclo(4): Resultado esperado 0"
      SEVERITY ERROR;
   -- Write Sin salto
      ASSERT out_BRctr = '0'
      REPORT "Ciclo(4): Salto esperado 0"
      SEVERITY ERROR;
    wait for clk_period;
      
    --Write 12321 a reg 21
      ASSERT out_MEMbus = std_logic_vector(to_signed(0, 32))
      REPORT "Ciclo(5): Resultado esperado 0"
      SEVERITY ERROR;
    wait for clk_period;
      
    --Read reg 9
      ASSERT out_MEMbus = std_logic_vector(to_signed(121, 32))
      REPORT "Ciclo(6): Resultado esperado 121"
      SEVERITY ERROR;
    wait for clk_period;

    --Read reg 21
      ASSERT out_MEMbus = std_logic_vector(to_signed(12321, 32))
      REPORT "Ciclo(7): Resultado esperado 12321"
      SEVERITY ERROR;
    wait for clk_period;
    
-- Fin prueba memoria
    
--Pruebas de Salto
    wait for 20ns;
--    Report "Assert: Inicio pruebas de salto";

   -- Sin salto
      ASSERT out_BRctr = '0'
      REPORT "Ciclo(8): Salto esperado 0"
      SEVERITY ERROR;
    wait for clk_period;
    
   -- Salto incondicional
      ASSERT out_BRctr = '1'
      REPORT "Ciclo(9): Salto esperado 1"
      SEVERITY ERROR;
    wait for clk_period;

   -- Salto condicional positivo (A>B)
      ASSERT out_BRctr = '1'
      REPORT "Ciclo(10): Salto esperado 1"
      SEVERITY ERROR;
    wait for clk_period;

   -- Salto condicional zero (A=B)
      ASSERT out_BRctr = '1'
      REPORT "Ciclo(11): Salto esperado 1"
      SEVERITY ERROR;
    wait for clk_period;

   -- Salto condicional negativo (A<B)
      ASSERT out_BRctr = '1'
      REPORT "Ciclo(12): Salto esperado 1"
      SEVERITY ERROR;
    wait for clk_period;

    wait;
   end process;

END;
