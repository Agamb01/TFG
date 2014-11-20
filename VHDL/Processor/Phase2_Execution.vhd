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
   port ( clk, rst : in STD_LOGIC;  
         
        --Entradas
         in_PC : in STD_LOGIC_VECTOR(31 downto 0);
         in_entero : in STD_LOGIC_VECTOR(31 downto 0);
         in_busA : in STD_LOGIC_VECTOR(31 downto 0);
         in_busB : in STD_LOGIC_VECTOR(31 downto 0);
         in_regW : in STD_LOGIC_VECTOR(3 downto 0);
          
        --Salidas
         out_PC_salto_reg : out STD_LOGIC_VECTOR(31 downto 0);
         out_flagsALU_reg : out STD_LOGIC_VECTOR(0 downto 0);
         out_busALU_reg : out STD_LOGIC_VECTOR(31 downto 0);
         out_busB_reg : out STD_LOGIC_VECTOR(31 downto 0);
         out_regW_reg : out STD_LOGIC_VECTOR(3 downto 0);
      
        --Señales de control
         in_ctr_alu_op : in STD_LOGIC_VECTOR(0 downto 0);
         in_ctr_mux_ALUB : in STD_LOGIC
         );
end Phase2_Execution;

architecture Behavioral of Phase2_Execution is

component ALU
    Port ( in_BusA   : in  STD_LOGIC_VECTOR (31 downto 0);
           in_BusB   : in  STD_LOGIC_VECTOR (31 downto 0);
           in_op     : in  STD_LOGIC_VECTOR (0 downto 0);
           out_flags : out  STD_LOGIC_VECTOR (0 downto 0);
           out_busO  : out  STD_LOGIC_VECTOR (31 downto 0)
           );
end component;

component BrAdder
    Port ( in_A : in  STD_LOGIC_VECTOR (31 downto 0);
           in_B : in  STD_LOGIC_VECTOR (31 downto 0);
           out_res : out  STD_LOGIC_VECTOR (31 downto 0));
end component;


-- Señales para ALU 
signal s_ALU_busA : STD_LOGIC_VECTOR (31 downto 0);
signal s_ALU_busB : STD_LOGIC_VECTOR (31 downto 0);
signal s_ALU_op : STD_LOGIC_VECTOR (0 downto 0);
signal s_ALU_res : STD_LOGIC_VECTOR (31 downto 0);
signal s_ALU_flags : STD_LOGIC_VECTOR (0 downto 0);

signal s_ctr_mux_ALUB : STD_LOGIC;

-- Señales para salto
signal s_entero_desp : STD_LOGIC_VECTOR (31 downto 0);
signal s_PC_dir_salto : STD_LOGIC_VECTOR (31 downto 0);

begin

---------Salto---------
   s_entero_desp <= in_entero(29 downto 0) & "00";
   i_BrAdder: BrAdder port map(
      in_A => in_PC,
      in_B => s_entero_desp,
      out_res => s_PC_dir_salto  
   );
---------Salto---------



---------ALU---------
   s_ALU_busA <= in_BusA;
   
   s_ctr_mux_ALUB <= in_ctr_mux_ALUB;
   --Mux para entrada B de ALU
   p_mux_ALU_busB: process(s_ctr_mux_ALUB, in_busB, in_entero)
   begin
      if s_ctr_mux_ALUB='0' then
         s_ALU_busB <= in_busB;
      else
         s_ALU_busB <= in_entero;
      end if;
   end process;
   
   s_ALU_op <= in_ctr_ALU_op;
   
   i_ALU: ALU port map(
      in_BusA => s_ALU_busA,
      in_BusB => s_ALU_busB,
      in_op => s_ALU_op,
      out_flags => s_ALU_flags,
      out_busO => s_ALU_res
   );
---------ALU---------




---------Registros de salida---------
   -- Guardar valores de salida 
   process(clk, rst)
   begin
      if clk'event and clk='0' then
         if rst='0' then        
            out_PC_salto_reg <= (others=>'0');
            out_flagsALU_reg <= (others=>'0');
            out_busALU_reg <= (others=>'0');
            out_busB_reg <= (others=>'0');
            out_regW_reg <= (others=>'0');
         else
            out_PC_salto_reg <= s_PC_dir_salto;
            out_flagsALU_reg <= s_ALU_flags;
            out_busALU_reg <= s_ALU_res;
            out_busB_reg <= in_busB;
            out_regW_reg <= in_regW;
         end if;
      end if;
   end process;
---------Registros de salida---------

end Behavioral;

