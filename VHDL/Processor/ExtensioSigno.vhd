----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Andr�s Gamboa Mel�ndez 
-- 
-- Create Date:    11:27:36 09/12/2014 
-- Design Name: 
-- Module Name:    ExtensioSigno - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Este m�dulo analiza la instruccion de entrada y obtiene un n�mero entero.
--              Dependiendo del tipo de instrucci�n(operaci�n, load, store o salto) utiliza
--              utiliza diferentes bits de la instrucci�n.
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

entity ExtensioSigno is
   Port ( 
      in_inst : in  STD_LOGIC_VECTOR (31 downto 0);
      out_entero : out STD_LOGIC_VECTOR(31 downto 0)
   );
end ExtensioSigno;

architecture Behavioral of ExtensioSigno is

   signal entero_ALU12  : STD_LOGIC_VECTOR(31 downto 0);
   signal entero_ALU16  : STD_LOGIC_VECTOR(31 downto 0);
   signal entero_LDST   : STD_LOGIC_VECTOR(31 downto 0);
   signal entero_BR     : STD_LOGIC_VECTOR(31 downto 0);
   signal entero_BRCond : STD_LOGIC_VECTOR(31 downto 0);

   -- Estas se�ales indican si se ha detectado que la instruccion es de cierto tipo.
   signal inst_ALU12  : STD_LOGIC;  -- Operaci�n con inmediato de 12 bits
   signal inst_ALU16  : STD_LOGIC;  -- Operaci�n con inmediato de 16 bits
   signal inst_LDST   : STD_LOGIC;  -- Load o store
   signal inst_BR     : STD_LOGIC;  -- Salto incondicional
   signal inst_BRCond : STD_LOGIC;  -- Salto condicional

begin

--Entero ALU (Non-Immediate)
-- En esta implementaci�n no se usa entero para operaciones sin inmediato


--Entero ALU (Immediate)
--Intruccion: [31:27,15]= "11110,0"
-- ALU 12bits: [25:24,22] = "10,0" Entero: [26,14:12,7:0]
   p_ALU12: process(in_inst)
   begin
      entero_ALU12(31 downto 12) <= (others=>in_inst(26)); --Extension de signo
      entero_ALU12(11)           <= in_inst(26);           --Entero[11]=Instr[26]
      entero_ALU12(10 downto 8)  <= in_inst(14 downto 12); --Entero[10:8]=Instr[14:12]
      entero_ALU12(7 downto 0)   <= in_inst(7 downto 0);   --Entero[7:0]=Instr[7:0]

      --Control de instruccion ALU12
      if ( (in_inst(31 downto 27)="11110" and in_inst(15)='0') and 
         ((in_inst(25)='0') or (in_inst(25 downto 24)="10" and in_inst(22)='0')) ) then
         inst_ALU12  <= '1';
      else
         inst_ALU12  <= '0';
      end if;

   end process;

-- ALU 16bits: [25:24,22] = "10,1" Entero: [19:16,26,14:12,7:0]
   p_ALU16: process(in_inst)
   begin
      entero_ALU16(31 downto 16) <= (others=>in_inst(19)); --Extension de signo
      entero_ALU16(15 downto 12) <= in_inst(19 downto 16); --Entero[15:12]=Instr[19:16]
      entero_ALU16(11)           <= in_inst(26);           --Entero[11]=Instr[26]
      entero_ALU16(10 downto 8)  <= in_inst(14 downto 12); --Entero[10:8]=Instr[14:12]
      entero_ALU16(7 downto 0)   <= in_inst(7 downto 0);   --Entero[7:0]=Instr[7:0]
      
      --Control de instruccion ALU16
      if ( (in_inst(31 downto 27)="11110" and in_inst(15)='0') and 
         (in_inst(25 downto 24)="10" and in_inst(22)='1') ) then
         inst_ALU16  <= '1';
      else
         inst_ALU16  <= '0';
      end if;
      
   end process;

