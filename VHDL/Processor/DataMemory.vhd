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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DataMemory is
    Port ( clk, rst     : in  STD_LOGIC;
           in_address   : in  STD_LOGIC_VECTOR (31 downto 0);
           in_wrdata    : in  STD_LOGIC_VECTOR (31 downto 0);
           in_memwrite  : in  STD_LOGIC;
           in_memread   : in  STD_LOGIC;
           out_rddata   : out  STD_LOGIC_VECTOR (31 downto 0);
           out_data_ready : out STD_LOGIC
    );
end DataMemory;

architecture Behavioral of DataMemory is

   type memory_array is array (0 to 15) of std_logic_vector(31 downto 0);

   signal mem : memory_array := (others=>(others=>'0'));

begin

-- proceso lectura 
   p_lectura: process(regs, in_regA, in_regB)
   begin
      out_data_ready <= '1';
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
            mem <= (others=>(others=>'0'));
         elsif in_memwrite='1' then
            mem(to_integer(unsigned(in_address))) <= in_wrdata;
         end if;
      end if;
   end process;



end Behavioral;
