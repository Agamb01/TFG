--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:01:47 01/25/2015
-- Design Name:   
-- Module Name:   C:/TFG/TFG/VHDL/Proc_Evita_Conflictos/TB_MemData.vhd
-- Project Name:  Proc_Evita_Conflictos
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MemData
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
 
ENTITY TB_MemData IS
END TB_MemData;
 
ARCHITECTURE behavior OF TB_MemData IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MemData
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         in_address : IN  std_logic_vector(31 downto 0);
         in_wrdata : IN  std_logic_vector(31 downto 0);
         in_memwrite : IN  std_logic;
         in_memread : IN  std_logic;
         out_rddata : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal in_address : std_logic_vector(31 downto 0) := (others => '0');
   signal in_wrdata : std_logic_vector(31 downto 0) := (others => '0');
   signal in_memwrite : std_logic := '0';
   signal in_memread : std_logic := '0';

 	--Outputs
   signal out_rddata : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MemData PORT MAP (
          clk => clk,
          rst => rst,
          in_address => in_address,
          in_wrdata => in_wrdata,
          in_memwrite => in_memwrite,
          in_memread => in_memread,
          out_rddata => out_rddata
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
      rst <= '0';
      -- hold reset state for 100 ns.
    wait for 100 ns;	
      rst <= '1';
      
    --RESET
      in_address <= (others=>'0');
      in_wrdata <= (others=>'0');
      in_memwrite <= '0'; 
      in_memread <= '0';
    wait for clk_period;

    --Read reg 9
      in_address <= std_logic_vector(to_unsigned(9, 32));
      in_wrdata <= std_logic_vector(to_signed(0, 32));
      in_memwrite <= '0'; 
      in_memread <= '1';
    wait for clk_period;

    --Read reg 18
      in_address <= std_logic_vector(to_unsigned(18, 32));
      in_wrdata <= std_logic_vector(to_signed(0, 32));
      in_memwrite <= '0'; 
      in_memread <= '1';
    wait for clk_period;
      
    --Read reg 27
      in_address <= std_logic_vector(to_unsigned(27, 32));
      in_wrdata <= std_logic_vector(to_signed(0, 32));
      in_memwrite <= '0'; 
      in_memread <= '1';
    wait for clk_period;
      
    --Write 121 a reg 9
      in_address <= std_logic_vector(to_unsigned(9, 32));
      in_wrdata <= std_logic_vector(to_signed(121, 32));
      in_memwrite <= '1'; 
      in_memread <= '0';
    wait for clk_period;
      
    --Write 12321 a reg 21
      in_address <= std_logic_vector(to_unsigned(21, 32));
      in_wrdata <= std_logic_vector(to_signed(12321, 32));
      in_memwrite <= '1'; 
      in_memread <= '0';
    wait for clk_period;

    --Read reg 9
      in_address <= std_logic_vector(to_unsigned(9, 32));
      in_wrdata <= std_logic_vector(to_signed(0, 32));
      in_memwrite <= '0'; 
      in_memread <= '1';
    wait for clk_period;
      
    --Read reg 21
      in_address <= std_logic_vector(to_unsigned(21, 32));
      in_wrdata <= std_logic_vector(to_signed(0, 32));
      in_memwrite <= '0'; 
      in_memread <= '1';
    wait for clk_period;
      
      
      
    wait;
   end process;
   
   -- Asserts process
   assert_proc: process
   begin		
 
    wait for 100 ns;	
    wait for clk_period/2; 
    --RESET
      ASSERT out_rddata = std_logic_vector(to_signed(0, 32))
      REPORT "Ciclo(0): Resultado esperado 0"
      SEVERITY ERROR;
    wait for clk_period;
      
    --Read reg 9
      ASSERT out_rddata = std_logic_vector(to_signed(9, 32))
      REPORT "Ciclo(1): Resultado esperado 9"
      SEVERITY ERROR;
    wait for clk_period;
      
    --Read reg 18
      ASSERT out_rddata = std_logic_vector(to_signed(18, 32))
      REPORT "Ciclo(2): Resultado esperado 18"
      SEVERITY ERROR;
    wait for clk_period;
      
    --Read reg 27
      ASSERT out_rddata = std_logic_vector(to_signed(27, 32))
      REPORT "Ciclo(3): Resultado esperado 27"
      SEVERITY ERROR;
    wait for clk_period;
      
    --Write 121 a reg 9
      ASSERT out_rddata = std_logic_vector(to_signed(0, 32))
      REPORT "Ciclo(4): Resultado esperado 0"
      SEVERITY ERROR;
    wait for clk_period;
      
    --Write 12321 a reg 21
      ASSERT out_rddata = std_logic_vector(to_signed(0, 32))
      REPORT "Ciclo(5): Resultado esperado 0"
      SEVERITY ERROR;
    wait for clk_period;
      
    --Read reg 9
      ASSERT out_rddata = std_logic_vector(to_signed(121, 32))
      REPORT "Ciclo(6): Resultado esperado 121"
      SEVERITY ERROR;
    wait for clk_period;

    --Read reg 21
      ASSERT out_rddata = std_logic_vector(to_signed(12321, 32))
      REPORT "Ciclo(7): Resultado esperado 12321"
      SEVERITY ERROR;
    wait for clk_period;
      
      
    wait;
   end process;


END;