--Entero LOAD/STORE 12bits
--Intruccion: [31:25]= "1111100"
-- Sign extended: [24]="1"
-- Zero extended: [24]="0"
--Entero: [11:0]
   p_LDST: process(in_inst)
   begin
      entero_LDST(11 downto 0) <= in_inst(11 downto 0);      --Entero[11:0]=Instr[11:0]
      if in_inst(24)='1' then                                --Extension de signo
         entero_LDST(31 downto 12) <= (others=>in_inst(11)); 
      else                                                          
         entero_LDST(31 downto 12) <= (others=>'0');
      end if;
      
      --Control de instruccion LDST
      if ( in_inst(31 downto 25)="1111100" ) then
         inst_LDST <= '1';
      else 
         inst_LDST <= '0';
      end if;
      
   end process;

--Entero BRANCH 
--Intruccion: [31:27]= "11110" [15]="1" [12]="1"
-- Entero: 26,[13,11,25:16,10:0],"0"
   p_BR: process(in_inst)
   begin
      entero_BR(31 downto 24) <= (others=>in_inst(26)); --Extension de signo
      entero_BR(23)           <= in_inst(13);           --Entero[23]=Instr[13]
      entero_BR(22)           <= in_inst(11);           --Entero[22]=Instr[11]
      entero_BR(21 downto 12) <= in_inst(25 downto 16); --Entero[21:12]=Instr[25:16]
      entero_BR(11 downto 1)  <= in_inst(10 downto 0);  --Entero[11:1]=Instr[10:1]
      entero_BR(0)            <= '0';                          --Entero[0]="0"

      --Control de instruccion BRANCH
      if ( (in_inst(31 downto 27)="11110" and in_inst(15)='1') and in_inst(12)='1' ) then
         inst_BR <= '1';
      else
         inst_BR <= '0';
      end if;
      
   end process;


--Entero CONDITIONAL BRANCH
--Intruccion: [31:27]= "11110" [15]="1" [12]="0"
-- Entero: 26,[13,11,21:16,10:0],"0"
   p_BRCond: process(in_inst)
   begin
      entero_BRCond(31 downto 20) <= (others=>in_inst(26)); --Extension de signo
      entero_BRCond(19)           <= in_inst(13);           --Entero[23]=Instr[13]
      entero_BRCond(18)           <= in_inst(11);           --Entero[22]=Instr[11]
      entero_BRCond(17 downto 12) <= in_inst(21 downto 16); --Entero[21:12]=Instr[25:16]
      entero_BRCond(11 downto 1)  <= in_inst(10 downto 0);  --Entero[11:1]=Instr[10:1]
      entero_BRCond(0)            <= '0';                          --Entero[0]="0"

      --Control de instruccion CONDITIONAL BRANCH
      if ( (in_inst(31 downto 27)="11110" and in_inst(15)='1') and in_inst(12)='0' ) then
         inst_BRCond <= '1';
      else
         inst_BRCond <= '0';
      end if;

   end process;

-- Selecciona entero segun tipo de instruccion detectada
   p_select: process(in_inst, inst_ALU12, entero_ALU12, inst_ALU16, entero_ALU16, 
                        inst_LDST, entero_LDST, inst_BR, entero_BR, inst_BRCond, entero_BRCond)
   begin
      if inst_ALU12='1' then           -- ALU 12bits (Immediate)
         out_entero <= entero_ALU12;
      elsif inst_ALU16='1' then        -- ALU 16 bits
         out_entero <= entero_ALU16;
      elsif inst_LDST='1' then         -- LOAD/STORE
         out_entero <= entero_LDST;
      elsif inst_BR='1' then           -- Salto incondicional
         out_entero <= entero_BR;
      elsif inst_BRCond='1' then       -- Salto condicional
         out_entero <= entero_BRCond;
      else
         out_entero <= (others=>'0');
      end if;
   end process;


end Behavioral;

