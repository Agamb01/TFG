----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:08:45 12/08/2014 
-- Design Name: 
-- Module Name:    DataMemory - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
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

entity MemData is
    Port ( clk, rst     : in  STD_LOGIC;
           in_address   : in  STD_LOGIC_VECTOR (31 downto 0);
           in_wrdata    : in  STD_LOGIC_VECTOR (31 downto 0);
           in_memwrite  : in  STD_LOGIC;
           in_memread   : in  STD_LOGIC;
           out_rddata   : out  STD_LOGIC_VECTOR (31 downto 0)
--           out_data_rdy : out STD_LOGIC
    );
end MemData;

architecture Behavioral of MemData is

   type memory_array is array (0 to 31) of std_logic_vector(31 downto 0);
   constant mem_rst : memory_array := (
        "00000000000000000000000000000000",
        "00000000000000000000000000000001",
        "00000000000000000000000000000010",
        "00000000000000000000000000000011",
        "00000000000000000000000000000100",
        "00000000000000000000000000000101",
        "00000000000000000000000000000110",
        "00000000000000000000000000000111",
        "00000000000000000000000000001000",
        "00000000000000000000000000001001",
        "00000000000000000000000000001010",
        "00000000000000000000000000001011",
        "00000000000000000000000000001100",
        "00000000000000000000000000001101",
        "00000000000000000000000000001110",
        "00000000000000000000000000001111",
        "00000000000000000000000000010000",
        "00000000000000000000000000010001",
        "00000000000000000000000000010010",
        "00000000000000000000000000010011",
        "00000000000000000000000000010100",
        "00000000000000000000000000010101",
        "00000000000000000000000000010110",
        "00000000000000000000000000010111",
        "00000000000000000000000000011000",
        "00000000000000000000000000011001",
        "00000000000000000000000000011010",
        "00000000000000000000000000011011",
        "00000000000000000000000000011100",
        "00000000000000000000000000011101",
        "00000000000000000000000000011110",
        "00000000000000000000000000011111"
        );

   signal mem : memory_array := mem_rst;

begin

-- proceso lectura 
   p_lectura: process(mem, in_address, in_memread)
   begin
--      out_data_ready <= '1';
      if in_memread='1' then
         out_rddata <= mem(to_integer(unsigned(in_address)));
      else
         out_rddata <= (others=>'0');
      end if;
   end process;

-- proceso escritura
   p_escritura: process(clk, rst)
   begin 
      if rising_edge(clk) then
         if rst = '0' then
            mem <= mem_rst;
         elsif in_memwrite='1' then
            mem(to_integer(unsigned(in_address))) <= in_wrdata;
         end if;
      end if;
   end process;



end Behavioral;
