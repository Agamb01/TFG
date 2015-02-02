----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:47:54 01/22/2015 
-- Design Name: 
-- Module Name:    EXE_main - Behavioral 
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

--    Contador de programa para calcular direccion de salto
--    Entero sacado de la instruccion
--    Buses de datos de los registros seleccionados por la instruccion

--    Señales de control para etapa de ejecucion:
--       bits[3:1] -> ALU_op
--       bits[0]   -> ALU_ctr

-- Salidas:
--    Array de paradas de esta instrucción
--    Bit de instrucción "NULA" actual
--    Enable para lógica de fase

--    Direccion de salto calculada
--    Resultado de operacion calculado por la ALU
--    Flags de la operacion calculada por la ALU

library work;
   use work.my_package.all;
   
entity EXE_main is
   Port( 
      clk, rst       : in STD_LOGIC;
      
      --Entradas modulo esperas
      in_paradas     : in tipo_paradas;
      in_nula        : in STD_LOGIC;
      out_paradas    : out tipo_paradas;
      out_nula       : out STD_LOGIC;
      out_valid_data : out STD_LOGIC;
      
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
      in_EXE_control : in STD_LOGIC_VECTOR(3 downto 0);
        -- [3:1]=ALUop, [0]=ALUsrc

   -- Entradas y salidas de paso, sirven para simplificar el diseño superior
      in_regW         : in STD_LOGIC_VECTOR(3 downto 0);  -- Registro destino
      in_WB_control   : in STD_LOGIC_VECTOR(1 downto 0);
      in_MEM_control  : in STD_LOGIC_VECTOR(5 downto 0);
      
      out_BusB        : out STD_LOGIC_VECTOR(31 downto 0);
      out_regW        : out STD_LOGIC_VECTOR(3 downto 0);  -- Registro destino
      out_WB_control  : out STD_LOGIC_VECTOR(1 downto 0);
      out_MEM_control : out STD_LOGIC_VECTOR(5 downto 0)

   );
end EXE_main;

architecture Behavioral of EXE_main is

-- Modulo que realiza el trabajo de la fase
   component Phase2_Execution is
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
         in_EXE_control : in STD_LOGIC_VECTOR(3 downto 0) 
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
   out_regW        <= in_regW;
   out_WB_control  <= in_WB_control;
   out_MEM_control <= in_MEM_control;
   out_BusB        <= in_BusB;
   
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
   
-- Modulo funcional de la fase EXE
   i_pEXE: Phase2_Execution
      Port map (
         --Entradas (ID->EXE)
         in_PC => in_PC,
         in_entero => in_entero,
         in_busA => in_busA,
         in_busB => in_busB,
         
         --Salidas (EXE->MEM)
         out_PC_salto => out_PC_salto,
         out_ALU_bus => out_ALU_bus,
         out_ALU_flags => out_ALU_flags,

         --Señales de control(ID->EXE)
         in_EXE_control => in_EXE_control
      );
--


end Behavioral;

