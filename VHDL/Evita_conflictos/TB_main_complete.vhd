--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:25:32 12/19/2014
-- Design Name:   
-- Module Name:   C:/TFG/TFG/VHDL/Evita_conflictos/TB_main_complete.vhd
-- Project Name:  Evita_conflictos
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
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
library work;
use work.my_package.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TB_main_complete IS
END TB_main_complete;
 
ARCHITECTURE behavior OF TB_main_complete IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT main
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         in_nada : IN  std_logic;
         in_paradas : in tipo_paradas;
         out_nada : OUT  std_logic_vector(0 to 4);
         out_paradas : out set_tipo_paradas;
         out_enable : OUT  std_logic_vector(0 to 4)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal in_nada : std_logic := '0';
   signal in_paradas : tipo_paradas;

 	--Outputs
   signal out_nada : std_logic_vector(0 to 4);
   signal out_paradas : set_tipo_paradas;
   signal out_enable : std_logic_vector(0 to 4);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: main PORT MAP (
          clk => clk,
          rst => rst,
          in_nada => in_nada,
          in_paradas => in_paradas,
          out_nada => out_nada,
          out_paradas => out_paradas,
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
      rst <= '0';
      in_paradas <= ("11", "11", "11", "11", "11");
      in_nada <= '1';
   wait for 100 ns;
      rst <= '1';
   wait for clk_period*10;
      -- insert stimulus here 

-- Primera instruccion (200 ns)
      in_paradas <= ("00", "01", "00", "10", "00");
      in_nada <= '0';
   wait for clk_period;
-- Tres "NADA"s
      in_paradas <= ("11", "11", "11", "11", "11");
      in_nada <= '1';
   wait for clk_period;
      in_paradas <= ("11", "11", "11", "11", "11");
      in_nada <= '1';
   wait for clk_period;
      in_paradas <= ("11", "11", "11", "11", "11");
      in_nada <= '1';
   wait for clk_period;
-- Segunda instruccion
      in_paradas <= ("00", "00", "00", "00", "00");
      in_nada <= '0';
   wait for clk_period;
-- Más "NADA"s, se acabó el programa
      in_paradas <= ("11", "11", "11", "11", "11");
      in_nada <= '1';
   wait for clk_period;

      wait;
   end process;

   -- Assert process
   assert_proc: process
   begin		

   wait for 100 ns;
   wait for clk_period*10;
-- Ciclo 0: Entra primera instuccion  
   wait for clk_period;
   
-- Ciclo 1: Primera instruccion entra en fase0, 
--          se comprueban las salidas de la fase0
   --Instruccion 1
      Assert out_paradas(1) = ("01", "00", "10", "00", "00") 
      report "Ciclo 1, Fase0->Fase1, Paradas(1)"
      severity ERROR;

      Assert out_nada = "01111" 
      report "Ciclo 1, NADA"
      severity ERROR;

      Assert out_enable = "10000" 
      report "Ciclo 1, ENABLE"
      severity ERROR;

   wait for clk_period;
   
-- Ciclo 2: Primera instruccion entra en fase1, 
--          se comprueban las salidas de la fase1
--          En esta fase se para un ciclo
   --Instruccion 1
      Assert out_paradas(2) = ("00", "10", "00", "00", "00") 
      report "Ciclo 2, Fase1->Fase2, Paradas(2)"
      severity ERROR;
      
      Assert out_nada = "11111" 
      report "Ciclo 2, NADA"
      severity ERROR;

      Assert out_enable = "01000" 
      report "Ciclo 2, ENABLE"
      severity ERROR;

   wait for clk_period;

-- Ciclo 3: Instruccion parada un ciclo
   --Instruccion 1
      Assert out_paradas(2) = ("00", "10", "00", "00", "00") 
      report "Ciclo 3, Fase1->Fase2, Paradas(2)"
      severity ERROR;

      Assert out_nada = "10111" 
      report "Ciclo 3, NADA"
      severity ERROR;
      
      Assert out_enable = "01000" 
      report "Ciclo 3, ENABLE"
      severity ERROR;

   wait for clk_period;

-- Ciclo 4: Instruccion 1 entra en fase2

   --Instruccion 1
      Assert out_paradas(3) = ("10", "00", "00", "00", "00") 
      report "Ciclo 4, Fase2->Fase3, Paradas(3)"
      severity ERROR;

      Assert out_nada = "11011" 
      report "Ciclo 4, NADA"
      severity ERROR;

      Assert out_enable = "00100" 
      report "Ciclo 4, ENABLE"
      severity ERROR;

   wait for clk_period;

-- Ciclo 5: Instruccion 1 entra y se para en fase3 dos ciclos
--          Instruccion 2 entra en fase0
 
   --Instruccion 1
      Assert out_paradas(4) = ("00", "00", "00", "00", "00") 
      report "Ciclo 5, Fase3->Fase4, Paradas(4)"
      severity ERROR;
   --Instruccion 2
      Assert out_paradas(1) = ("00", "00", "00", "00", "00") 
      report "Ciclo 5, Fase0->Fase1, Paradas(1)"
      severity ERROR;
      
      Assert out_nada = "01111" 
      report "Ciclo 5, NADA"
      severity ERROR;

      Assert out_enable = "10010" 
      report "Ciclo 5, ENABLE"
      severity ERROR;
      
   wait for clk_period;

-- Ciclo 6: Instruccion 1 parada en fase3 dos ciclos (1er ciclo)
--          Instruccion 2 entra en fase2

   --Instruccion 1
      Assert out_paradas(4) = ("00", "00", "00", "00", "00") 
      report "Ciclo 6, Fase3->Fase4, Paradas(4)"
      severity ERROR;
   --Instruccion 2
      Assert out_paradas(2) = ("00", "00", "00", "00", "00") 
      report "Ciclo 6, Fase1->Fase2, Paradas(2)"
      severity ERROR;

      Assert out_nada = "10111" 
      report "Ciclo 6, NADA"
      severity ERROR;

      Assert out_enable = "01010" 
      report "Ciclo 6, ENABLE"
      severity ERROR;
   wait for clk_period;

-- Ciclo 7: Instruccion 1 parada en fase3 dos ciclos (2o ciclo)
--          Instruccion 2 entra en fase3

   --Instruccion 1
      Assert out_paradas(4) = ("00", "00", "00", "00", "00") 
      report "Ciclo 7, Fase3->Fase4, Paradas(4)"
      severity ERROR;
   --Instruccion 2
      Assert out_paradas(3) = ("00", "00", "00", "00", "00") 
      report "Ciclo 7, Fase2->Fase3, Paradas(3)"
      severity ERROR;

      Assert out_nada = "11001" 
      report "Ciclo 7, NADA"
      severity ERROR;

      Assert out_enable = "00110" 
      report "Ciclo 7, ENABLE"
      severity ERROR;
   wait for clk_period;

-- Ciclo 8: Instruccion 1 entra en fase4
--          Instruccion 2 entra en fase0

      Assert out_paradas(5) = ("00", "00", "00", "00", "00") 
      report "Ciclo 8, Fase4->Salida, Paradas(5)"
      severity ERROR;
   --Instruccion 2
      Assert out_paradas(4) = ("00", "00", "00", "00", "00") 
      report "Ciclo 8, Fase3->Fase4, Paradas(4)"
      severity ERROR;

      Assert out_nada = "11100" 
      report "Ciclo 8, NADA"
      severity ERROR;

      Assert out_enable = "00011" 
      report "Ciclo 4, ENABLE"
      severity ERROR;
      
   wait for clk_period;

-- Ciclo 9:
   --Instruccion 2
      Assert out_paradas(5) = ("00", "00", "00", "00", "00") 
      report "Ciclo 7, Fase4->Salida, Paradas(5)"
      severity ERROR;

      Assert out_nada = "11110" 
      report "Ciclo 9, NADA"
      severity ERROR;

      Assert out_enable = "00001" 
      report "Ciclo 4, ENABLE"
      severity ERROR;
      
   wait for clk_period;

-- Ciclo 10:
      Assert out_nada = "11111" 
      report "Ciclo 10, NADA"
      severity ERROR;

      Assert out_enable = "00000" 
      report "Ciclo 4, ENABLE"
      severity ERROR;
      
   wait for clk_period;

   wait;
   end process;


END;
