----------------------------------------------------------------------------------
-- Company: Universidad Complutense de Madrid
-- Engineer: Andres Gamboa Melendez
-- 
-- Module Name: EXE_main - Behavioral 
-- Project Name: ARM compatible micro-processor
-- Target Devices: Nexys4
-- Tool versions: Xilinx ISE Webpack 14.4
-- Description: Módulo principal de etapa "Execution"
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

   
entity EXE_main is
   Port( 
      clk, rst       : in STD_LOGIC;
            
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

   signal s_ALU_flags     : STD_LOGIC_VECTOR(1 downto 0); -- Flags(N,Z)
   signal s_ALU_flags_reg : STD_LOGIC_VECTOR(1 downto 0); -- Flags(N,Z)

begin

-- Señales de paso, sirven para simplificar el diseño superior
   out_regW        <= in_regW;
   out_WB_control  <= in_WB_control;
   out_MEM_control <= in_MEM_control;
   out_BusB        <= in_BusB;
      
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
         out_ALU_flags => s_ALU_flags,

         --Señales de control(ID->EXE)
         in_EXE_control => in_EXE_control
      );

--Registro flags
   out_ALU_flags <= s_ALU_flags_reg;

   --Proceso guarda flags en registros
   p_arith: process(clk, rst)
   begin
      if rst='0' then 
         s_ALU_flags_reg <= "00";
      elsif rising_edge(clk) then
         if in_EXE_control(3 downto 1) = "111" then
            s_ALU_flags_reg <= s_ALU_flags;
         end if;
      end if;
   end process;
   
end Behavioral;

