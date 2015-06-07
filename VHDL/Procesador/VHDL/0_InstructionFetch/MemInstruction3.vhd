----------------------------------------------------------------------------------
-- Company: Universidad Complutense de Madrid
-- Engineer: Andres Gamboa Melendez
-- 
-- Module Name: MemInstruction - Behavioral 
-- Project Name: ARM compatible micro-processor
-- Target Devices: Nexys4
-- Tool versions: Xilinx ISE Webpack 14.4
-- Description: Contiene el códgo de programa y carga la instrucción situada en la dirección recibida.
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

entity TB_ProgramaMult is
   Port (
      in_pc : in  STD_LOGIC_VECTOR (31 downto 0);
      out_inst : out  STD_LOGIC_VECTOR (31 downto 0) 
   );
end TB_ProgramaMult;

architecture Behavioral of TB_ProgramaMult is

   constant NUM_INST : INTEGER := 20;
   -- 80 = 20 instrucciones * 4 bytes / La memoria se divide en bytes
   type mem_array is array (0 to (NUM_INST*4)-1) of std_logic_vector(7 downto 0);

   constant mem : mem_array := (
      "11111000", "10010000", "00100000", "00000101",	--  0 LDR R2, R0, #5
      "11110010", "01000000", "00000001", "00011001",	--  4 MOV R1, #25
      "11110010", "01000000", "00000011", "00000000",	--  8 MOV R3, #0
      "11110010", "01000000", "00000101", "00000001",	-- 12 MOV R5, #1
      "11101010", "01001111", "00000100", "00000010",	-- 16 MOV R4, R2
      "00000000", "00000000", "00000000", "00000000",	-- 20 NOP
      "00000000", "00000000", "00000000", "00000000",	-- 24 NOP
      "00000000", "00000000", "00000000", "00000000",	-- 28 NOP
      "11101011", "10110100", "00001111", "00000000",	-- 32 CMP R4, R0
      "11110000", "01000000", "10000000", "00001100",	-- 36 BEQ # 24
      "00000000", "00000000", "00000000", "00000000",	-- 40 NOP
      "00000000", "00000000", "00000000", "00000000",	-- 44 NOP
      "00000000", "00000000", "00000000", "00000000",	-- 48 NOP
      "11101011", "00000011", "00000011", "00000001",	-- 52 ADD R3, R3, R1
      "11101011", "10100100", "00000100", "00000101",	-- 56 SUB R4, R4, R5
      "11110111", "11111111", "10111111", "11110000",	-- 60 B # -32
      "00000000", "00000000", "00000000", "00000000",	-- 64 NOP
      "00000000", "00000000", "00000000", "00000000",	-- 68 NOP
      "00000000", "00000000", "00000000", "00000000",	-- 72 NOP
      "11111000", "10000000", "00110000", "00000000"	-- 76 STR R0, R3, #0
   );

begin
     
-- ROM
  -- proceso lectura, lectura asincrona
   p_lectura: process(in_pc)
   begin
      if to_integer(unsigned(in_pc)) >= 0 and to_integer(unsigned(in_pc(31 downto 2))) < NUM_INST then
         out_inst(31 downto 24) <= mem(to_integer(unsigned(in_pc)+0));
         out_inst(23 downto 16) <= mem(to_integer(unsigned(in_pc)+1));
         out_inst(15 downto 8)  <= mem(to_integer(unsigned(in_pc)+2));
         out_inst(7 downto 0)   <= mem(to_integer(unsigned(in_pc)+3));
      else
         out_inst(31 downto 0) <= (others => '0'); 
      end if;
   end process;
  
end Behavioral;

