----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:05:02 10/12/2014 
-- Design Name: 
-- Module Name:    InstructionFetch - Behavioral 
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

entity InstructionFetch is
    Port ( clk, reset : in STD_LOGIC;
	        PC_mux_val_1 	: in STD_LOGIC_VECTOR (31 downto 0);    -- Direccion de salto
	        PC_mux_ctr   	: in STD_LOGIC;								 -- Señal de control de salto
           PC_out 			: out  STD_LOGIC_VECTOR (31 downto 0);  -- Valor de PC siguiente
           Instruction_out : out  STD_LOGIC_VECTOR (31 downto 0)); -- Valor de Instruccion
end InstructionFetch;

architecture Behavioral of InstructionFetch is

  --Modulo de memoria de Instrucciones
  component MemInstruction
    Port ( PC : in  STD_LOGIC_VECTOR (31 downto 0);
           Instruction : out  STD_LOGIC_VECTOR (31 downto 0));
  end component; 

  --Modulo sumador PC
  component PCAdder
    Port ( PC_in : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_out : out  STD_LOGIC_VECTOR (31 downto 0));
  end component;

  signal PC, PC4, PC_next : STD_LOGIC_VECTOR (31 downto 0); 
  -- PC=Biestable de contador de programa, PC4=Salida sumador PC+4, PC_next=Salida mux PC+4/PC_salto
  signal Instruction : STD_LOGIC_VECTOR (31 downto 0);

  begin

  --Modulo de memoria de Instrucciones
  MemInstr: MemInstruction port map( PC => PC,
						Instruction => Instruction );

  --Modulo sumador PC
  PCAdd: PCAdder port map ( PC_in => PC,
                          PC_out => PC4 );

  -- Proceso para guardar valores de salida
  Bi_salida: process(reset, clk)
  begin
    if reset='0' then
      PC_out <= (others=>'0'); 
      Instruction_out <= (others=>'0');
    elsif clk'event and clk='1' then
      PC_out <= PC4;
  	   Instruction_out <= Instruction;
    end if;
  end process;

  -- Proceso para guardar valor de contador de programa
  Bi_PC: process(reset, clk)
  begin
    if reset='0' then
      PC <= (others=>'0');
    elsif clk'event and clk='1' then
      PC <= PC_next;
    end if;
  end process;

  -- Proceso multiplexor contador de programa
  Mux_PC: process(PC_mux_ctr, PC4,PC_mux_val_1)
  begin
    if PC_mux_ctr='0' then
      PC_next <= PC4;
    else
      PC_next <= PC_mux_val_1;   
    end if;
  end process;

end Behavioral;

