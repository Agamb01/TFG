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
      
--      out_type    : out type_inst;
      
      out_WB_control  : out STD_LOGIC_VECTOR(1 downto 0);
        -- [1]=MemtoReg, [0]=RegWrite
      out_MEM_control : out STD_LOGIC_VECTOR(5 downto 0);
        -- [5:2]=BRCond(Negative,Zero,Cond,Incond), [1]=MemRead, [0]=MemWrite
      out_EXE_control : out STD_LOGIC_VECTOR(3 downto 0)
        -- [3:1]=ALUop, [0]=ALUsrc
   );
end ControlPrincipal;

architecture Behavioral of ControlPrincipal is

   type type_inst is (ALU12, ALU16, ALUREG, LDST, BR, BRCond, UNDEFINED);
   signal s_intr_type : type_inst; 
      
   -- Señales EXE
   signal s_ALU_op : STD_LOGIC_VECTOR(2 downto 0);
   signal s_ALUsrc : STD_LOGIC;

   --Señales MEM
   signal s_BRCond  : STD_LOGIC_VECTOR(3 downto 0);
   signal s_MemRead : STD_LOGIC;
   signal s_MemWr   : STD_LOGIC; 
   
   --Señales WB
   signal s_MemtoReg : STD_LOGIC;
   signal s_RegWrite : STD_LOGIC; 
   
begin

--out_type <= s_intr_type;




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


--------------------------------------------------------------------------------
-----------------------------Señales de control EXE-----------------------------
--------------------------------------------------------------------------------
--      out_EXE_control : out STD_LOGIC_VECTOR(3 downto 0)
--        -- [3:1]=ALUop, [0]=ALUsrc

   out_EXE_control(3 downto 1) <= s_ALU_op;
   out_EXE_control(0)          <= s_ALUsrc;

   p_ALUsrc: process (s_intr_type)
   begin
      if s_intr_type=ALUREG then
         s_ALUsrc <= '0';
      else
         s_ALUsrc <= '1';
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
   
   p_ALUop: process (s_intr_type, in_inst)
   begin
      if s_intr_type = ALU16 then
         case in_inst(23) & in_inst(21 downto 20) is
            when "000"  => s_ALU_op <= "010"; --MOV
            when "100"  => s_ALU_op <= "011"; --MOVT
            when others => s_ALU_op <= "010";
         end case;
      elsif s_intr_type = ALUREG then
         case in_inst(24 downto 21) is
            when "0000"  => 
               s_ALU_op <= "100"; --AND
            when "0010"  => 
               if in_inst(19 downto 16)="1111" then
                  s_ALU_op <= "010"; --MOV
               else
                  s_ALU_op <= "101"; --ORR
               end if;
            when "0100"  => 
               s_ALU_op <= "110"; --EOR
            when "1000"  => 
               s_ALU_op <= "000"; --ADD
            when "1101"  => 
               if in_inst(11 downto 8)="1111" then -- and in_inst(20)='1' then
                  s_ALU_op <= "111"; --CMP
               else 
                  s_ALU_op <= "001"; --SUB
               end if;
            when others => 
               s_ALU_op <= "010"; --MOV
         end case;
      elsif s_intr_type = LDST then
         s_ALU_op <= "000"; -- ADD
      elsif s_intr_type = BR then 
         s_ALU_op <= "000"; -- ADD
      elsif s_intr_type = BRCond then 
         s_ALU_op <= "000"; -- ADD
      else    
         s_ALU_op <= "000"; -- ADD
      end if;
   end process;


--------------------------------------------------------------------------------
-----------------------------Señales de control MEM-----------------------------
--------------------------------------------------------------------------------
--      out_MEM_control : out STD_LOGIC_VECTOR(5 downto 0);
--        -- [5:2]=BRCond(Negative,Zero,Cond,Incond), [1]=MemRead, [0]=MemWrite
   out_MEM_control(5 downto 2) <= s_BRCond;
   out_MEM_control(1)          <= s_MemRead;
   out_MEM_control(0)          <= s_MemWr; 

   p_MEM_control: process (s_intr_type, in_inst)
   begin
      if s_intr_type = BR then
         s_BRCond  <= "0001";
         s_MemRead <= '0';
         s_MemWr   <= '0';
      elsif s_intr_type = BRCond then
         s_BRCond(3 downto 2)  <= in_inst(23 downto 22); -- Supuesto
         s_BRCond(1 downto 0)  <= "10";
         s_MemRead <= '0';
         s_MemWr   <= '0';
      elsif s_intr_type = LDST then
         s_BRCond  <= "0000";
         s_MemRead <= in_inst(20);
         s_MemWr   <= not in_inst(20);
      else
         s_BRCond  <= "0000";
         s_MemRead <= '0';
         s_MemWr   <= '0';
      end if;
   end process;

--------------------------------------------------------------------------------
-----------------------------Señales de control WB------------------------------
--------------------------------------------------------------------------------
--      out_WB_control  : out STD_LOGIC_VECTOR(1 downto 0);
--        -- [1]=MemtoReg, [0]=RegWrite

   out_WB_control(1) <= s_MemtoReg;
   out_WB_control(0) <= s_RegWrite;
   
   p_WB_control: process (s_intr_type, in_inst)
   begin
      case s_intr_type is
         when ALUREG => 
            if in_inst(11 downto 8)="1111" then -- CMP
               s_MemtoReg <= '0';
               s_RegWrite <= '0';
            else 
               s_MemtoReg <= '0';
               s_RegWrite <= '1';
            end if;
         when ALU12 => 
            s_MemtoReg <= '0';
            s_RegWrite <= '1';
         when ALU16 => 
            s_MemtoReg <= '0';
            s_RegWrite <= '1';
         when LDST => 
            s_MemtoReg <= in_inst(20);
            s_RegWrite <= in_inst(20);
         when others =>
            s_MemtoReg <= '0';
            s_RegWrite <= '0';
      end case;
   end process;




end Behavioral;

