----------------------------------------------------------------------------------
-- Company: Universidad Complutense de Madrid
-- Engineer: Andres Gamboa Melendez
-- 
-- Create Date:    09:50:45 10/28/2014 
-- Design Name:    1
-- Module Name:    Decodification - Behavioral 
-- Project Name: ARM compatible micro-processor
-- Target Devices: Nexys4
-- Tool versions: Xilinx ISE Webpack 14.4
-- Description: Segunda fase del microprocesador segmentado.
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

entity Phase1_InstructionDecode is
   Port ( clk, rst : in STD_LOGIC;  
         
   -- Entradas (IF->ID)
--      in_pc            : in STD_LOGIC_VECTOR(31 downto 0);  -- Entrada de contador de programa
      in_instruction   : in STD_LOGIC_VECTOR(31 downto 0);  -- Instruccion actual

   -- Salidas (ID->EXE)
--      out_pc       : out STD_LOGIC_VECTOR(31 downto 0); -- Salida de contador de programa
      out_busA     : out STD_LOGIC_VECTOR(31 downto 0); -- Datos de registro A
      out_busB     : out STD_LOGIC_VECTOR(31 downto 0); -- Datos de registro B
      out_regW0    : out STD_LOGIC_VECTOR(3 downto 0);  -- Registro destino 0 (bits 15-12)
      out_regW1    : out STD_LOGIC_VECTOR(3 downto 0);  -- Registro destino 1 (bits 14-11)
      out_entero   : out STD_LOGIC_VECTOR(31 downto 0);  -- entero con extension de signo
      
   -- Se�ales de control (WB->ID)
      in_ctr_WREnable : in STD_LOGIC;
      in_regW          : in STD_LOGIC_VECTOR(3 downto 0);   -- 
      in_busW          : in STD_LOGIC_VECTOR(31 downto 0);  -- 

   -- Se�ales de control (ID->EXE)
      out_WB_control : out STD_LOGIC_VECTOR(11 downto 0);
      out_MEM_control : out STD_LOGIC_VECTOR(9 downto 0);
      out_EXE_control : out STD_LOGIC_VECTOR(9 downto 0)
   );
end Phase1_InstructionDecode;

architecture Behavioral of Phase1_InstructionDecode is

-------------------------------Control Principal-----------------------------
component ControlPrincipal
   Port ( 
      in_instruction : in  STD_LOGIC_VECTOR(31 downto 0);
      out_WB_control : out STD_LOGIC_VECTOR(11 downto 0);
      out_MEM_control : out STD_LOGIC_VECTOR(9 downto 0);
      out_EXE_control : out STD_LOGIC_VECTOR(9 downto 0)
   );
end component;
-------------------------------Control Principal-----------------------------


-------------------------------Banco de registros-----------------------------
-- Modulo banco de registros
   component RegisterBank
      port ( clk, rst : in STD_LOGIC;
             in_regA : in STD_LOGIC_VECTOR(3 downto 0);
             in_regB : in STD_LOGIC_VECTOR(3 downto 0);
             in_regW : in STD_LOGIC_VECTOR(3 downto 0);  
             in_busW : in STD_LOGIC_VECTOR(31 downto 0);
             in_ctr_WREnable : in STD_LOGIC;
             out_busA : out STD_LOGIC_VECTOR(31 downto 0);
             out_busB : out STD_LOGIC_VECTOR(31 downto 0)
            );
   end component;

   signal s_regA : STD_LOGIC_VECTOR(3 downto 0);   -- Registro A
   signal s_regB : STD_LOGIC_VECTOR(3 downto 0);   -- Registro B
-------------------------------Banco de registros-----------------------------

-------------------------------Extension de signo-----------------------------
component ExtensioSigno
   Port ( 
      in_instruction : in  STD_LOGIC_VECTOR (31 downto 0);
      out_entero : out STD_LOGIC_VECTOR(31 downto 0)
   );
end component;
-------------------------------Extension de signo-----------------------------

begin

-------------------------------Control Principal-----------------------------
   i_ControlPrincipal: ControlPrincipal port map( 
      in_instruction => in_instruction,
      out_WB_control => out_WB_control,
      out_MEM_control => out_MEM_control,
      out_EXE_control => out_EXE_control
   );
-------------------------------Control Principal-----------------------------

-------------------------------Banco de registros-----------------------------
   s_regA <= in_instruction(19 downto 16);  -- Rn=instruccion[19-16]
   s_regB <= in_instruction(3 downto 0);    -- Rm=instruccion[3-0]

   i_RegisterBank: RegisterBank port map (
          clk => clk,
          rst => rst,
          in_regA => s_regA,  
          in_regB => s_regB,  
          in_regW => in_regW,  
          in_busW => in_busW, 
          in_ctr_WREnable => in_ctr_WREnable,
          out_busA => out_busA, 
          out_busB => out_busB
         );

 -- Registros destino
   out_regW0 <= in_instruction(11 downto 8); -- Rd[11-8]
   out_regW1 <= in_instruction(15 downto 12); -- Rt[15-12]
-------------------------------Banco de registros-----------------------------

-------------------------------Extension de signo-----------------------------
   i_ExtensionSigno: ExtensioSigno port map ( 
      in_instruction => in_instruction,
      out_entero => out_entero 
   );
-------------------------------Extension de signo-----------------------------
end Behavioral;
