--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:27:15 12/10/2014
-- Design Name:   
-- Module Name:   C:/TFG/TFG/VHDL/Processor/TB_RegisterBank.vhd
-- Project Name:  Processor
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RegisterBank
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
--USE ieee.numeric_std.ALL;
 
ENTITY TB_RegisterBank IS
END TB_RegisterBank;
 
ARCHITECTURE behavior OF TB_RegisterBank IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RegisterBank
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         in_regA : IN  std_logic_vector(3 downto 0);
         in_regB : IN  std_logic_vector(3 downto 0);
         in_regW : IN  std_logic_vector(3 downto 0);
         in_busW : IN  std_logic_vector(31 downto 0);
         in_WREnable : IN  std_logic;
         out_busA : OUT  std_logic_vector(31 downto 0);
         out_busB : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal in_regA : std_logic_vector(3 downto 0) := (others => '0');
   signal in_regB : std_logic_vector(3 downto 0) := (others => '0');
   signal in_regW : std_logic_vector(3 downto 0) := (others => '0');
   signal in_busW : std_logic_vector(31 downto 0) := (others => '0');
   signal in_WREnable : std_logic := '0';

 	--Outputs
   signal out_busA : std_logic_vector(31 downto 0);
   signal out_busB : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RegisterBank PORT MAP (
          clk => clk,
          rst => rst,
          in_regA => in_regA,
          in_regB => in_regB,
          in_regW => in_regW,
          in_busW => in_busW,
          in_WREnable => in_WREnable,
          out_busA => out_busA,
          out_busB => out_busB
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
      wait for 100 ns;	
      rst <= '1';
      wait for clk_period*10;
      
      --Deshabilitar escritura
      in_busW <= (others=>'0');
      in_regW <= (others=>'0');
      in_WREnable <= '0';
      
      -- Prueba lectura
   -- Leer registros 0 y 1
      in_regA <= "0000";
      in_regB <= "0001";
      wait for clk_period;
   -- Leer registros 2 y 3
      in_regA <= "0010";
      in_regB <= "0011";
      wait for clk_period;
   -- Leer registros 4 y 5
      in_regA <= "0100";
      in_regB <= "0101";
      wait for clk_period;
   -- Leer registros 6 y 7
      in_regA <= "0110";
      in_regB <= "0111";
      wait for clk_period;
   -- Leer registros 8 y 9
      in_regA <= "1000";
      in_regB <= "1001";
      wait for clk_period;
   -- Leer registros 10 y 11
      in_regA <= "1010";
      in_regB <= "1011";
      wait for clk_period;
   -- Leer registros 12 y 13
      in_regA <= "1100";
      in_regB <= "1101";
      wait for clk_period;
   -- Leer registros 14 y 15
      in_regA <= "1110";
      in_regB <= "1111";
      wait for clk_period;
      
      --Fin prueba lectura
      in_regA <= "0000";
      in_regB <= "0000";
      wait for clk_period;
      
      --Prueba escritura
   -- Escribir "1" en el registro 1
      in_busW(31 downto 3) <= (others=>'0');
      in_busW(2 downto 0) <= "111";
      in_regW <= "0001";
      in_WREnable <= '1';
      wait for clk_period;
   -- Escribir "2" en el registro 2 y leer de registro 1
      in_busW(31 downto 3) <= (others=>'0');
      in_busW(2 downto 0) <= "110";
      in_regW <= "0010";
      in_WREnable <= '1';
      in_regA <= "0001";
      in_regB <= "0001";
      wait for clk_period;
   -- Escribir "3" en el registro 3 y leer de registro 2
      in_busW(31 downto 3) <= (others=>'0');
      in_busW(2 downto 0) <= "100";
      in_regW <= "0011";
      in_WREnable <= '1';
      in_regA <= "0010";
      in_regB <= "0010";
      wait for clk_period;
   -- Leer registro 3
      in_busW(31 downto 3) <= (others=>'0');
      in_busW(2 downto 0) <= "100";
      in_regW <= "0011";
      in_WREnable <= '0';
      in_regA <= "0011";
      in_regB <= "0011";
      wait for clk_period;
   -- Escribir "4" en el registro 4 y leer de registro 4
      in_busW(31 downto 3) <= (others=>'0');
      in_busW(2 downto 0) <= "001";
      in_regW <= "0100";
      in_WREnable <= '1';
      in_regA <= "0100";
      in_regB <= "0100";
      wait for clk_period;
   -- Leer de registro 4
      in_busW(31 downto 3) <= (others=>'0');
      in_busW(2 downto 0) <= "100";
      in_regW <= "0100";
      in_WREnable <= '0';
      in_regA <= "0100";
      in_regB <= "0100";
      wait for clk_period;
      
      wait;
   end process;

END;
