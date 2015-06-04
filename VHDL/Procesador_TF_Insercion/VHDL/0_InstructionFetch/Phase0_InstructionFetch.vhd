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
   Generic (
      address_size : INTEGER := 32;
      inst_size : INTEGER := 32
   );
   Port (
   -- Entradas
      in_pc : in STD_LOGIC_VECTOR (address_size-1 downto 0); -- Direccion PC
   -- Salidas
      out_pc : out  STD_LOGIC_VECTOR (address_size-1 downto 0);   -- Valor de pc + 4
      out_inst : out  STD_LOGIC_VECTOR (inst_size-1 downto 0)  -- Valor de Instruccion en direccion PC
   ); 
end Phase0_InstructionFetch;

architecture Behavioral of Phase0_InstructionFetch is

---------------------------------Sumador PC---------------------------------
   --Modulo sumador pc
   component pcAdder
      Generic(
         size : INTEGER := 32
      );
      Port ( 
         in_pc : in  STD_LOGIC_VECTOR (31 downto 0);
         out_pc : out  STD_LOGIC_VECTOR (31 downto 0)
      );
   end component;
---------------------------------Sumador PC---------------------------------

---------------------------------Memoria de instrucciones---------------------------------
   component MemInstruction0
      Port ( in_pc : in  STD_LOGIC_VECTOR (31 downto 0);
             out_inst : out  STD_LOGIC_VECTOR (31 downto 0));
   end component; 

   component MemInstruction1
      Port ( in_pc : in  STD_LOGIC_VECTOR (31 downto 0);
             out_inst : out  STD_LOGIC_VECTOR (31 downto 0));
   end component; 

   component MemInstruction2
      Port ( in_pc : in  STD_LOGIC_VECTOR (31 downto 0);
             out_inst : out  STD_LOGIC_VECTOR (31 downto 0));
   end component; 
   
   component MemInstruction3
      Port ( in_pc : in  STD_LOGIC_VECTOR (31 downto 0);
             out_inst : out  STD_LOGIC_VECTOR (31 downto 0));
   end component; 
---------------------------------Memoria de instrucciones---------------------------------

begin

---------------------------------Sumador PC---------------------------------
   --Modulo sumador pc
   -- Suma 4 al valor actual del contador de programa (s_pc_reg) 
   --    y lo asigna a la señal (s_pc4)
   i_pcAdder: pcAdder port map( 
         in_pc => in_pc,
         out_pc => out_pc 
   );
---------------------------------Sumador PC---------------------------------

---------------------------------Memoria de instrucciones---------------------------------
   --Modulo de memoria de Instrucciones
   -- Devuelve la instruccion situada en la direccion solicitada
   --    por el contador de programa, la instruccion devuelta la asigna
   --    a la señal (s_inst)
   i_MemInstruction: MemInstruction3 port map( 
         in_pc => in_pc,
         out_inst => out_inst
   );
                                             
---------------------------------Memoria de instrucciones---------------------------------

end Behavioral;
