--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:40:42 12/18/2014
-- Design Name:   
-- Module Name:   C:/TFG/TFG/VHDL/Evita_conflictos/TB_modulo.vhd
-- Project Name:  Evita_conflictos
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: modulo
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
 
LIBRARY work;
use work.my_package.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TB_modulo IS
END TB_modulo;
 
ARCHITECTURE behavior OF TB_modulo IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT modulo
    PORT(
         clk         : IN  std_logic;
         rst         : IN  std_logic;
         in_paradas  : IN  tipo_paradas;
         in_nada     : IN  std_logic;
         out_paradas : OUT  tipo_paradas;
         out_nada    : OUT  std_logic;
         out_enable  : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal in_paradas : tipo_paradas := (others => (others => '0'));
   signal in_nada : std_logic := '0';

 	--Outputs
   signal out_paradas : tipo_paradas;
   signal out_nada : std_logic;
   signal out_enable : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: modulo PORT MAP (
          clk => clk,
          rst => rst,
          in_paradas => in_paradas,
          in_nada => in_nada,
          out_paradas => out_paradas,
          out_nada => out_nada,
          out_enable => out_enable
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
      wait for 100 ns;	
      rst <= '0';
      wait for clk_period*10;
      rst <= '1';
      -- insert stimulus here 


-- Simulación del camino que recorre una instrucción por "diferentes" modulos
-- Fase 0
      in_paradas <= ("00", "01", "00", "10", "00");
      in_nada <= '0';
   wait for clk_period;

      assert out_paradas = ("01", "00", "10", "00", "00") 
      report "Error en out_paradas, ciclo 0"
      severity ERROR;
      
      assert out_nada = '0'
      report "Error en out_nada, ciclo 0"
      severity ERROR;
      
      assert out_enable = '1'
      report "Error en out_enable, ciclo 0"
      severity ERROR;
   
   
-- Fase 1
      in_paradas <= ("01", "00", "10", "00", "00");
      in_nada <= '0';
   wait for clk_period;
            
      assert out_paradas = ("00", "10", "00", "00", "00") 
      report "Error en out_paradas, ciclo 1"
      severity ERROR;

      assert out_nada = '0'
      report "Error en out_nada, ciclo 1"
      severity ERROR;
      
      assert out_enable = '1'
      report "Error en out_enable, ciclo 1"
      severity ERROR;
   
   --Espera un ciclo, lleva detrás un "NADA", da igual el valor de in_paradas
      in_paradas <= ("11", "11", "11", "11", "11");
      in_nada <= '1';
   wait for clk_period;
   
      assert out_paradas = ("00", "10", "00", "00", "00") 
      report "Error en out_paradas, ciclo 2"
      severity ERROR;

      assert out_nada = '0'
      report "Error en out_nada, ciclo 2"
      severity ERROR;
      
      assert out_enable = '1'
      report "Error en out_enable, ciclo 2"
      severity ERROR;


-- Fase 2
      in_paradas <= ("00", "10", "00", "00", "00");
      in_nada <= '0';
   wait for clk_period;

      assert out_paradas = ("10", "00", "00", "00", "00") 
      report "Error en out_paradas, ciclo 3"
      severity ERROR;
      
      assert out_nada = '0'
      report "Error en out_nada, ciclo 3"
      severity ERROR;
      
      assert out_enable = '1'
      report "Error en out_enable, ciclo 3"
      severity ERROR;


-- Fase 3
      in_paradas <= ("10", "00", "00", "00", "00");
      in_nada <= '0';
   wait for clk_period;

      assert out_paradas = ("00", "00", "00", "00", "00") 
      report "Error en out_paradas, ciclo 4"
      severity ERROR;

      assert out_nada = '0'
      report "Error en out_nada, ciclo 4"
      severity ERROR;
      
      assert out_enable = '1'
      report "Error en out_enable, ciclo 4"
      severity ERROR;

  -- Espera dos ciclo, lleva detrás un "NADA", da igual el valor de in_paradas
  -- Se ejecuta la instrucción actual sin sobreescribir los registros de 
  -- control de "paradas" ni el registro "nada"
      in_paradas <= ("11", "11", "11", "11", "11");
      in_nada <= '1';
   wait for clk_period;

      assert out_paradas = ("00", "00", "00", "00", "00") 
      report "Error en out_paradas, ciclo 5"
      severity ERROR;

      assert out_nada = '0'
      report "Error en out_nada, ciclo 5"
      severity ERROR;
      
      assert out_enable = '1'
      report "Error en out_enable, ciclo 5"
      severity ERROR;

      in_paradas <= ("11", "11", "11", "11", "11");
      in_nada <= '1';
   wait for clk_period;
      
      assert out_paradas = ("00", "00", "00", "00", "00") 
      report "Error en out_paradas, ciclo 6"
      severity ERROR;

      assert out_nada = '0'
      report "Error en out_nada, ciclo 6"
      severity ERROR;
      
      assert out_enable = '1'
      report "Error en out_enable, ciclo 6"
      severity ERROR;


-- Fase 4
      in_paradas <= ("00", "00", "00", "00", "00");
      in_nada <= '0';
   wait for clk_period;
   
      assert out_paradas = ("00", "00", "00", "00", "00") 
      report "Error en out_paradas, ciclo 7"
      severity ERROR;

      assert out_nada = '0'
      report "Error en out_nada, ciclo 7"
      severity ERROR;
      
      assert out_enable = '1'
      report "Error en out_enable, ciclo 7"
      severity ERROR;

-- Instrucción completamente ejecutada
      in_paradas <= ("00", "00", "00", "00", "11");
      in_nada <= '1';
   wait for clk_period;

      assert out_paradas = ("00", "00", "00", "11", "00") 
      report "Error en out_paradas, ciclo 8"
      severity ERROR;

      assert out_nada = '1'
      report "Error en out_nada, ciclo 8"
      severity ERROR;
      
      assert out_enable = '0'
      report "Error en out_enable, ciclo 8"
      severity ERROR;
         
      wait;
   end process;

END;
