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
      out_WB_control  : out STD_LOGIC_VECTOR(1 downto 0);
      out_MEM_control : out STD_LOGIC_VECTOR(5 downto 0);
        -- [5:2]=BRCond(Negative,Zero,Cond,Incond), [1]=MemRead, [0]=MemWrite
      out_EXE_control : out STD_LOGIC_VECTOR(3 downto 0)
        -- [3:1]=ALUop, [0]=ALUsrc
   );
end Phase1_InstructionDecode;

architecture Behavioral of Phase1_InstructionDecode is

-------------------------------Control Principal-----------------------------
component ControlPrincipal is
   Port ( 
      in_inst     : in  STD_LOGIC_VECTOR(31 downto 0);
      
      out_WB_control  : out STD_LOGIC_VECTOR(1 downto 0);
        -- [1]=MemtoReg, [0]=RegWrite
      out_MEM_control : out STD_LOGIC_VECTOR(5 downto 0);
        -- [5:2]=BRCond(Negative,Zero,Cond,Incond), [1]=MemRead, [0]=MemWrite
      out_EXE_control : out STD_LOGIC_VECTOR(3 downto 0)
        -- [3:1]=ALUop, [0]=ALUsrc
      --out_test    : out STD_LOGIC_VECTOR(4 downto 0)
   );
end component;
-------------------------------Control Principal-----------------------------


-------------------------------Banco de registros-----------------------------
-- Modulo banco de registros
   component RegisterBank
      port ( clk, rst    : in STD_LOGIC;
             in_regA     : in STD_LOGIC_VECTOR(3 downto 0);
             in_regB     : in STD_LOGIC_VECTOR(3 downto 0);
             in_regW     : in STD_LOGIC_VECTOR(3 downto 0);  
             in_busW     : in STD_LOGIC_VECTOR(31 downto 0);
             in_WREnable : in STD_LOGIC;
             out_busA    : out STD_LOGIC_VECTOR(31 downto 0);
             out_busB    : out STD_LOGIC_VECTOR(31 downto 0)
            );
   end component;

   signal s_regA : STD_LOGIC_VECTOR(3 downto 0);   -- Registro A
   signal s_regB : STD_LOGIC_VECTOR(3 downto 0);   -- Registro B
-------------------------------Banco de registros-----------------------------

-------------------------------Extension de signo-----------------------------
   component ExtensioSigno
      Port ( 
         in_inst     : in  STD_LOGIC_VECTOR (31 downto 0);
         out_entero  : out STD_LOGIC_VECTOR(31 downto 0)
      );
   end component;
-------------------------------Extension de signo-----------------------------

begin

-------------------------------Control Principal-----------------------------
   i_ControlPrincipal: 
      ControlPrincipal port map( 
         in_inst => in_inst,
         out_WB_control => out_WB_control,
         out_MEM_control => out_MEM_control,
         out_EXE_control => out_EXE_control
      );
-------------------------------Control Principal-----------------------------

-------------------------------Banco de registros-----------------------------
   s_regA <= in_inst(19 downto 16);  -- Rn=instruccion[19-16]
   
   --Proceso seleccion de registro B
   --  si es instruccion de load/store: regB <= Rt (instruccion[15-12])
   --  en otro caso: regB <= Rm (instruccion[3-0])
   process(in_inst)
   begin 
      if in_inst(31 downto 25)="1111100" then
         s_regB <= in_inst(15 downto 12);
      else
         s_regB <= in_inst(3 downto 0);
      end if;
   end process;
   
   i_RegisterBank: 
      RegisterBank port map (
          clk => clk,
          rst => rst,
          in_regA => s_regA,  
          in_regB => s_regB,  
          in_regW => in_regW,  
          in_busW => in_busW, 
          in_WREnable => in_WREnable,
          out_busA => out_busA, 
          out_busB => out_busB
      );

   --Proceso seleccion de registro destino
   --  si es instruccion de load/store: regW <= Rt (instruccion[15-12])
   --  en otro caso: regW <= Rd (instruccion[11-8])
   process(in_inst)
   begin 
      if in_inst(31 downto 25)="1111100" then
         out_regW <= in_inst(15 downto 12);
      else
         out_regW <= in_inst(11 downto 8);
      end if;
   end process;
-------------------------------Banco de registros-----------------------------

-------------------------------Extension de signo-----------------------------
   i_ExtensionSigno: ExtensioSigno port map ( 
      in_inst => in_inst,
      out_entero => out_entero 
   );
-------------------------------Extension de signo-----------------------------
end Behavioral;

