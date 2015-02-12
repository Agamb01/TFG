--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:35:43 11/27/2014
-- Design Name:   
-- Module Name:   D:/TFG/TFG/VHDL/Processor/TB_MemInstruction.vhd
-- Project Name:  Processor
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MemInstruction
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
 
ENTITY TB_MemInstruction1 IS
END TB_MemInstruction1;
 
   ARCHITECTURE behavior OF TB_MemInstruction1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MemInstruction1
    PORT(
         in_pc : IN  std_logic_vector(31 downto 0);
         out_inst : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal in_pc : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal out_inst : std_logic_vector(31 downto 0);
 
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MemInstruction1 PORT MAP (
          in_pc => in_pc,
          out_inst => out_inst
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      in_pc(31 downto 0) <= (others => '1');
      wait for 100 ns;	
      









      
      -- Instruccion 0
      in_pc(31 downto 0) <= std_logic_vector(to_unsigned(0, 32));
   wait for clk_period;
      assert out_inst = "11110010010000000000000100011000" 
      report "Error en instruccion 0"
      severity ERROR;
      -- Instruccion 1      
      in_pc(31 downto 0) <= std_logic_vector(to_unsigned(4, 32));
   wait for clk_period;   
      assert out_inst = "11110010010000000000001000011111" 
      report "Error en instruccion 1"
      severity ERROR;
      -- Instruccion 2   
      in_pc(31 downto 0) <= std_logic_vector(to_unsigned(8, 32));
   wait for clk_period;
      assert out_inst = "11101011000000010000001100000010" 
      report "Error en instruccion 2"
      severity ERROR;
      -- Instruccion 3
      in_pc(31 downto 0) <= std_logic_vector(to_unsigned(12, 32));
   wait for clk_period;
      assert out_inst = "11101011101000100000010000000001" 
      report "Error en instruccion 3"
      severity ERROR;
      -- Instruccion 4
      in_pc(31 downto 0) <= std_logic_vector(to_unsigned(16, 32));
   wait for clk_period;
      assert out_inst = "11110111111111111011111111110110" 
      report "Error en instruccion 4"
      severity ERROR;
      -- Instruccion 5
      in_pc(31 downto 0) <= std_logic_vector(to_unsigned(20, 32));
   wait for clk_period;
      assert out_inst = "00000000000000000000000000000000" 
      report "Error en instruccion 5"
      severity ERROR;
      -- Instruccion 6
      in_pc(31 downto 0) <= std_logic_vector(to_unsigned(24, 32));
   wait for clk_period;
      assert out_inst = "00000000000000000000000000000000" 
      report "Error en instruccion 6"
      severity ERROR;
      -- Instruccion 7
      in_pc(31 downto 0) <= std_logic_vector(to_unsigned(28, 32));
   wait for clk_period;
      assert out_inst = "00000000000000000000000000000000" 
      report "Error en instruccion 7"
      severity ERROR;
      -- Instruccion 15
      in_pc(31 downto 0) <= std_logic_vector(to_unsigned(60, 32));
   wait for clk_period;
      assert out_inst = "00000000000000000000000000000000" 
      report "Error en instruccion 15"
      severity ERROR;
      
   wait;
   end process;

END;
