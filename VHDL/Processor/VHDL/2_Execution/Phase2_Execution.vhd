----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:28:11 11/14/2014 
-- Design Name: 
-- Module Name:    PhaseExecution - Behavioral 
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

entity Phase2_Execution is
   port (  
      --Entradas
      in_PC          : in STD_LOGIC_VECTOR(31 downto 0);
      in_entero      : in STD_LOGIC_VECTOR(31 downto 0);
      in_busA        : in STD_LOGIC_VECTOR(31 downto 0);
      in_busB        : in STD_LOGIC_VECTOR(31 downto 0);
      in_regW0       : in STD_LOGIC_VECTOR(3 downto 0);
      in_regW1       : in STD_LOGIC_VECTOR(3 downto 0);
       
      --Salidas
      out_PC_salto   : out STD_LOGIC_VECTOR(31 downto 0);
      out_ALU_flags   : out STD_LOGIC_VECTOR(0 downto 0);
      out_ALU_bus     : out STD_LOGIC_VECTOR(31 downto 0);
      out_regW       : out STD_LOGIC_VECTOR(3 downto 0);

      --Señales de control
      in_EXE_control : in STD_LOGIC_VECTOR(9 downto 0)
   );
end Phase2_Execution;

architecture Behavioral of Phase2_Execution is

   component mux2 is
      Generic (
         size : INTEGER := 32
      );
      Port ( 
         in_A : in STD_LOGIC_VECTOR (size-1 downto 0);
         in_B : in STD_LOGIC_VECTOR (size-1 downto 0);
         sel : in STD_LOGIC;
         out_C : out STD_LOGIC_VECTOR (size-1 downto 0)
      );
   end component;
   
-------------------------------Sumador Salto-----------------------------
   component BrAdder
      Port ( 
         in_A : in  STD_LOGIC_VECTOR (31 downto 0);
         in_B : in  STD_LOGIC_VECTOR (31 downto 0);
         out_res : out  STD_LOGIC_VECTOR (31 downto 0));
   end component;

   -- Señales para salto
   signal s_entero_desp : STD_LOGIC_VECTOR (31 downto 0);
   signal s_PC_dir_salto : STD_LOGIC_VECTOR (31 downto 0);

-------------------------------Sumador Salto-----------------------------

-------------------------------ALU-----------------------------
   component ALU
      Port ( 
         in_BusA   : in  STD_LOGIC_VECTOR (31 downto 0);
         in_BusB   : in  STD_LOGIC_VECTOR (31 downto 0);
         in_op     : in  STD_LOGIC_VECTOR (0 downto 0);
         out_flags : out  STD_LOGIC_VECTOR (0 downto 0);
         out_busO  : out  STD_LOGIC_VECTOR (31 downto 0)
      );
   end component;
   -- Señales para ALU 
   signal s_ALU_busA : STD_LOGIC_VECTOR (31 downto 0);
   signal s_ALU_busB : STD_LOGIC_VECTOR (31 downto 0);
   signal s_ALU_op : STD_LOGIC_VECTOR (0 downto 0);

   signal s_ctr_mux_ALUB : STD_LOGIC;
-------------------------------ALU-----------------------------

-------------------------------Selector registro destino-----------------------------
   signal s_ctr_mux_regW : STD_LOGIC;
-------------------------------Selector registro destino-----------------------------



begin

-------------------------------Sumador Salto-----------------------------
   s_entero_desp(31 downto 2) <= in_entero(29 downto 0);
   s_entero_desp( 1 downto 0) <= "00";
i_BrAdder: BrAdder
   port map(
      in_A => in_PC,
      in_B => s_entero_desp,
      out_res => out_PC_salto  
   );
-------------------------------Sumador Salto-----------------------------



-------------------------------ALU-----------------------------
   -- BusA
   s_ALU_busA <= in_BusA;
   
   -- BusB
   s_ctr_mux_ALUB <= in_EXE_control(0);
i_mux_ALU_busB: mux2
   port map( 
      in_A  => in_busB,
      in_B  => in_entero,
      sel   => s_ctr_mux_ALUB,
      out_C => s_ALU_busB
   );
   
   -- ALU operation
   s_ALU_op <= in_EXE_control(1 downto 1);
   
   -- ALU
i_ALU: ALU 
   port map(
      in_BusA   => s_ALU_busA,
      in_BusB   => s_ALU_busB,
      in_op     => s_ALU_op,
      out_flags => out_ALU_flags,
      out_busO  => out_ALU_bus
   );
-------------------------------ALU-----------------------------

-------------------------------Selector registro destino-----------------------------
   s_ctr_mux_regW <= in_EXE_control(2);
   
i_mux_ALU_regW: mux2
   generic map(
      size => 4
   )
   port map( 
      in_A  => in_regW0,
      in_B  => in_regW1,
      sel   => s_ctr_mux_regW,
      out_C => out_regW
   );
-------------------------------Selector registro destino-----------------------------

end Behavioral;

