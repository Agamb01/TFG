--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:25:55 02/11/2015
-- Design Name:   
-- Module Name:   D:/TFG/TFG/VHDL/Votador_forzar/TB_Sistema_Tolerancia_2.vhd
-- Project Name:  Votador_forzar
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Sistema_Tolerancia_2
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
 
use work.IDs_regs_fallos.all;
 
ENTITY TB_Sistema_Tolerancia_2 IS
END TB_Sistema_Tolerancia_2;
 
ARCHITECTURE behavior OF TB_Sistema_Tolerancia_2 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Sistema_Tolerancia_2
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         ID_const : IN  t_ID_reg;
         fallo_in : IN  t_Fallo;
         dato_in : IN  std_logic_vector(31 downto 0);
         dato_out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal ID_const : t_ID_reg := ID_Reg_PC;
   signal fallo_in : t_Fallo := (ID => ID_0,
                              reg => (others=>'0'),
                              tipo => '0',
                              bool => (others=>'0'),
                              dato => (others=>'0'));
   signal dato_in : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal dato_out : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Sistema_Tolerancia_2 PORT MAP (
          clk => clk,
          rst => rst,
          ID_const => ID_const,
          fallo_in => fallo_in,
          dato_in => dato_in,
          dato_out => dato_out
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
      ID_const <= ID_Reg_PC;   
      rst <= '0';
    wait for 100 ns;	
      rst <= '1';
-- Comienzo
      
    --Stimulus
      fallo_in <= 
         (  ID => ID_0,
            reg => (others=>'0'),
            tipo => '0',
            bool => (others=>'0'),
            dato => (others=>'0')
         );
      dato_in <= std_logic_vector(to_signed(12, 32));
    wait for clk_period;
    --Assert
    assert dato_out = std_logic_vector(to_signed(12, 32))
       report "No injeccion de fallo"
       severity ERROR;
    wait for clk_period;
    
    --Stimulus
      fallo_in <= 
         (  ID => ID_Reg_Inst,
            reg => "111",
            tipo => '1',
            bool => "00000000" & "00000000" & "00000000" & "11111111",
            dato => "00000000" & "00000000" & "00000000" & "00000111"
         );
      dato_in <= "00000000" & "00000000" & "00000000" & "00011101";
    wait for clk_period;
    --Assert
    assert dato_out = "00000000" & "00000000" & "00000000" & "00011101"
       report "Fallo Invertir en registro equivocado"
       severity ERROR;
    wait for clk_period;
    
    --Stimulus
      fallo_in <= 
         (  ID => ID_Reg_PC,
            reg => "111",
            tipo => '1',
            bool => "00000000" & "00000000" & "00000000" & "11111111",
            dato => "00000000" & "00000000" & "00000000" & "00000111"
         );
      dato_in <= "00000000" & "00000000" & "00000000" & "00011101";
    wait for clk_period;
    --Assert
    assert dato_out = "00000000" & "00000000" & "00000000" & "11100010"
       report "Fallo Invertir en registro correcto 3 fallos"
       severity ERROR;
    wait for clk_period;

    --Stimulus
      fallo_in <= 
         (  ID => ID_Reg_Inst,
            reg => "100",
            tipo => '1',
            bool => "00000000" & "00000000" & "00000000" & "11111111",
            dato => "00000000" & "00000000" & "00000000" & "00000111"
         );
      dato_in <= "00000000" & "00000000" & "00000000" & "00011101";
    wait for clk_period;
    --Assert
    assert dato_out = "00000000" & "00000000" & "00000000" & "00011101"
       report "Fallo Invertir en registro correcto 1 fallo"
       severity ERROR;
    wait for clk_period;

    --Stimulus
      fallo_in <= 
         (  ID => ID_Reg_Inst,
            reg => "111",
            tipo => '0',
            bool => "00000000" & "00000000" & "00000000" & "11111111",
            dato => "00000000" & "00000000" & "00000000" & "00000111"
         );
      dato_in <= "00000000" & "00000000" & "00000000" & "00011101";
    wait for clk_period;
    --Assert
    assert dato_out = "00000000" & "00000000" & "00000000" & "00011101"
       report "Fallo Forzar en registro equivocado"
       severity ERROR;
    wait for clk_period;
    
    --Stimulus
      fallo_in <= 
         (  ID => ID_Reg_PC,
            reg => "111",
            tipo => '0',
            bool => "00000000" & "00000000" & "00000000" & "11111111",
            dato => "00000000" & "00000000" & "00000000" & "00000111"
         );
      dato_in <= "00000000" & "00000000" & "00000000" & "00011101";
    wait for clk_period;
    --Assert
    assert dato_out = "00000000" & "00000000" & "00000000" & "00000111"
       report "Fallo Forzar en registro correcto 3 fallos"
       severity ERROR;
    wait for clk_period;

    --Stimulus
      fallo_in <= 
         (  ID => ID_Reg_Inst,
            reg => "100",
            tipo => '0',
            bool => "00000000" & "00000000" & "00000000" & "11111111",
            dato => "00000000" & "00000000" & "00000000" & "00000111"
         );
      dato_in <= "00000000" & "00000000" & "00000000" & "00011101";
    wait for clk_period;
    --Assert
    assert dato_out = "00000000" & "00000000" & "00000000" & "00011101"
       report "Fallo Invertir en registro correcto 1 fallo"
       severity ERROR;
    wait for clk_period;


      wait;
   end process;

END;
