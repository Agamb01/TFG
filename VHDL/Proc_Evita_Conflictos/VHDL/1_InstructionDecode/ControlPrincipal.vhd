----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Andrés Gamboa Meléndez
-- 
-- Create Date:    17:41:47 12/01/2014 
-- Design Name: 
-- Module Name:    ControlPrincipal - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Analiza las instrucciones para extraer las señales de control 
--              necesarias para procesar las mismas.
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

entity ControlPrincipal is
   Port ( 
      in_inst     : in  STD_LOGIC_VECTOR(31 downto 0);
      out_WB_ctr  : out STD_LOGIC_VECTOR(11 downto 0);
      out_MEM_ctr : out STD_LOGIC_VECTOR(9 downto 0);
      out_EXE_ctr : out STD_LOGIC_VECTOR(9 downto 0);
      out_test    : out STD_LOGIC_VECTOR(4 downto 0)
   );
end ControlPrincipal;

architecture Behavioral of ControlPrincipal is

   type type_inst is (ALU12, ALU16, ALUREG, LDST, BR, BRCond, UNDEFINED);
   signal s_intr_type : type_inst; 
   
   
   signal s_ALU_op : STD_LOGIC_VECTOR(2 downto 0);
begin

-- Identificar tipo de instrucción
   process (in_inst)
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



-- Seleccion operación
--  Operacion de ALU depende de bits [24-21] si operacion con registro
--  Operacion de ALU depende de bits [23,21,20] si operacion con inmediato
-- Tabla operaciones
-- ADD  000
-- SUB  001
-- MOV  010
-- MOVT 011

-- AND  100
-- ORR  101
-- EOR  110
-- CMP  111

   process (s_intr_type)
   begin
      if s_intr_type = ALU12 then
         case in_inst(23) & in_inst(21 downto 20) is
            when "000"  => s_ALU_op <= ""; --ADD
            when "110"  => s_ALU_op <= ""; --SUB
            when others => s_ALU_op <= "";
         end case;
      elsif s_intr_type = ALU16 then
         case in_inst(23) & in_inst(21 downto 20) is
            when "000"  => s_ALU_op <= ""; --MOV
            when "100"  => s_ALU_op <= ""; --MOVT
            when others => s_ALU_op <= "";
         end case;
      elsif s_intr_type = ALUREG then

      end if;
   end process;









-- Proceso salidas
   process (s_intr_type)
   begin   
      case s_intr_type is
         when ALU12 =>
           out_test <= "10000";
         when ALU16 =>
           out_test <= "01000";
         when LDST =>
           out_test <= "00100";
         when BR =>
           out_test <= "00010";
         when BRCond =>
           out_test <= "00001";
         when UNDEFINED =>
           out_test <= "00000";         
         when others => 
           out_test <= "00000";
      end case;
   end process;


-- Obtener señales para fase de ejecución

--   process()

   out_EXE_ctr <= in_inst(9 downto 0);

-- Obtener señales para fase de memoria

   out_MEM_ctr <= in_inst(19 downto 10);

-- Obtener señales para fase de write back

   out_WB_ctr <= in_inst(31 downto 20);



end Behavioral;

