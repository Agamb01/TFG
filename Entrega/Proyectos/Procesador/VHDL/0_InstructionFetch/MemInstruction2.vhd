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


entity MemInstruction2 is
   Port (
      in_pc : in  STD_LOGIC_VECTOR (31 downto 0);
      out_inst : out  STD_LOGIC_VECTOR (31 downto 0) 
   );
end MemInstruction2;

architecture Behavioral of MemInstruction2 is

   constant NUM_INST : INTEGER := 16;
   -- 64 = 16 instrucciones * 4 bytes / La memoria se divide en bytes
   type mem_array is array (0 to (NUM_INST*4)-1) of std_logic_vector(7 downto 0);

   constant mem : mem_array := (
         "11110010", "01000000", "00000001", "00010000", --  0 MOV R1, #16
         "11110010", "01000000", "00000010", "00100000", --  4 MOV R2, #32
         "00000000", "00000000", "00000000", "00000000", --  8 NOP
         "00000000", "00000000", "00000000", "00000000", -- 12 NOP

         "00000000", "00000000", "00000000", "00000000", -- 16 NOP
         "11101011", "00000001", "00000011", "00000010", -- 20 ADD R3, R1, R2
         "11101011", "10100001", "00000100", "00000010", -- 24 SUB R4, R1, R2
         "00000000", "00000000", "00000000", "00000000", -- 28 NOP

         "00000000", "00000000", "00000000", "00000000", -- 32 NOP
         "11101010", "01000001", "00000101", "00000011", -- 34 ORR R5, R1, R3         
         "00000000", "00000000", "00000000", "00000000", -- 38 NOP
         "00000000", "00000000", "00000000", "00000000", -- 42 NOP
         
         "00000000", "00000000", "00000000", "00000000", -- 46 NOP
         "11101011", "10110101", "00001111", "00000011", -- 50 CMP R5, R3
         "11110100", "01111111", "10101111", "11110010", -- 54 BEQ -28 - 7 instrucciones anteriores + actual
         "00000000", "00000000", "00000000", "00000000"  -- 58 NOP
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

