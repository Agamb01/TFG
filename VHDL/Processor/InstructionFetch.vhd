----------------------------------------------------------------------------------
-- Company: Universidad Complutense de Madrid
-- Engineer: Andres Gamboa Melendez
-- 
-- Create Date: 02:05:02 10/12/2014 
-- Design Name: 1
-- Module Name: InstructionFetch - Behavioral 
-- Project Name: ARM compatible micro-processor
-- Target Devices: Nexys4
-- Tool versions: Xilinx ISE Webpack 14.4
-- Description: Primera fase del microprocesador segmentado, contador de programa 
--              y memoria de instrucciones.
--
-- Dependencies: PCAdder (Sumador de contador de programa), MemInstruction (Memoria de instrucciones).
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

<<<<<<< HEAD:VHDL/Processor/Phase0_InstructionFetch.vhd

--TODO:  Memoria de instrucciones
         


entity Phase0_InstructionFetch is
   Port ( clk, rst         : in STD_LOGIC;
      in_PC_mux_salto    	: in STD_LOGIC_VECTOR (31 downto 0);   -- Direccion de salto
      in_PC_mux_ctr   	   : in STD_LOGIC;								-- Señal de control de salto
      out_PC_reg 			   : out  STD_LOGIC_VECTOR (31 downto 0); -- Valor de PC siguiente
      out_instruction_reg  : out  STD_LOGIC_VECTOR (31 downto 0)  -- Valor de Instruccion
   ); 
end Phase0_InstructionFetch;
=======
entity InstructionFetch is
   Port ( clk, rst : in STD_LOGIC;
      PC_mux_val_1 	: in STD_LOGIC_VECTOR (31 downto 0);    -- Direccion de salto
      PC_mux_ctr   	: in STD_LOGIC;								 -- Señal de control de salto
      PC_out_reg 			: out  STD_LOGIC_VECTOR (31 downto 0);  -- Valor de PC siguiente
      Instruction_out_reg : out  STD_LOGIC_VECTOR (31 downto 0)
   ); -- Valor de Instruccion
end InstructionFetch;
>>>>>>> parent of 53ed39a... Execution phase:VHDL/Processor/InstructionFetch.vhd

architecture Behavioral of InstructionFetch is

   --Modulo de memoria de Instrucciones
   component MemInstruction
    Port ( in_PC : in  STD_LOGIC_VECTOR (31 downto 0);
           out_instruction : out  STD_LOGIC_VECTOR (31 downto 0));
   end component; 

   --Modulo sumador PC
   component PCAdder
    Port ( in_PC : in  STD_LOGIC_VECTOR (31 downto 0);
           out_PC : out  STD_LOGIC_VECTOR (31 downto 0));
   end component;

   signal s_PC_reg : STD_LOGIC_VECTOR (31 downto 0); -- Salida de registro contador de programa
   signal s_PC4 : STD_LOGIC_VECTOR (31 downto 0); -- Salida de sumador de contador de programa (PC+4)
   signal s_PC_next : STD_LOGIC_VECTOR (31 downto 0); -- Salida de multiplexor de contador de programa (PC+4/PC_salto)
   signal s_instruction : STD_LOGIC_VECTOR (31 downto 0); -- Salida de modulo memoria de instrucciones

begin

   --Modulo de memoria de Instrucciones
   i_MemInstruction: MemInstruction port map( in_PC => s_PC_reg, -- Senal actual de contador de programa
                                              out_instruction => s_instruction -- Instruccion correspondiente a PC
                                             );

   --Modulo sumador PC
   i_PCAdder: PCAdder port map( in_PC => s_PC_reg, -- Senal actual de contador de programa
                                out_PC => s_PC4 -- Senal de contador de programa + 4 (PC+4)
                               );

   -- Guardar valores en biestables de salida
   p_bi_salida: process(rst, clk)
   begin
      if clk'event and clk='1' then
         if rst='0' then
            out_PC_reg <= (others=>'0');
            out_instruction_reg <= (others=>'0');
         else
            out_PC_reg <= s_PC4;
            out_instruction_reg <= s_instruction;
         end if;
      end if;
   end process;

   -- Guardar valor de contador de programa
   p_bi_PC: process(rst, clk)
   begin
      if clk'event and clk='1' then
         if rst='0' then
            s_PC_reg <= (others=>'0');
         else
            s_PC_reg <= s_PC_next;
         end if;
      end if;
   end process;

   -- Multiplexor para contador de programa
   p_mux_PC: process(in_PC_mux_ctr, s_PC4, in_PC_mux_salto)
   begin
      if in_PC_mux_ctr='0' then
         s_PC_next <= s_PC4;
      else
         s_PC_next <= in_PC_mux_salto;   
      end if;
   end process;

end Behavioral;
