--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:30:55 01/26/2015
-- Design Name:   
-- Module Name:   C:/TFG/TFG/VHDL/Proc_Evita_Conflictos/TB_MEM_main.vhd
-- Project Name:  Proc_Evita_Conflictos
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MEM_main
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
 
library work;
   use work.my_package.all;

ENTITY TB_MEM_main IS
END TB_MEM_main;
 
ARCHITECTURE behavior OF TB_MEM_main IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MEM_main
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         in_paradas : IN  tipo_paradas;
         in_nula : IN  std_logic;
         out_paradas : OUT  tipo_paradas;
         out_nula : OUT  std_logic;
         out_valid_data : OUT  std_logic;
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
   signal in_paradas : tipo_paradas := (others => (others => '0'));
   signal in_nula : std_logic := '0';
   signal in_ALUbus : std_logic_vector(31 downto 0) := (others => '0');
   signal in_busB : std_logic_vector(31 downto 0) := (others => '0');
   signal in_flags : std_logic_vector(1 downto 0) := (others => '0');
   signal in_MEM_control : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal out_paradas : tipo_paradas;
   signal out_nula : std_logic;
   signal out_valid_data : std_logic;
   signal out_MEMbus : std_logic_vector(31 downto 0);
   signal out_BRctr : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MEM_main PORT MAP (
          clk => clk,
          rst => rst,
          in_paradas => in_paradas,
          in_nula => in_nula,
          out_paradas => out_paradas,
          out_nula => out_nula,
          out_valid_data => out_valid_data,
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
 
   rst_process :process
   begin
		rst <= '0';
     wait for 100 ns;	
		rst <= '1';
		wait;
   end process;

   -- Stimulus process 1
   stim_proc1: process
   begin		

   wait for 100 ns;	
      
   -- Instruccion Normal, Test propagación
      in_paradas <= ("00", "01", "10", "11", "00");
      in_nula <= '0';
   wait for clk_period;

      assert out_paradas = ("01", "10", "11", "00", "00") 
      report "Test propagacion, paradas"
      severity ERROR;
      
      assert out_nula = '0'
      report "Test propagacion, nula"
      severity ERROR;
      
      assert out_valid_data = '1'
      report "Test propagacion, valid_data"
      severity ERROR;
      
      -- Instruccion 1 
      -- Instruccion Normal, Test paradas
      in_paradas <= ("11", "10", "10", "10", "10");
      in_nula <= '0';
   wait for clk_period; -- Parada 0

      assert out_paradas = ("10", "10", "10", "10", "00") 
      report "Test paradas(0), paradas"
      severity ERROR;
      
      assert out_nula = '0'
      report "Test paradas(0), nula"
      severity ERROR;
      
      assert out_valid_data = '0'
      report "Test paradas(0), valid_data"
      severity ERROR;
      
   wait for clk_period; -- Parada 1 
      
      assert out_paradas = ("10", "10", "10", "10", "00") 
      report "Test paradas(1), paradas"
      severity ERROR;
      
      assert out_nula = '0'
      report "Test paradas(1), nula"
      severity ERROR;
      
      assert out_valid_data = '0'
      report "Test paradas(1), valid_data"
      severity ERROR;
      
      -- Instruccion 2  
      
   wait for clk_period; -- Parada 2
   
      assert out_paradas = ("10", "10", "10", "10", "00") 
      report "Test paradas(2), paradas"
      severity ERROR;
      
      assert out_nula = '0'
      report "Test paradas(2), nula"
      severity ERROR;
      
      assert out_valid_data = '0'
      report "Test paradas(2), valid_data"
      severity ERROR;
      
      -- Instruccion 3 -- Comprobar que los datos no varían debido a la pausa
      in_paradas <= ("00", "01", "00", "00", "00");
      in_nula <= '1';

   wait for clk_period; -- Parada 3
      assert out_paradas = ("10", "10", "10", "10", "00") 
      report "Test paradas(3), paradas"
      severity ERROR;
      
      assert out_nula = '0'
      report "Test paradas(3), nula"
      severity ERROR;
      
      assert out_valid_data = '1'
      report "Test paradas(3), valid_data"
      severity ERROR;
      
      -- Instruccion 4
      in_paradas <= ("00", "01", "00", "00", "00");
      in_nula <= '1';

   wait for clk_period; -- Salida de datos, cambia la información y se procesan los nuevos datos
      assert out_paradas = ("01", "00", "00", "00", "00") 
      report "Test paradas(4), paradas"
      severity ERROR;
      
      assert out_nula = '1'
      report "Test paradas(4), nula"
      severity ERROR;
      
      assert out_valid_data = '0'
      report "Test paradas(4), valid_data"
      severity ERROR;

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
