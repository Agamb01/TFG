--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:17:41 12/09/2014
-- Design Name:   
-- Module Name:   C:/TFG/TFG/VHDL/Processor/TB_ExtensionSigno.vhd
-- Project Name:  Processor
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ExtensioSigno
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
 
ENTITY TB_ExtensionSigno IS
END TB_ExtensionSigno;
 
ARCHITECTURE behavior OF TB_ExtensionSigno IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ExtensioSigno
    PORT(
         in_inst : IN  std_logic_vector(31 downto 0);
         out_entero : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal in_inst : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal out_entero : std_logic_vector(31 downto 0);
 
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ExtensioSigno PORT MAP (
          in_inst => in_inst,
          out_entero => out_entero
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      
--ADD R1, R1, #4 --Entero esperado: 4
      in_inst(31 downto 16) <= "1111001000000001";
      in_inst(15 downto 0) <= "0000000100000100";
      wait for 100 ns;	

--SUB R1, R1, #8 --Entero esperado: 8
      in_inst(31 downto 16) <= "1111001010100001";
      in_inst(15 downto 0) <= "0000000100001000";
      wait for 100 ns;	

--MOV R1, #13 --Entero esperado: 13
      in_inst(31 downto 16) <= "1111001000000000";
      in_inst(15 downto 0) <= "0000000100001101";
      wait for 100 ns;	

--MOVT R1, #15 --Entero esperado: 15
      in_inst(31 downto 16) <= "1111001011000000";
      in_inst(15 downto 0) <= "0000000100001111";
      wait for 100 ns;	

--LDR R1, R2, #0 --Entero esperado: 0
      in_inst(31 downto 16) <= "1111100010010001";
      in_inst(15 downto 0) <= "0010000000000000";
      wait for 100 ns;	
      
--STR R2, R3, #2 --Entero esperado: 2
      in_inst(31 downto 16) <= "1111100010000010";
      in_inst(15 downto 0) <= "0011000000000010"; 
      wait for 100 ns;	

--B #<+256> --Entero esperado: 768
      in_inst(31 downto 16) <= "1111000000000000";
      in_inst(15 downto 0) <= "1001000110000000"; 
      wait for 100 ns;	
      
      wait;
   end process;

END;
