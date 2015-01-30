----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:22:54 01/25/2015 
-- Design Name: 
-- Module Name:    MEM_main - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- Entradas:
--    Clock de sistema
--    Reset de sistema
--    Array de paradas de la siguiente instrucci�n
--    Bit de instruccion "NULA" siguiente

--    Bus de datos, resultado de ALU
--    Bus de datos, segundo registro
--    Flags de comparacion de ALU

--    Se�ales de control para etapa de memoria:
--       bits[5:4] -> Condiciones para salto condicional
--       bits[3]   -> Salto condicional
--       bits[2]   -> Salto incondicional
--       bits[1]   -> Lectura de memoria
--       bits[0]   -> Escritura de memoria

-- Salidas:
--    Array de paradas de esta instrucci�n
--    Bit de instrucci�n "NULA" actual
--    Enable para l�gica de fase

--    Bus de datos, datos obtenidos de memoria
--    Control de salto (PC_Src)

library work;
   use work.my_package.all;
   
entity MEM_main is
   Port (
      clk, rst       : in STD_LOGIC;
      in_paradas     : in tipo_paradas;
      in_nula        : in STD_LOGIC;
      out_paradas    : out tipo_paradas;
      out_nula       : out STD_LOGIC;
      out_valid_data : out STD_LOGIC;

      --Entradas (EXE->MEM)
      in_ALUbus  : in STD_LOGIC_VECTOR (31 downto 0);
      in_busB    : in STD_LOGIC_VECTOR (31 downto 0);
      in_flags   : in STD_LOGIC_VECTOR (1 downto 0);
      -- in_BRdir   : in STD_LOGIC_VECTOR (31 downto 0);

      --Salidas (MEM->WB) 
      out_MEMbus : out  STD_LOGIC_VECTOR (31 downto 0);

      --Salidas (MEM->Branch)
      -- out_BRdir  : out STD_LOGIC_VECTOR (31 downto 0);
      out_BRctr  : out STD_LOGIC;

      --Se�ales de control (ID->MEM)
      in_MEM_control : in STD_LOGIC_VECTOR(5 downto 0) 
        -- [5:2]=BRCond(Negative,Zero,Cond,Incond), [1]=MemRead, [0]=MemWrite

   );
end MEM_main;

architecture Behavioral of MEM_main is

-- Modulo que realiza el trabajo de la fase
   component Phase3_Memory is
      Port ( 
         clk, rst   : in STD_LOGIC;

         --Entradas (EXE->MEM)
         in_ALUbus  : in STD_LOGIC_VECTOR (31 downto 0);
         in_busB    : in STD_LOGIC_VECTOR (31 downto 0);
         in_flags   : in STD_LOGIC_VECTOR (1 downto 0);
         -- in_BRdir   : in STD_LOGIC_VECTOR (31 downto 0);

         --Salidas (MEM->WB) 
         out_MEMbus : out  STD_LOGIC_VECTOR (31 downto 0);

         --Salidas (MEM->Branch)
         -- out_BRdir  : out STD_LOGIC_VECTOR (31 downto 0);
         out_BRctr  : out STD_LOGIC;

         --Se�ales de control (ID->MEM)
         in_MEM_control : in STD_LOGIC_VECTOR(5 downto 0) 
            -- [5:2]=BRCond(Negative,Zero,Cond,Incond), [1]=MemRead, [0]=MemWrite
      );
   end component;

-- Modulo que gestiona las esperas
   component mod_esperas is
      Port( 
         clk, rst       : in STD_LOGIC;
         in_paradas     : in tipo_paradas;
         in_nula        : in STD_LOGIC;
         out_paradas    : out tipo_paradas;
         out_nula       : out STD_LOGIC;
         out_valid_data : out STD_LOGIC
      );
   end component;

 --  signal s_enable : STD_LOGIC;
begin

  
-- Modulo que gestiona las esperas
   i_esperas: mod_esperas
      Port map (
         clk            => clk, 
         rst            => rst,
         in_paradas     => in_paradas,
         in_nula        => in_nula,
         out_paradas    => out_paradas,
         out_nula       => out_nula,
         out_valid_data => out_valid_data
      );
   
-- Modulo funcional de la fase ID
   i_pMEM: Phase3_Memory
      Port map (
         clk => clk, 
         rst => rst,

         --Entradas (EXE->MEM)
         in_ALUbus => in_ALUbus,
         in_busB   => in_busB,
         in_flags  => in_flags,

         --Salidas (MEM->WB) 
         out_MEMbus => out_MEMbus,

         --Salidas (MEM->Branch)
         out_BRctr  => out_BRctr,

         --Se�ales de control (ID->MEM)
         in_MEM_control => in_MEM_control
      );
--


end Behavioral;

