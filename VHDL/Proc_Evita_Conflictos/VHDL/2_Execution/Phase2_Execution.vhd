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
      --Entradas (ID->EXE)
      in_PC          : in STD_LOGIC_VECTOR(31 downto 0);
      in_entero      : in STD_LOGIC_VECTOR(31 downto 0);
      in_busA        : in STD_LOGIC_VECTOR(31 downto 0);
      in_busB        : in STD_LOGIC_VECTOR(31 downto 0);
       
      --Salidas (EXE->MEM)
      out_PC_salto   : out STD_LOGIC_VECTOR(31 downto 0);
      out_ALU_bus    : out STD_LOGIC_VECTOR(31 downto 0);
      out_ALU_flags  : out STD_LOGIC_VECTOR(1 downto 0); -- Flags(N,Z)

      --Señales de control(ID->EXE)
      in_EXE_control : in STD_LOGIC_VECTOR(3 downto 0) -- [3:1]=ALUop, [0]=ALUsrc
   );
end Phase2_Execution;

architecture Behavioral of Phase2_Execution is

   component mux2 is
      Generic (
         size : INTEGER := 32
      );
      Port ( 
         in_0 : in STD_LOGIC_VECTOR (size-1 downto 0);
         in_1 : in STD_LOGIC_VECTOR (size-1 downto 0);
         sel : in STD_LOGIC;
         out_0 : out STD_LOGIC_VECTOR (size-1 downto 0)
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

-------------------------------Sumador Salto-----------------------------

-------------------------------ALU-----------------------------
   component ALU
      Port ( 
         -- ENTRADAS
         in_A : in  STD_LOGIC_VECTOR (31 downto 0);
         in_B : in  STD_LOGIC_VECTOR (31 downto 0);
         in_op : in STD_LOGIC_VECTOR (2 downto 0);
         -- SALIDAS
         out_R : out  STD_LOGIC_VECTOR (31 downto 0);
         out_f : out  STD_LOGIC_VECTOR (1 downto 0) -- Flags(N,Z)
      );
   end component;
   
   -- Señales para ALU 
   signal s_ALU_busA : STD_LOGIC_VECTOR (31 downto 0);
   signal s_ALU_busB : STD_LOGIC_VECTOR (31 downto 0);
   signal s_ALU_op   : STD_LOGIC_VECTOR (2 downto 0);
   
   signal s_ALU_src : STD_LOGIC;
   
-------------------------------ALU-----------------------------

begin

-------------------------------Sumador Salto-----------------------------
-- No es necesario el desplazamiento, la instruccion de salto ya tiene
-- en cuenta el tamaño de las instrucciones y los valores de los bits [1:0] 
-- de la instruccion es "00"
-- (En caso de instrucciones de 16 bits el valor del bit 0 puede ser 1)
i_BrAdder: BrAdder
   port map(
      in_A => in_PC,
      in_B => in_entero,
      out_res => out_PC_salto  
   );
-------------------------------Sumador Salto-----------------------------



-------------------------------ALU-----------------------------
   -- BusA
   s_ALU_busA <= in_BusA;
   
   -- BusB
   s_ALU_src <= in_EXE_control(0);
   
i_mux_ALU_busB: mux2
   port map( 
      in_0  => in_busB,
      in_1  => in_entero,
      sel   => s_ALU_src,
      out_0 => s_ALU_busB
   );
   
   -- ALU operation
   s_ALU_op <= in_EXE_control(3 downto 1);
   
   -- ALU
i_ALU: ALU 
   port map(
      in_A  => s_ALU_busA,
      in_B  => s_ALU_busB,
      in_op => s_ALU_op,
      out_R => out_ALU_bus,
      out_f => out_ALU_flags
   );
-------------------------------ALU-----------------------------

end Behavioral;

