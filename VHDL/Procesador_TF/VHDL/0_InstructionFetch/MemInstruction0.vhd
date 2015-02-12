----------------------------------------------------------------------------------
-- Company: Universidad Complutense de Madrid
-- Engineer: Andres Gamboa Melendez
-- 
-- Create Date: 12:05:02 11/12/2014 
-- Design Name: Modulo Memoria de instrucciones
-- Module Name: MemInstruction - Behavioral 
-- Project Name: ARM compatible micro-processor
-- Target Devices: Nexys4
-- Tool versions: Xilinx ISE Webpack 14.4
-- Description: Recibe una dirección y devuelve la instruccion situada en esa 
--              direccion.
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



--TODO: Completar

entity MemInstruction0 is
   Port (
      in_pc : in  STD_LOGIC_VECTOR (31 downto 0);
      out_inst : out  STD_LOGIC_VECTOR (31 downto 0) 
   );
end MemInstruction0;

architecture Behavioral of MemInstruction0 is

   constant NUM_INST : INTEGER := 16;
   -- 64 = 16 instrucciones * 4 bytes / La memoria se divide en bytes
   type mem_array is array (0 to (NUM_INST*4)-1) of std_logic_vector(7 downto 0);

   constant mem : mem_array := (
         "00000000", "00000000", "00000000", "00000000", -- NOP
         "00000000", "00000000", "00000000", "00000000", -- NOP
         "00000000", "00000000", "00000000", "00000000", -- NOP
         "00000000", "00000000", "00000000", "00000000", -- NOP

         "00000000", "00000000", "00000000", "00000000", -- NOP
         "00000000", "00000000", "00000000", "00000000", -- NOP
         "00000000", "00000000", "00000000", "00000000", -- NOP
         "00000000", "00000000", "00000000", "00000000", -- NOP
         
         "00000000", "00000000", "00000000", "00000000", -- NOP
         "00000000", "00000000", "00000000", "00000000", -- NOP
         "00000000", "00000000", "00000000", "00000000", -- NOP
         "00000000", "00000000", "00000000", "00000000", -- NOP
         
         "00000000", "00000000", "00000000", "00000000", -- NOP
         "00000000", "00000000", "00000000", "00000000", -- NOP
         "00000000", "00000000", "00000000", "00000000", -- NOP
         "00000000", "00000000", "00000000", "00000000"  -- NOP
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

