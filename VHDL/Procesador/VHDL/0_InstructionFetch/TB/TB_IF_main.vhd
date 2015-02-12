--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:02:52 01/08/2015
-- Design Name:   
-- Module Name:   C:/TFG/TFG/VHDL/Proc_Evita_Conflictos/TB_IF_main.vhd
-- Project Name:  Proc_Evita_Conflictos
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: IF_main
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

ENTITY TB_IF_main IS
END TB_IF_main;
 
ARCHITECTURE behavior OF TB_IF_main IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT IF_main
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         in_paradas : IN  tipo_paradas;
         in_nula : IN  std_logic;
         out_paradas : OUT  tipo_paradas;
         out_nula : OUT  std_logic;
         out_valid_data : OUT  std_logic;
         in_pc : IN  std_logic_vector(31 downto 0);
         out_pc : OUT  std_logic_vector(31 downto 0);
         out_inst : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal in_paradas : tipo_paradas := (others => (others => '0'));
   signal in_nula : std_logic := '0';
   signal in_pc : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal out_paradas : tipo_paradas;
   signal out_nula : std_logic;
   signal out_valid_data : std_logic;
   signal out_pc : std_logic_vector(31 downto 0);
   signal out_inst : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: IF_main PORT MAP (
          clk => clk,
          rst => rst,
          in_paradas => in_paradas,
          in_nula => in_nula,
          out_paradas => out_paradas,
          out_nula => out_nula,
          out_valid_data => out_valid_data,
          in_pc => in_pc,
          out_pc => out_pc,
          out_inst => out_inst
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
   -- Testbench para modulo funcional
   stim_proc2: process
   begin		
      -- hold reset state for 100 ns.
      rst <= '0';
      in_pc(31 downto 0) <= (others => '1');
      wait for 100 ns;	
      rst <= '1';
      
      -- Instruccion 0
      in_pc(31 downto 0) <= std_logic_vector(to_unsigned(0, 32));
      
   wait for clk_period;
      assert out_inst = "11110010010000000000000100011000" 
      report "PC0: Error en instruccion"
      severity ERROR;
      assert out_pc = std_logic_vector(to_unsigned(4, 32)) 
      report "PC0: Error en PC"
      severity ERROR;
      -- Instruccion 1      
      in_pc(31 downto 0) <= std_logic_vector(to_unsigned(4, 32));
   wait for clk_period;   
      assert out_inst = "11110010110000000000000100000000" 
      report "PC4: Error en instruccion"
      severity ERROR;
      assert out_pc = std_logic_vector(to_unsigned(8, 32)) 
      report "PC4: Error en PC"
      severity ERROR;
      -- Instruccion 2   
      in_pc(31 downto 0) <= std_logic_vector(to_unsigned(8, 32));
   wait for clk_period;
      assert out_inst = "11110010010000000000001000011111" 
      report "PC8: Error en instruccion"
      severity ERROR;
      assert out_pc = std_logic_vector(to_unsigned(12, 32))
      report "PC8: Error en PC"
      severity ERROR;
      -- Instruccion 3
      in_pc(31 downto 0) <= std_logic_vector(to_unsigned(12, 32));
   wait for clk_period;
      assert out_inst = "11110010110000000000001000000000" 
      report "PC12: Error en instruccion"
      severity ERROR;
      assert out_pc = std_logic_vector(to_unsigned(16, 32)) 
      report "PC12: Error en PC"
      severity ERROR;
      -- Instruccion 4
      in_pc(31 downto 0) <= std_logic_vector(to_unsigned(16, 32));
   wait for clk_period;
      assert out_inst = "11101011000000010000001100000010" 
      report "PC16: Error en instruccion"
      severity ERROR;
      assert out_pc = std_logic_vector(to_unsigned(20, 32)) 
      report "PC16: Error en PC"
      severity ERROR;
      -- Instruccion 5
      in_pc(31 downto 0) <= std_logic_vector(to_unsigned(20, 32));
   wait for clk_period;
      assert out_inst = "11101011101000100000010000000001" 
      report "PC20: Error en instruccion"
      severity ERROR;
      assert out_pc = std_logic_vector(to_unsigned(24, 32)) 
      report "PC20: Error en PC"
      severity ERROR;
      -- Instruccion 6
      in_pc(31 downto 0) <= std_logic_vector(to_unsigned(24, 32));
   wait for clk_period;
      assert out_inst = "11110111111111111011111111110100" 
      report "PC24: Error en instruccion"
      severity ERROR;
      assert out_pc = std_logic_vector(to_unsigned(28, 32)) 
      report "PC24: Error en PC"
      severity ERROR;
      -- Instruccion 7
      in_pc(31 downto 0) <= std_logic_vector(to_unsigned(28, 32));
   wait for clk_period;
      assert out_inst = "00000000000000000000000000000000" 
      report "PC28: Error en instruccion"
      severity ERROR;
      assert out_pc = std_logic_vector(to_unsigned(32, 32)) 
      report "PC28: Error en PC"
      severity ERROR;
   wait;
   end process;
END;
