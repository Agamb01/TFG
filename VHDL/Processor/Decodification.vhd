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

<<<<<<< HEAD:VHDL/Processor/Phase1_Decodification.vhd


-- TODO: Control principal
--       Banco de registros
--       Extension de signos para LOAD/STORE
--       Testbench
--       Añadir señales de control



entity Phase1_Decodification is
   Port ( clk, rst         : in STD_LOGIC;                        -- clock y reset

--Entradas
          in_bus_pc        : in STD_LOGIC_VECTOR(31 downto 0);    -- Entrada de contador de programa
          in_instruction   : in STD_LOGIC_VECTOR(31 downto 0);    -- Instruccion actual
          in_reg_W         : in STD_LOGIC_VECTOR(3 downto 0);     -- Registro destino
          in_bus_W         : in STD_LOGIC_VECTOR(31 downto 0);    -- Datos registro destino

-- Salidas
          out_bus_pc_reg   : out STD_LOGIC_VECTOR(31 downto 0);   -- Salida de contador de programa
          out_bus_A_reg    : out STD_LOGIC_VECTOR(31 downto 0);   -- Datos de registro A
          out_bus_B_reg    : out STD_LOGIC_VECTOR(31 downto 0);   -- Datos de registro B
          out_reg_W1_reg   : out STD_LOGIC_VECTOR(3 downto 0);    -- Registro W (bits 14-11, Rd/Data)
          out_reg_W2_reg   : out STD_LOGIC_VECTOR(3 downto 0);    -- Registro W (bits  15-12, Rt/Load store)
          out_bus_int_reg  : out STD_LOGIC_VECTOR(31 downto 0)    -- entero con extension de signo
 
         );
end Phase1_Decodification;
=======
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
>>>>>>> parent of 53ed39a... Execution phase:VHDL/Processor/Decodification.vhd

architecture Behavioral of Decodification is

component RegisterBank
   port ( in_reg_A : in STD_LOGIC_VECTOR(3 downto 0);
          in_reg_B : in STD_LOGIC_VECTOR(3 downto 0);
          in_reg_W : in STD_LOGIC_VECTOR(3 downto 0);  
          in_bus_W : in STD_LOGIC_VECTOR(31 downto 0);
          out_bus_A : out STD_LOGIC_VECTOR(31 downto 0);
          out_bus_B : out STD_LOGIC_VECTOR(31 downto 0)
         );
end component;

--   signal Control_principal : STD_LOGIC_VECTOR( downto 0);  -- temp
   signal s_reg_A : STD_LOGIC_VECTOR(3 downto 0);              -- Registro A
   signal s_reg_B : STD_LOGIC_VECTOR(3 downto 0);              -- Registro B
   signal s_bus_A : STD_LOGIC_VECTOR(31 downto 0);              -- Datos registro A
   signal s_bus_B : STD_LOGIC_VECTOR(31 downto 0);              -- Datos registro B

   signal s_reg_W1 : STD_LOGIC_VECTOR(3 downto 0);              -- Registro W1
   signal s_reg_W2 : STD_LOGIC_VECTOR(3 downto 0);              -- Registro W2
   
   signal s_ctr_ext_signo : STD_LOGIC;
   signal s_bus_int : STD_LOGIC_VECTOR(31 downto 0);
  
begin

<<<<<<< HEAD:VHDL/Processor/Phase1_Decodification.vhd
-- Recoger bits relevantes en señales faciles de usar 
   s_reg_A <= in_instruction(19 downto 16);  -- Registro Rn [19-16]
   s_reg_B <= in_instruction(3 downto 0);    -- Registro Rm [3-0]
   s_reg_W1 <= in_instruction(14 downto 11); -- (DATA) Registro Rd [14-11]
   s_reg_W2 <= in_instruction(15 downto 12); -- (LD/ST) Registro Rt [15-12]
   
   
   -- if in_instruction(25 downto 22)="10X1) then s_ctr_ext_signo='1'
   s_ctr_ext_signo <= (in_instruction(25) and in_instruction(22)) and (not in_instruction(24));
   
   --TODO: Añadir extension de signo para LOAD/STORE
   --Extensión de signo
   p_ext_signo: process(in_instruction, s_ctr_ext_signo)
=======
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
>>>>>>> parent of 53ed39a... Execution phase:VHDL/Processor/Decodification.vhd
   begin
      s_bus_int(7 downto 0)  <= in_instruction(7 downto 0);
      s_bus_int(10 downto 8) <= in_instruction(14 downto 12);
      s_bus_int(11) <= in_instruction(26);
      if s_ctr_ext_signo='0' then                              -- 12 bit integer
         s_bus_int(31 downto 12) <= (others => in_instruction(14));
      else                                                     -- 16 bit integer
         s_bus_int(15 downto 12) <= in_instruction(19 downto 16);
         s_bus_int(31 downto 16) <= (others => in_instruction(19));
      end if;
   end process;
   
   
   -- Instancia de Banco de registros
   i_RegisterBank: RegisterBank port map (
       in_reg_A => s_reg_A,  -- Entrada
       in_reg_B => s_reg_B,  -- Entrada
       in_reg_W => in_reg_W,  -- Entrada 
       in_bus_W => in_bus_W, -- Entrada
       out_bus_A => s_bus_A, -- Salida
       out_bus_B => s_bus_B -- Salida
      );

-- TODO:
-- i_ControlPrincipal: ControlPrincipal port map (
--       );
   
   -- Guardar registros de salida
   p_reg_salida: process(clk, rst)
   begin
      if rising_edge(clk) then --
         if rst='0' then
            out_bus_pc_reg  <= (others => '0'); -- Datos registro pc
            out_bus_A_reg   <= (others => '0'); -- Datos registro Rn[19-16]
            out_bus_B_reg   <= (others => '0'); -- Datos registro Rm[3-0]
            out_reg_W1_reg  <= (others => '0'); -- Registro Rd [14-11]
            out_reg_W2_reg  <= (others => '0'); -- Registro Rt [15-12]
            out_bus_int_reg <= (others => '0'); -- Entero con extension de signo
         else 
            out_bus_pc_reg  <= in_bus_pc; -- Datos registro PC
            out_bus_A_reg   <= s_bus_A;   -- Datos registro Rn[19-16]
            out_bus_B_reg   <= s_bus_B;   -- Datos registro Rm[3-0]
            out_reg_W1_reg  <= s_reg_W1;  -- Registro Rd [14-11]
            out_reg_W2_reg  <= s_reg_W2;  -- Registro Rt [15-12]
            out_bus_int_reg <= s_bus_int; -- Entero con extension de signo
         end if;
      end if;
   end process;
end Behavioral;

