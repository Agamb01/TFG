----------------------------------------------------------------------------------
-- Company: Universidad Complutense de Madrid
-- Engineer: Andres Gamboa Melendez
-- 
-- Create Date:    09:50:45 10/28/2014 
-- Design Name:    1
-- Module Name:    Decodification - Behavioral 
-- Project Name: ARM compatible micro-processor
-- Target Devices: Nexys4
-- Tool versions: Xilinx ISE Webpack 14.4
-- Description: Segunda fase del microprocesador segmentado.
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

entity Phase1_Decodification is
   Port ( clk, rst : in STD_LOGIC; -- clock y reset
          
   -- Entradas
      in_pc            : in STD_LOGIC_VECTOR(31 downto 0);  -- Entrada de contador de programa
      in_instruction   : in STD_LOGIC_VECTOR(31 downto 0);  -- Instruccion actual
      in_regW          : in STD_LOGIC_VECTOR(3 downto 0);   -- 
      in_busW          : in STD_LOGIC_VECTOR(31 downto 0);  -- 

   -- Salidas
      out_pc_reg       : out STD_LOGIC_VECTOR(31 downto 0); -- Salida de contador de programa
      out_busA_reg     : out STD_LOGIC_VECTOR(31 downto 0); -- Datos de registro A
      out_busB_reg     : out STD_LOGIC_VECTOR(31 downto 0); -- Datos de registro B
      out_regW0_reg    : out STD_LOGIC_VECTOR(3 downto 0);  -- Registro destino 0 (bits 15-12)
      out_regW1_reg    : out STD_LOGIC_VECTOR(3 downto 0);  -- Registro destino 1 (bits 14-11)
      out_integer_reg  : out STD_LOGIC_VECTOR(31 downto 0);  -- entero con extension de signo
      
   -- Señales de control (Entradas)
      in_ctr_WREnable : in STD_LOGIC
   -- Señales de control (Salidas)
      
   );
end Phase1_Decodification;

architecture Behavioral of Phase1_Decodification is

-- Modulo banco de registros
   component RegisterBank
      port ( in_regA : in STD_LOGIC_VECTOR(3 downto 0);
             in_regB : in STD_LOGIC_VECTOR(3 downto 0);
             in_regW : in STD_LOGIC_VECTOR(3 downto 0);  
             in_busW : in STD_LOGIC_VECTOR(31 downto 0);
             in_ctr_WREnable : in STD_LOGIC;
             out_busA : out STD_LOGIC_VECTOR(31 downto 0);
             out_busB : out STD_LOGIC_VECTOR(31 downto 0)
            );
   end component;

   signal s_regA : STD_LOGIC_VECTOR(3 downto 0);   -- Registro A
   signal s_regB : STD_LOGIC_VECTOR(3 downto 0);   -- Registro B
   signal s_busA : STD_LOGIC_VECTOR(31 downto 0);  -- Registro B
   signal s_busB : STD_LOGIC_VECTOR(31 downto 0);  -- Registro B

   signal s_regW0 : STD_LOGIC_VECTOR(3 downto 0); -- Registro destino0
   signal s_regW1 : STD_LOGIC_VECTOR(3 downto 0); -- Registro destino1
   
   signal s_integer : STD_LOGIC_VECTOR(31 downto 0); -- Entero 
   
   --señales de control
   signal s_ctr_move : STD_LOGIC; -- Indica si es una operación MOVE
   
begin

---------Banco de Registros---------
   s_regA <= in_instruction(19 downto 16);  -- Rn[19-16]
   s_regB <= in_instruction(3 downto 0);    -- Rm[3-0]

   i_RegisterBank: RegisterBank port map (
          in_regA => s_regA,  
          in_regB => s_regB,  
          in_regW => in_regW,  
          in_busW => in_busW, 
          in_ctr_WREnable => in_ctr_WREnable,
          out_busA => s_busA, 
          out_busB => s_busB
         );
         
    s_regW0 <= in_instruction(11 downto 8); -- Rd[11-8]
    s_regW1 <= in_instruction(15 downto 12); -- Rt[15-12]
---------Banco de Registros---------

---------Entero---------                                    --TODO: Revisar

--Operacion move si in_instruction(25 dwonto 22)="10X1"
   s_ctr_move <= (not in_instruction(24)) and (in_instruction(25) and in_instruction(22));

   p_integer: process(in_instruction, s_ctr_move)
   begin
      s_integer(7 downto 0) <= in_instruction(7 downto 0);
      s_integer(10 downto 8) <= in_instruction(14 downto 12);
      s_integer(11) <= in_instruction(26);
      if s_ctr_move='0' then
         s_integer(31 downto 12) <= (others=>in_instruction(26));
      else
         s_integer(15 downto 12) <= in_instruction(19 downto 16);
         s_integer(31 downto 16) <= (others=>in_instruction(19));
      end if;   
   end process;
---------Entero---------

---------Control Principal----------
-- TODO:
-- i_ControlPrincipal: ControlPrincipal port map (
--       );
---------Control Principal----------

---------Registros de salida---------
   -- Guardar valores de salida 
   process(clk, rst)
   begin
      if clk'event and clk='0' then
         if rst='0' then
            out_pc_reg <= (others=>'0');        
            out_busA_reg <= (others=>'0');
            out_busB_reg <= (others=>'0');
            out_regW0_reg <= (others=>'0');
            out_regW1_reg <= (others=>'0');
            out_integer_reg <= (others=>'0');
         else
            out_pc_reg <= in_pc;
            out_busA_reg <= s_busA;
            out_busB_reg <= s_busB;
            out_regW0_reg <= s_regW0;
            out_regW1_reg <= s_regW1;
            out_integer_reg <= s_integer;
         end if;
      end if;
   end process;
---------Registros de salida---------

end Behavioral;

