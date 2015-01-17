----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:17:41 01/14/2015 
-- Design Name: 
-- Module Name:    main - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main is
   Port(
      clk, rst : in STD_LOGIC;
      input_A : STD_LOGIC_VECTOR(0 downto 0);
      input_B : STD_LOGIC_VECTOR(0 downto 0);
      output_Z : out STD_LOGIC_VECTOR(0 downto 0)
   );
end main;

architecture Behavioral of main is
  
   constant data_size : integer := 1;
  
  
   component comparador is
      Generic (
         size : INTEGER := 32
      );
      Port ( 
         A : in  STD_LOGIC_VECTOR(size-1 downto 0);
         B : in  STD_LOGIC_VECTOR(size-1 downto 0);
         Z : out  STD_LOGIC_VECTOR(size-1 downto 0)
      );
   end component;

   component Reg_Async is
      Generic (
         size : INTEGER := 32
      );
      Port (
         clk, rst : in STD_LOGIC;
         enable   : in STD_LOGIC;
         in_data  : in STD_LOGIC_VECTOR (size-1 downto 0);
         out_data : out  STD_LOGIC_VECTOR (size-1 downto 0)
      );
   end component;

   component votadorNbits is
      Generic (
         N : integer := 1
      );
      Port ( 
         A : in  STD_LOGIC_VECTOR (N-1 downto 0);
         B : in  STD_LOGIC_VECTOR (N-1 downto 0);
         C : in  STD_LOGIC_VECTOR (N-1 downto 0);
         Z : out  STD_LOGIC_VECTOR (N-1 downto 0)
      );
   end component;

   signal data_A : STD_LOGIC_VECTOR(data_size-1 downto 0);
   signal data_B : STD_LOGIC_VECTOR(data_size-1 downto 0);
   signal data_C : STD_LOGIC_VECTOR(data_size-1 downto 0);

   signal reg_A : STD_LOGIC_VECTOR(data_size-1 downto 0);
   signal reg_B : STD_LOGIC_VECTOR(data_size-1 downto 0);
   signal reg_C : STD_LOGIC_VECTOR(data_size-1 downto 0);

begin

-- Comparadores, modulo sencillo
   i_comparador_A: comparador 
      generic map(
         size => data_size
      )
      port map(
         A => input_A,
         B => input_B,
         Z => data_A
      );
   i_comparador_B: comparador 
      generic map(
         size => data_size
      )
      port map(
         A => input_A,
         B => input_B,
         Z => data_B
      );
   i_comparador_C: comparador 
      generic map(
         size => data_size
      )
      port map(
         A => input_A,
         B => input_B,
         Z => data_C
      );

-- Registros A, B, C
   i_reg_A : Reg_Async
      generic map(
         size => data_size
      )
      port map(
         clk => clk,
         rst => rst,
         enable => '1',
         in_data => data_A,
         out_data => reg_A
      );
   i_reg_B : Reg_Async
      generic map(
         size => data_size
      )
      port map(
         clk => clk,
         rst => rst,
         enable => '1',
         in_data => data_B,
         out_data => reg_B
      );
   i_reg_C : Reg_Async
      generic map(
         size => data_size
      )
      port map(
         clk => clk,
         rst => rst,
         enable => '1',
         in_data => data_C,
         out_data => reg_C
      );

-- Votador
   i_votador: votadorNbits
      generic map(
         N => data_size
      )
      port map(
         A => reg_A,
         B => reg_B,
         C => reg_C,
         Z => output_Z
      );
     
end Behavioral;

