----------------------------------------------------------------------------------
-- Company: Universidad Complutense de Madrid
-- Engineer: Andres Gamboa Melendez
-- 
-- Module Name: Phase3_Memory - Behavioral 
-- Project Name: ARM compatible micro-processor
-- Target Devices: Nexys4
-- Tool versions: Xilinx ISE Webpack 14.4
-- Description: Cuarta etapa del microprocesador segmentado, contiene la memoria de datos.
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

entity Phase3_Memory is
    Port ( 
      clk, rst   : in STD_LOGIC;
      
      --Entradas (EXE->MEM)
      in_ALUbus  : in STD_LOGIC_VECTOR (31 downto 0);
      in_busB    : in STD_LOGIC_VECTOR (31 downto 0);
      in_flags   : in STD_LOGIC_VECTOR (1 downto 0);
--      in_BRdir   : in STD_LOGIC_VECTOR (31 downto 0);
      
      --Salidas (MEM->WB) 
      out_MEMbus : out  STD_LOGIC_VECTOR (31 downto 0);
      
      --Salidas (MEM->Branch)
--      out_BRdir  : out STD_LOGIC_VECTOR (31 downto 0);
      out_BRctr  : out STD_LOGIC;
      
      --Señales de control (ID->MEM)
      in_MEM_control : in STD_LOGIC_VECTOR(5 downto 0) 
      -- [5:2]=BRCond(Negative,Zero,Cond,Incond), [1]=MemRead, [0]=MemWrite
    );
end Phase3_Memory;

architecture Behavioral of phase3_Memory is

---------------------------Memoria---------------------------
   component MemData is
       Port ( clk, rst     : in  STD_LOGIC;
              in_address   : in  STD_LOGIC_VECTOR (31 downto 0);
              in_wrdata    : in  STD_LOGIC_VECTOR (31 downto 0);
              in_memwrite  : in  STD_LOGIC;
              in_memread   : in  STD_LOGIC;
              out_rddata   : out  STD_LOGIC_VECTOR (31 downto 0)
       );
   end component;

---------------------------Memoria---------------------------

---------------------------Salto---------------------------
   signal s_BR_Incond : STD_LOGIC; -- Salto incondicional
   signal s_BR_Cond   : STD_LOGIC; -- Salto condicional
   signal s_BR_ctr    : STD_LOGIC_VECTOR(1 downto 0); -- Condiciones para salto condicional
---------------------------Salto---------------------------

begin

---------------------------Salto---------------------------
   s_BR_ctr    <= in_MEM_control(5 downto 4);
   s_BR_Cond   <= in_MEM_control(3);
   s_BR_Incond <= in_MEM_control(2);
   
--   out_BRdir <= in_BRdir;
--   out_BRctr <= (s_BR_Incond) or (s_BR_Cond and (s_BR_ctr=in_flags)); 
   process(s_BR_Incond, s_BR_Cond, s_BR_ctr, in_flags)
   begin
      if s_BR_Incond='1' then
         out_BRctr <= '1';
      elsif s_BR_Cond='1' and s_BR_ctr=in_flags then
         out_BRctr <= '1';
      else
         out_BRctr <= '0';
      end if;
   end process;
   -- Si es un salto incondicional
   -- O 
   -- Si es un salto condicional y se cumplen las condiciones
   
---------------------------Salto---------------------------

---------------------------Memoria---------------------------
   i_MemData: MemData 
      Port map ( 
         clk         => clk,
         rst         => rst,
         in_address  => in_ALUbus,
         in_wrdata   => in_busB,
         in_memwrite => in_MEM_control(0), 
         in_memread  => in_MEM_control(1),
         out_rddata  => out_MEMbus 
      );
   
---------------------------Memoria---------------------------
end Behavioral;

