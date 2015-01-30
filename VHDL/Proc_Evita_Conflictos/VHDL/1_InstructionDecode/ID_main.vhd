----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:25:00 01/07/2015 
-- Design Name: 
-- Module Name:    IF_main - Behavioral 
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
--    Array de paradas de la siguiente instrucción
--    Bit de instruccion "NULA" siguiente

--    Instruccion actual a descodificar
--    Señal de control, escritura en registro, de instruccion anterior
--    Registro destino de alguna instruccion anterios
--    Datos a escribir en registro, resultado de una instruccion anterior

-- Salidas:
--    Array de paradas de esta instrucción
--    Bit de instrucción "NULA" actual
--    Enable para lógica de fase

--    Bus de datos A
--    Bus de datos B
--    Registro destino para resultado de instruccion actual
--    Entero correspondiente a la instruccion actual
--    Señales de control para fase EXE
--    Señales de control para fase MEM
--    Señales de control para fase WB

library work;
   use work.my_package.all;
   
entity ID_main is
   Port( 
      clk, rst       : in STD_LOGIC;
      in_paradas     : in tipo_paradas;
      in_nula        : in STD_LOGIC;
      out_paradas    : out tipo_paradas;
      out_nula       : out STD_LOGIC;
      out_valid_data : out STD_LOGIC;
      
   -- Entradas (IF->ID)
      in_inst   : in STD_LOGIC_VECTOR(31 downto 0);  -- Instruccion actual

   -- Salidas (ID->EXE)
      out_busA     : out STD_LOGIC_VECTOR(31 downto 0); -- Datos de registro A
      out_busB     : out STD_LOGIC_VECTOR(31 downto 0); -- Datos de registro B
      out_regW     : out STD_LOGIC_VECTOR(3 downto 0);  -- Registro destino
      out_entero   : out STD_LOGIC_VECTOR(31 downto 0); -- Entero con extension de signo
      
   -- Señales de control (WB->ID)
      in_WREnable    : in STD_LOGIC; 
      in_regW        : in STD_LOGIC_VECTOR(3 downto 0); 
      in_busW        : in STD_LOGIC_VECTOR(31 downto 0); 

   -- Señales de control (ID->EXE)
      out_WB_control  : out STD_LOGIC_VECTOR(11 downto 0);
      out_MEM_control : out STD_LOGIC_VECTOR(5 downto 0);
        -- [5:2]=BRCond(Negative,Zero,Cond,Incond), [1]=MemRead, [0]=MemWrite
      out_EXE_control : out STD_LOGIC_VECTOR(3 downto 0);
        -- [3:1]=ALUop, [0]=ALUsrc
        
   -- Entradas y salidas de paso, sirven para simplificar el diseño superior
      in_PC : in STD_LOGIC_VECTOR(31 downto 0);
      out_PC : out STD_LOGIC_VECTOR(31 downto 0);
   );
end ID_main;

architecture Behavioral of ID_main is

-- Modulo que realiza el trabajo de la fase
   component Phase1_InstructionDecode is
      Port ( clk, rst : in STD_LOGIC;  
            
      -- Entradas (IF->ID)
         in_inst   : in STD_LOGIC_VECTOR(31 downto 0);  -- Instruccion actual

      -- Salidas (ID->EXE)
         out_busA     : out STD_LOGIC_VECTOR(31 downto 0); -- Datos de registro A
         out_busB     : out STD_LOGIC_VECTOR(31 downto 0); -- Datos de registro B
         out_regW     : out STD_LOGIC_VECTOR(3 downto 0);  -- Registro destino
         out_entero   : out STD_LOGIC_VECTOR(31 downto 0); -- entero con extension de signo
         
      -- Señales de control (WB->ID)
         in_WREnable    : in STD_LOGIC;
         in_regW        : in STD_LOGIC_VECTOR(3 downto 0);   -- 
         in_busW        : in STD_LOGIC_VECTOR(31 downto 0);  -- 

      -- Señales de control (ID->EXE)
         out_WB_control  : out STD_LOGIC_VECTOR(11 downto 0);
         out_MEM_control : out STD_LOGIC_VECTOR(5 downto 0);
           -- [5:2]=BRCond(Negative,Zero,Cond,Incond), [1]=MemRead, [0]=MemWrite
         out_EXE_control : out STD_LOGIC_VECTOR(3 downto 0)
           -- [3:1]=ALUop, [0]=ALUsrc
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

-- Señales de paso, sirven para simplificar el diseño superior
   out_PC <= in_PC;


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
   i_pID: Phase1_InstructionDecode
      Port map ( 
         clk => clk,
         rst => rst,     
      -- Entradas (IF->ID)
         in_inst => in_inst,

      -- Salidas (ID->EXE)
         out_busA => out_busA,
         out_busB => out_busB,
         out_regW => out_regW,
         out_entero => out_entero,
         
      -- Señales de control (WB->ID)
         in_WREnable => in_WREnable,
         in_regW => in_regW,
         in_busW => in_busW,

      -- Señales de control (ID->EXE)
         out_WB_control => out_WB_control,
         out_MEM_control => out_MEM_control,
         out_EXE_control => out_EXE_control
      );
--


end Behavioral;

