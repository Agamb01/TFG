--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:50:59 01/09/2015
-- Design Name:   
-- Module Name:   C:/TFG/TFG/VHDL/Proc_Evita_Conflictos/TB_ALU.vhd
-- Project Name:  Proc_Evita_Conflictos
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
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
 
ENTITY TB_ALU IS
END TB_ALU;
 
ARCHITECTURE behavior OF TB_ALU IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         in_A : IN  std_logic_vector(31 downto 0);
         in_B : IN  std_logic_vector(31 downto 0);
         in_op : IN  std_logic_vector(2 downto 0);
         out_R : OUT  std_logic_vector(31 downto 0);
         out_f : OUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    
   signal clk : std_logic;
   --Inputs
   signal in_A : std_logic_vector(31 downto 0) := (others => '0');
   signal in_B : std_logic_vector(31 downto 0) := (others => '0');
   signal in_op : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal out_R : std_logic_vector(31 downto 0);
   signal out_f : std_logic_vector(1 downto 0);
   -- No clocks detected in port list. Replace clk below with 
   -- appropriate port name 
 
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          in_A => in_A,
          in_B => in_B,
          in_op => in_op,
          out_R => out_R,
          out_f => out_f
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

   wait for 100ns;
   
   -- TEST SUMA POSITIVO
      in_A <= std_logic_vector(to_signed(7, 32));
      in_B <= std_logic_vector(to_signed(42, 32));
      in_op <= "000";
   wait for clk_period/2;
      assert out_R = std_logic_vector(to_signed(49, 32))
      report "Test ADD(+)"
      severity ERROR;
   wait for clk_period/2;

   -- TEST SUMA CERO
      in_A <= std_logic_vector(to_signed(42, 32));
      in_B <= std_logic_vector(to_signed(-42, 32));
      in_op <= "000";
   wait for clk_period/2;
      assert out_R = std_logic_vector(to_signed(0, 32))
      report "Test ADD(0)"
      severity ERROR;
   wait for clk_period/2;
 
   -- TEST SUMA CERO
      in_A <= std_logic_vector(to_signed(42, 32));
      in_B <= std_logic_vector(to_signed(-49, 32));
      in_op <= "000";
   wait for clk_period/2;
      assert out_R = std_logic_vector(to_signed(-7, 32))
      report "Test ADD(-)"
      severity ERROR;
   wait for clk_period/2;

   -- TEST RESTA POSITIVO
      in_A <= std_logic_vector(to_signed(42, 32));
      in_B <= std_logic_vector(to_signed(7, 32));
      in_op <= "001";
   wait for clk_period/2;
      assert out_R = std_logic_vector(to_signed(35, 32))
      report "Test SUB(+)"
      severity ERROR;
   wait for clk_period/2;

   -- TEST RESTA CERO
      in_A <= std_logic_vector(to_signed(42, 32));
      in_B <= std_logic_vector(to_signed(42, 32));
      in_op <= "001";
   wait for clk_period/2;
      assert out_R = std_logic_vector(to_signed(0, 32))
      report "Test SUB(0)"
      severity ERROR;
   wait for clk_period/2;

   -- TEST RESTA NEGATIVO
      in_A <= std_logic_vector(to_signed(42, 32));
      in_B <= std_logic_vector(to_signed(49, 32));
      in_op <= "001";
   wait for clk_period/2;
      assert out_R = std_logic_vector(to_signed(-7, 32))
      report "Test SUB(-)"
      severity ERROR;
   wait for clk_period/2;

   -- TEST MOV
      in_A <= "11111111"&"11111111"&"11111111"&"11111111";
      in_B <= "00000000"&"00000000"&"00000000"&"00000000";
      in_op <= "010";
   wait for clk_period/2;
      assert out_R = "11111111"&"11111111"&"00000000"&"00000000"
      report "Test MOV"
      severity ERROR;
   wait for clk_period/2;
   
   -- TEST MOVT
      in_A <= "11111111"&"11111111"&"11111111"&"11111111";
      in_B <= "00000000"&"00000000"&"00000000"&"00000000";
      in_op <= "011";
   wait for clk_period/2;
      assert out_R = "00000000"&"00000000"&"11111111"&"11111111"
      report "Test MOVT"
      severity ERROR;
   wait for clk_period/2;

   -- TEST AND
      in_A <= "11111111"&"11111111"&"11111111"&"11111111";
      in_B <= "00000000"&"00000000"&"00000000"&"00000000";
      in_op <= "100";
   wait for clk_period/2;
      assert out_R = "00000000"&"00000000"&"00000000"&"00000000"
      report "Test AND(1)"
      severity ERROR;
   wait for clk_period/2;
   
   -- TEST AND
      in_A <= "11111111"&"11111111"&"11111111"&"11111111";
      in_B <= "11111111"&"11111111"&"00000000"&"00000000";
      in_op <= "100";
   wait for clk_period/2;
      assert out_R = "11111111"&"11111111"&"00000000"&"00000000"
      report "Test AND(2)"
      severity ERROR;
   wait for clk_period/2;

   -- TEST OR
      in_A <= "11111111"&"11111111"&"11111111"&"11111111";
      in_B <= "00000000"&"00000000"&"00000000"&"00000000";
      in_op <= "101";
   wait for clk_period/2;
      assert out_R = "11111111"&"11111111"&"11111111"&"11111111"
      report "Test OR(1)"
      severity ERROR;
   wait for clk_period/2;

   -- TEST OR
      in_A <= "00000000"&"00000000"&"11111111"&"11111111";
      in_B <= "00000000"&"00000000"&"00000000"&"00000000";
      in_op <= "101";
   wait for clk_period/2;
      assert out_R = "00000000"&"00000000"&"11111111"&"11111111"
      report "Test OR(2)"
      severity ERROR;
   wait for clk_period/2;
   
   -- TEST EOR
      in_A <= "11111111"&"11111111"&"00000000"&"00000000";
      in_B <= "00000000"&"00000000"&"00000000"&"00000000";
      in_op <= "110";
   wait for clk_period/2;
      assert out_R = "11111111"&"11111111"&"00000000"&"00000000"
      report "Test EOR(1)"
      severity ERROR;
   wait for clk_period/2;

   -- TEST EOR
      in_A <= "11111111"&"11111111"&"11111111"&"11111111";
      in_B <= "11111111"&"11111111"&"00000000"&"00000000";
      in_op <= "110";
   wait for clk_period/2;
      assert out_R = "00000000"&"00000000"&"11111111"&"11111111"
      report "Test EOR(2)"
      severity ERROR;
   wait for clk_period/2;

   -- TEST CMP POSITIVO
      in_A <= std_logic_vector(to_signed(24, 32));
      in_B <= std_logic_vector(to_signed(16, 32));
      in_op <= "111";
   wait for clk_period/2;
      assert out_f = "00"
      report "Test CMP(+)"
      severity ERROR;
   wait for clk_period/2;

   -- TEST CMP CERO
      in_A <= std_logic_vector(to_signed(32, 32));
      in_B <= std_logic_vector(to_signed(32, 32));
      in_op <= "111";
   wait for clk_period/2;
      assert out_f = "01"
      report "Test CMP(0)"
      severity ERROR;
   wait for clk_period/2;
   
   -- TEST CMP NEGATIVO
      in_A <= std_logic_vector(to_signed(32, 32));
      in_B <= std_logic_vector(to_signed(63, 32));
      in_op <= "111";
   wait for clk_period/2;
      assert out_f = "10"
      report "Test CMP(-)"
      severity ERROR;
   wait for clk_period/2;

   wait;
   end process;

END;
