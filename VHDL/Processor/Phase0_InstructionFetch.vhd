----------------------------------------------------------------------------------
-- Company: Universidad Complutense de Madrid
-- Engineer: Andres Gamboa Melendez
-- 
-- Create Date: 02:05:02 10/12/2014 
-- Design Name: Modulo Busqueda de Instrucciones
-- Module Name: Phase0_InstructionFetch - Behavioral 
-- Project Name: ARM compatible micro-processor
-- Target Devices: Nexys4
-- Tool versions: Xilinx ISE Webpack 14.4
-- Description: Primera fase del microprocesador segmentado, contiene contador de programa 
--              y memoria de instrucciones.
--
-- Dependencies: pcAdder (Sumador de contador de programa), MemInstruction (Memoria de instrucciones).
--                
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

entity Phase0_InstructionFetch is
   Port ( clk, rst : in STD_LOGIC;
   
   -- Entradas
      in_pc_salto 	 : in STD_LOGIC_VECTOR (31 downto 0);       -- Direccion de salto
      in_pc_salto_ctr : in STD_LOGIC;								     -- Señal de control de salto

   -- Salidas
      out_pc_reg 			: out  STD_LOGIC_VECTOR (31 downto 0);   -- Valor de pc siguiente
      out_instruction_reg : out  STD_LOGIC_VECTOR (31 downto 0)  -- Valor de Instruccion
   ); 
end Phase0_InstructionFetch;

architecture Behavioral of Phase0_InstructionFetch is

   --Modulo de memoria de Instrucciones
   component MemInstruction
      Port ( in_pc : in  STD_LOGIC_VECTOR (31 downto 0);
             out_instruction : out  STD_LOGIC_VECTOR (31 downto 0));
   end component; 

   --Modulo sumador pc
   component pcAdder
      Port ( in_pc : in  STD_LOGIC_VECTOR (31 downto 0);
             out_pc : out  STD_LOGIC_VECTOR (31 downto 0));
   end component;

   -- señales PC
-- Registro contador de programa
   signal s_pc_reg : STD_LOGIC_VECTOR (31 downto 0); 
-- Resultado de sumar 4 a registro de programa, salida de PCAdder (pc+4)
   signal s_pc4 : STD_LOGIC_VECTOR (31 downto 0); 
-- Siguiente contador de programa, salida de multiplexor (pc+4 ó pc_salto)
   signal s_pc_next : STD_LOGIC_VECTOR (31 downto 0); 

   -- señales de instruccion
-- Instruccion en dirección "s_pc_reg", salida de modulo memoria de instrucciones
   signal s_instruction : STD_LOGIC_VECTOR (31 downto 0); 

begin
--------Contador de Programa---------

   -- Multiplexor para contador de programa
   p_mux_pc: process(in_pc_salto_ctr, s_pc4, in_pc_salto)
   begin
      if in_pc_salto_ctr='0' then
         s_pc_next <= s_pc4;
      else
         s_pc_next <= in_pc_salto;   
      end if;
   end process;

   -- Guardar valor de contador de programa
   p_bi_pc: process(rst, clk)
   begin
      if rising_edge(clk) then
         if rst='0' then
            s_pc_reg <= (others=>'0');
         else
            s_pc_reg <= s_pc_next;
         end if;
      end if;
   end process;
   
   --Modulo sumador pc
   -- Suma 4 al valor actual del contador de programa (s_pc_reg) 
   --    y lo asigna a la señal (s_pc4)
   i_pcAdder: pcAdder port map( in_pc => s_pc_reg,
                                out_pc => s_pc4 
                               );
--------Contador de Programa---------

-------Memoria de instrucciones------
   --Modulo de memoria de Instrucciones
   -- Devuelve la instruccion situada en la direccion solicitada
   --    por el contador de programa, la instruccion devuelta la asigna
   --    a la señal (s_instruction)
   i_MemInstruction: MemInstruction port map( in_pc => s_pc_reg,
                                              out_instruction => s_instruction
                                             );
-------Memoria de instrucciones------



---------Registros de salida---------
  -- Guardar valores en biestables de salida
   p_bi_salida: process(rst, clk)
   begin
      if clk'event and clk='1' then
         if rst='0' then
            out_pc_reg <= (others=>'0');
            out_instruction_reg <= (others=>'0');
         else
            out_pc_reg <= s_pc4;
            out_instruction_reg <= s_instruction;
         end if;
      end if;
   end process;
---------Registros de salida---------

end Behavioral;
