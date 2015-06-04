--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:47:34 02/09/2015
-- Design Name:   
-- Module Name:   D:/TFG/TFG/VHDL/Votador_forzar/TB_Sistema_Tolerancia.vhd
-- Project Name:  Votador_forzar
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Sistema_Tolerancia
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

ENTITY TB_Sistema_Tolerancia_POST IS
END TB_Sistema_Tolerancia_POST;
 
ARCHITECTURE behavior OF TB_Sistema_Tolerancia_POST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Sistema_Tolerancia_POST
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         forzar_fallo : IN  force_regs;
         data_in : IN  std_logic_vector(31 downto 0);
         data_out : OUT  std_logic_vector(31 downto 0)
--         data_out_2 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal forzar_fallo : force_regs := (others => (others => '0') );
   signal data_in : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal data_out : std_logic_vector(31 downto 0);
--   signal data_out_2 : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Sistema_Tolerancia_POST PORT MAP (
          clk => clk,
          rst => rst,
          forzar_fallo => forzar_fallo,
          data_in => data_in,
          data_out => data_out
--          data_out_2 => data_out_2
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

--   type force_regs is array (0 to N_regs-1) of STD_LOGIC_VECTOR (size_fallo-1 downto 0); 
--     ( A(01N), B(01N), C(01N) )

   -- Assert process
   assert_proc: process
   begin		
    wait for 10 ns;	
    wait for clk_period/2; -- sincronizar tiempo para realizar asserts

      assert data_out = std_logic_vector(to_signed(0, 32)) severity error;
--      assert data_out_2 = std_logic_vector(to_signed(0, 32)) severity error;
    wait for 90 ns;	
    wait for clk_period;
      assert data_out = std_logic_vector(to_signed(32, 32)) severity error;
--      assert data_out_2 = std_logic_vector(to_signed(32, 32)) severity error;
    wait for clk_period;
      assert data_out = std_logic_vector(to_signed(31, 32)) severity error;
--      assert data_out_2 = std_logic_vector(to_signed(31, 32)) severity error;
    wait for clk_period;
      assert data_out = std_logic_vector(to_signed(55, 32)) severity error;
--      assert data_out_2 = std_logic_vector(to_signed(55, 32)) severity error;

   -- Pruebas fallo data_A
    wait for clk_period;
      assert data_out = std_logic_vector(to_signed(55, 32)) severity error;
--      assert data_out_2 = std_logic_vector(to_signed(55, 32)) severity error;
    wait for clk_period;
      assert data_out = std_logic_vector(to_signed(55, 32)) severity error;
--      assert data_out_2 = std_logic_vector(to_signed(55, 32)) severity error;
    wait for clk_period;
      assert data_out = std_logic_vector(to_signed(55, 32)) severity error;
--      assert data_out_2 = std_logic_vector(to_signed(55, 32)) severity error;

   -- Pruebas fallo data_B
    wait for clk_period;
      assert data_out = std_logic_vector(to_signed(55, 32)) severity error;
--      assert data_out_2 = std_logic_vector(to_signed(55, 32)) severity error;
    wait for clk_period;
      assert data_out = std_logic_vector(to_signed(55, 32)) severity error;
--      assert data_out_2 = std_logic_vector(to_signed(55, 32)) severity error;
    wait for clk_period;
      assert data_out = std_logic_vector(to_signed(55, 32)) severity error;
--      assert data_out_2 = std_logic_vector(to_signed(55, 32)) severity error;
      wait;

   -- Pruebas fallo data_C
    wait for clk_period;
      assert data_out = std_logic_vector(to_signed(55, 32)) severity error;
--      assert data_out_2 = std_logic_vector(to_signed(55, 32)) severity error;
    wait for clk_period;
      assert data_out = std_logic_vector(to_signed(55, 32)) severity error;
--      assert data_out_2 = std_logic_vector(to_signed(55, 32)) severity error;
    wait for clk_period;
      assert data_out = std_logic_vector(to_signed(55, 32)) severity error;
--      assert data_out_2 = std_logic_vector(to_signed(55, 32)) severity error;

   -- Pruebas fallo data_A y data_B
    wait for clk_period;
      assert data_out /= std_logic_vector(to_signed(55, 32)) severity error;
--      assert data_out_2 /= std_logic_vector(to_signed(55, 32)) severity error;
    wait for clk_period;
      assert data_out /= std_logic_vector(to_signed(55, 32)) severity error;
--      assert data_out_2 /= std_logic_vector(to_signed(55, 32)) severity error;
    wait for clk_period;
      assert data_out /= std_logic_vector(to_signed(55, 32)) severity error;
--      assert data_out_2 /= std_logic_vector(to_signed(55, 32)) severity error;

   end process;
   
      -- Stimulus process
   stim_proc: process
   begin		
--Reset
      rst <= '0';
      data_in <= std_logic_vector(to_signed(0, 32));
      forzar_fallo <= ("000","000","000");
    wait for 100 ns;	
      rst <= '1';
      data_in <= std_logic_vector(to_signed(32, 32));
      forzar_fallo <= ("000","000","000");
    wait for clk_period;
      data_in <= std_logic_vector(to_signed(31, 32));
      forzar_fallo <= ("000","000","000");
    wait for clk_period;
      data_in <= std_logic_vector(to_signed(55, 32));
      forzar_fallo <= ("000","000","000");

   -- Pruebas fallo data_A
    wait for clk_period;
      data_in <= std_logic_vector(to_signed(55, 32));
      forzar_fallo <= ("001","000","000");
    wait for clk_period;
      data_in <= std_logic_vector(to_signed(55, 32));
      forzar_fallo <= ("010","000","000");
    wait for clk_period;
      data_in <= std_logic_vector(to_signed(55, 32));
      forzar_fallo <= ("100","000","000");

   -- Pruebas fallo data_B
    wait for clk_period;
      data_in <= std_logic_vector(to_signed(55, 32));
      forzar_fallo <= ("000","001","000");
    wait for clk_period;
      data_in <= std_logic_vector(to_signed(55, 32));
      forzar_fallo <= ("000","010","000");
    wait for clk_period;
      data_in <= std_logic_vector(to_signed(55, 32));
      forzar_fallo <= ("000","100","000");

   -- Pruebas fallo data_C
    wait for clk_period;
      data_in <= std_logic_vector(to_signed(55, 32));
      forzar_fallo <= ("000","000","001");
    wait for clk_period;
      data_in <= std_logic_vector(to_signed(55, 32));
      forzar_fallo <= ("000","000","010");
    wait for clk_period;
      data_in <= std_logic_vector(to_signed(55, 32));
      forzar_fallo <= ("000","000","100");

   -- Pruebas fallos varios
    wait for clk_period;
      data_in <= std_logic_vector(to_signed(55, 32));
      forzar_fallo <= ("001","100","000");
    wait for clk_period;
      data_in <= std_logic_vector(to_signed(55, 32));
      forzar_fallo <= ("010","010","000");
    wait for clk_period;
      data_in <= std_logic_vector(to_signed(55, 32));
      forzar_fallo <= ("100","001","001");

    wait;
   end process;

END;
