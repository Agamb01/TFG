----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Andrés Gamboa Meléndez 
-- 
-- Create Date:    11:27:36 09/12/2014 
-- Design Name: 
-- Module Name:    ExtensioSigno - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Este módulo analiza la instruccion de entrada y obtiene un número entero.
--              Dependiendo del tipo de instrucción(operación, load, store o salto) utiliza
--              utiliza diferentes bits de la instrucción.
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

entity ExtensionSigno is
   Port ( 
      in_inst : in  STD_LOGIC_VECTOR (31 downto 0);
      out_entero : out STD_LOGIC_VECTOR(31 downto 0)
   );
end ExtensionSigno;

architecture Behavioral of ExtensionSigno is

   type type_inst is (ALU12, ALU16, ALUREG, LDST, BR, BRCond, UNDEFINED);
   signal s_intr_type : type_inst; 

   -- Enteros segun tipo de instruccion
   signal entero_ALU12  : STD_LOGIC_VECTOR(31 downto 0);
   signal entero_ALU16  : STD_LOGIC_VECTOR(31 downto 0);
   signal entero_LDST   : STD_LOGIC_VECTOR(31 downto 0);
   signal entero_BR     : STD_LOGIC_VECTOR(31 downto 0);
   signal entero_BRCond : STD_LOGIC_VECTOR(31 downto 0);

begin

--Entero ALU (Non-Immediate)
-- En esta implementación no se usa entero para operaciones sin inmediato


--Entero ALU (Immediate)
  --Intruccion: [31:27,15]= "11110,0"
  -- ALU 12 bits: [25:24,22] = "10,0" Entero: [26,14:12,7:0]
   p_ALU12: process(in_inst)
   begin
      entero_ALU12(31 downto 12) <= (others=>in_inst(26)); --Extension de signo
      entero_ALU12(11)           <= in_inst(26);           --Entero[11]=Instr[26]
      entero_ALU12(10 downto 8)  <= in_inst(14 downto 12); --Entero[10:8]=Instr[14:12]
      entero_ALU12(7 downto 0)   <= in_inst(7 downto 0);   --Entero[7:0]=Instr[7:0]
   end process;

  -- ALU 16 bits: [25:24,22] = "10,1" Entero: [19:16,26,14:12,7:0]
   p_ALU16: process(in_inst)
   begin
      entero_ALU16(31 downto 16) <= (others=>in_inst(19)); --Extension de signo
      entero_ALU16(15 downto 12) <= in_inst(19 downto 16); --Entero[15:12]=Instr[19:16]
      entero_ALU16(11)           <= in_inst(26);           --Entero[11]=Instr[26]
      entero_ALU16(10 downto 8)  <= in_inst(14 downto 12); --Entero[10:8]=Instr[14:12]
      entero_ALU16(7 downto 0)   <= in_inst(7 downto 0);   --Entero[7:0]=Instr[7:0]  
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
   end process;

-- Identificar tipo de instrucción
   p_identify: process (in_inst)
   begin
   --Control de instruccion ALU12
      if ( (in_inst(31 downto 27)="11110" and in_inst(15)='0') and 
            ((in_inst(25)='0') or (in_inst(25 downto 24)="10" and in_inst(22)='0')) ) then
         s_intr_type <= ALU12;
   --Control de instruccion ALU16
      elsif ( (in_inst(31 downto 27)="11110" and in_inst(15)='0') and 
            (in_inst(25 downto 24)="10" and in_inst(22)='1') ) then
         s_intr_type <= ALU16;
   --Control de instruccion ALUREG
      elsif ( in_inst(31 downto 29)="111" and in_inst(27 downto 25)="101" ) then
         s_intr_type <= ALUREG;
   --Control de instruccion LDST
      elsif ( in_inst(31 downto 25)="1111100" ) then
         s_intr_type <= LDST;
   --Control de instruccion BRANCH
      elsif ( (in_inst(31 downto 27)="11110" and in_inst(15)='1') and in_inst(12)='1' ) then
         s_intr_type <= BR;
   --Control de instruccion CONDITIONAL BRANCH
      elsif ( (in_inst(31 downto 27)="11110" and in_inst(15)='1') and in_inst(12)='0' ) then
         s_intr_type <= BRCond;
      else
         s_intr_type <= UNDEFINED;
      end if;
   end process;


-- Selecciona entero segun tipo de instruccion detectada
   p_select: process (s_intr_type, entero_ALU12, entero_ALU16, entero_LDST, 
                           entero_BR, entero_BRCond)
   begin   
      case s_intr_type is
         when ALU12 =>  -- ALU 12 bits (Immediate)
           out_entero <= entero_ALU12;
         when ALU16 =>  -- ALU 16 bits
           out_entero <= entero_ALU16;
         when LDST =>   -- LOAD/STORE
           out_entero <= entero_LDST;
         when BR =>     -- Salto incondicional
           out_entero <= entero_BR;
         when BRCond => -- Salto condicional
           out_entero <= entero_BRCond;
         when UNDEFINED =>
           out_entero <= (others=>'0');         
         when others => 
           out_entero <= (others=>'0');
      end case;
   end process;

end Behavioral;

