----------------------------------------------------------------------------------
-- Company: Universidad Complutense de Madrid
-- Engineer: Andres Gamboa Melendez
-- 
-- Module Name: ALU - Behavioral 
-- Project Name: ARM compatible micro-processor
-- Target Devices: Nexys4
-- Tool versions: Xilinx ISE Webpack 14.4
-- Description: Ejecuta la operación seleccionada sobre los operandos de entrada, y 
--              mantiene los flags de comparación.
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

entity ALU is
   Port ( 
      -- ENTRADAS
      in_A : in  STD_LOGIC_VECTOR (31 downto 0);
      in_B : in  STD_LOGIC_VECTOR (31 downto 0);
      in_op : in STD_LOGIC_VECTOR (2 downto 0);
      -- SALIDAS
      out_R : out  STD_LOGIC_VECTOR (31 downto 0);
      out_f : out  STD_LOGIC_VECTOR (1 downto 0) -- Flags(N,Z)
   );
end ALU;

-- Tabla operaciones
-- ADD  000
-- SUB  001
-- MOV  010
-- MOVT 011

-- AND  100
-- ORR  101
-- EOR  110
-- CMP  111


architecture Behavioral of ALU is

   signal s_R : std_logic_vector(31 downto 0);
   --Flags:
   -- N -> Negative
   -- Z -> Zero
   -- C -> Carry (No implementado)
   -- V -> Overflow (No implementado)
   signal N, Z : std_logic;

begin
   
   out_R <= s_R;
   out_f <= N & Z;   
   
   --Proceso Aritmetico-Logico
   p_arith: process(in_A, in_B, in_op)
   begin
      case in_op is
         when "000" => -- ADD: Add
            s_R <= std_logic_vector(signed(in_A) + signed(in_B));
            N <= '0';
            Z <= '0'; 
         when "001" => -- SUB: Subtract
            s_R <= std_logic_vector(signed(in_A) - signed(in_B));
            N <= '0';
            Z <= '0'; 
         when "010" => -- MOV: Move wide
            s_R(31 downto 16) <= in_B(31 downto 16);
            s_R(15 downto 0)  <= in_B(15 downto 0);
            N <= '0';
            Z <= '0'; 
         when "011" => -- MOVT: Move top
            s_R(31 downto 16) <= in_B(15 downto 0);
            s_R(15 downto 0)  <= in_A(15 downto 0);
            N <= '0';
            Z <= '0'; 
         when "100" => -- AND: Logic and
            s_R <= in_A and in_B;
            N <= '0';
            Z <= '0'; 
         when "101" => -- OR: Logic or
            s_R <= in_A or in_B;
            N <= '0';
            Z <= '0'; 
         when "110" => -- EOR: Logic exclusive or
            s_R <= in_A xor in_B;
            N <= '0';
            Z <= '0'; 
         when "111" => -- CMP: Compare and set flags (N, Z)
            s_R <= (others=>'0');
            if in_A = in_B then
               N <= '0';
               Z <= '1'; 
            elsif in_A < in_B then
               N <= '1';
               Z <= '0'; 
            else
               N <= '0';
               Z <= '0'; 
            end if;
         when others =>
            s_R <= (others=>'0');
            N <= '0';
            Z <= '0';  
      end case;
   end process;
   
   
   
   
end Behavioral;

