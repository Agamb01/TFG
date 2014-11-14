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

entity Decodification is
   Port ( clk, rst         : in STD_LOGIC;                        -- clock y reset
          pc_in            : in STD_LOGIC_VECTOR(31 downto 0);    -- Entrada de contador de programa
          instruction_in   : in STD_LOGIC_VECTOR(31 downto 0);    -- Instruccion actual
          --Entradas busW y regW
          pc_out_reg       : out STD_LOGIC_VECTOR(31 downto 0);   -- Salida de contador de programa
          bus_A_out_reg    : out STD_LOGIC_VECTOR(31 downto 0);   -- Datos de registro A
          bus_B_out_reg    : out STD_LOGIC_VECTOR(31 downto 0);   -- Datos de registro B
          reg_destA_out_reg : out STD_LOGIC_VECTOR(4 downto 0);   -- Registro destino A (bits 20-16)
          reg_destB_out_reg : out STD_LOGIC_VECTOR(4 downto 0);   -- Registro destino B (bits 15-11)
          integer_out_reg  : out STD_LOGIC_VECTOR(31 downto 0)   -- entero con extension de signo
        );
end Decodification;

architecture Behavioral of Decodification is

component RegisterBank
   port ( RA : in STD_LOGIC_VECTOR(3 downto 0);
          RB : in STD_LOGIC_VECTOR(3 downto 0);
          RW : in STD_LOGIC_VECTOR(3 downto 0);  
          BusW : in STD_LOGIC_VECTOR(31 downto 0);
          busA : out STD_LOGIC_VECTOR(31 downto 0);
          busB : out STD_LOGIC_VECTOR(31 downto 0)
         );
end component;

--   signal Control_principal : STD_LOGIC_VECTOR( downto 0);  -- temp
   signal reg_A : STD_LOGIC_VECTOR(3 downto 0);              -- Registro A
   signal reg_B : STD_LOGIC_VECTOR(3 downto 0);              -- Registro B
   signal bus_A : STD_LOGIC_VECTOR(31 downto 0);              -- Registro B
   signal bus_B : STD_LOGIC_VECTOR(31 downto 0);              -- Registro B

--   signal reg_W : STD_LOGIC_VECTOR(3 downto 0);              -- Registro destino
--   signal integer_inst : STD_LOGIC_VECTOR( downto 0);       -- Entero de instruccion 
   
begin

reg_A <= instruction_i(19 downto 16);
reg_B <= instruction_i(11 downto 8);

i_RegisterBank: RegisterBank port map (
          RA => reg_A,
          RB => reg_B,
          RW => reg_W,   -- Arreglar
          BusW => bus_W, -- Arreglar
          busA => bus_A,
          busB => bus_B,
         );

   -- Guardar contador de programa en registro de salida
   process(clk, rst)
   begin
      if clk'event and clk='0' then
         if rst='0' then
            pc_out_reg <= (others => '0');
         else
            pc_out_reg <= pc_in;
         end if;
      end if;
   end process;

   -- (ARM) Extension de signo
   process(clk, rst)
   begin
      if clk'event and clk='0' then
         if rst='0' then
            integer_out_reg <= (others => '0');
         else
            integer_out_reg(15 downto 0) <= instruction_in(15 downto 0);
            integer_out_reg(31 downto 16) <= (others => instruction_in(15));
         end if;
      end if;
   end process;

   -- (ARM) Registros destino
   process(clk, rst)
   begin
      if clk'event and clk='0' then
         if rst='0' then
            reg_destA_out_reg <= (others => '0');
            reg_destB_out_reg <= (others => '0');
         else
            reg_destA_out_reg <= instruction_in(20 downto 16);
            reg_destB_out_reg <= instruction_in(15 downto 11);
         end if;
      end if;
   end process;

end Behavioral;

