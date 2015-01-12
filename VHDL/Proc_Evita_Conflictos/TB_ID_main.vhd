--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:23:24 01/12/2015
-- Design Name:   
-- Module Name:   C:/TFG/TFG/VHDL/Proc_Evita_Conflictos/TB_ID_main.vhd
-- Project Name:  Proc_Evita_Conflictos
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ID_main
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
 
ENTITY TB_ID_main IS
END TB_ID_main;
 
ARCHITECTURE behavior OF TB_ID_main IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ID_main
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         in_paradas : IN  tipo_paradas;
         in_nula : IN  std_logic;
         out_paradas : OUT  tipo_paradas;
         out_nula : OUT  std_logic;
         out_valid_data : OUT  std_logic;
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
   signal in_paradas : tipo_paradas := (others => (others=>'0'));
   signal in_nula : std_logic := '0';
   signal in_inst : std_logic_vector(31 downto 0) := (others => '0');
   signal in_WREnable : std_logic := '0';
   signal in_regW : std_logic_vector(3 downto 0) := (others => '0');
   signal in_busW : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal out_paradas : tipo_paradas;
   signal out_nula : std_logic;
   signal out_valid_data : std_logic;
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
   uut: ID_main PORT MAP (
          clk => clk,
          rst => rst,
          in_paradas => in_paradas,
          in_nula => in_nula,
          out_paradas => out_paradas,
          out_nula => out_nula,
          out_valid_data => out_valid_data,
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
 

   -- Stimulus process 1
   stim_proc1: process
   begin		
      -- hold reset state for 100 ns.
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

   -- Stimulus process 2
   stim_proc2: process
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

   wait for clk_period/2;

      
   wait;
   end process;


END;
