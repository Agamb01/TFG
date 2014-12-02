----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:04:00 10/12/2014 
-- Design Name: 
-- Module Name:    Processor - Behavioral 
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


-- Nomenclatura
----Instancias de modulos:
------Registro: i_<phase>_<data>_reg<num>




entity Processor is
   Port ( 
      clk, rst : in STD_LOGIC; -- Clock y reset estandar
      
      -- Test in (IF)
      test_pc_salto     : in STD_LOGIC_VECTOR(31 downto 0);
      test_pc_mux_ctr   : in STD_LOGIC;
      test_if_enable    : in STD_LOGIC;
      
      -- Test in (ID)
      test_id_enable       : in STD_LOGIC;
      test_id_ctr_WREnable : in STD_LOGIC;
      test_id_regW         : in STD_LOGIC_VECTOR(3 downto 0);
      test_id_busW         : in STD_LOGIC_VECTOR(31 downto 0);

      -- Test out (ID)
      test_id_pc_reg      : out STD_LOGIC_VECTOR(31 downto 0);
      test_id_busA_reg    : out STD_LOGIC_VECTOR(31 downto 0);
      test_id_busB_reg    : out STD_LOGIC_VECTOR(31 downto 0);
      test_id_entero_reg  : out STD_LOGIC_VECTOR(31 downto 0);
      test_id_regW0_reg   : out STD_LOGIC_VECTOR(3 downto 0);
      test_id_regW1_reg   : out STD_LOGIC_VECTOR(3 downto 0);
      test_id_WB_ctr_reg  : out STD_LOGIC_VECTOR(11 downto 0);
      test_id_MEM_ctr_reg : out STD_LOGIC_VECTOR(9 downto 0);
      test_id_EXE_ctr_reg : out STD_LOGIC_VECTOR(9 downto 0)
   );
end Processor;

architecture Behavioral of Processor is

component reg_async is
   Generic (
      size : INTEGER := 32
   );
   Port ( 
      clk, rst : in STD_LOGIC;
      enable : in STD_LOGIC;
      in_data : in STD_LOGIC_VECTOR(size-1 downto 0); --size-1?
      out_data : out  STD_LOGIC_VECTOR (size-1 downto 0)
   );
end component;

component mux2 is
   Generic (
      size : INTEGER := 32
   );
   Port ( 
      in_A : in STD_LOGIC_VECTOR (size-1 downto 0);
      in_B : in STD_LOGIC_VECTOR (size-1 downto 0);
      sel : in STD_LOGIC;
      out_C : out STD_LOGIC_VECTOR (size-1 downto 0)
   );
end component;

---------------------------------Instruction Fetch---------------------------------
component Phase0_InstructionFetch is
   Generic (
      address_size : INTEGER := 32;
      instruction_size : INTEGER := 32
   );
   Port (
      in_pc : in STD_LOGIC_VECTOR (address_size-1 downto 0);               -- Direccion de salto
      out_pc : out STD_LOGIC_VECTOR (address_size-1 downto 0);             -- Valor de pc siguiente
      out_instruction : out STD_LOGIC_VECTOR (instruction_size-1 downto 0) -- Valor de Instruccion
   ); 
end component;

-- Se�ales Registro PC
signal s_pc4 : STD_LOGIC_VECTOR(31 downto 0);                     -- Direccion PC+4
signal s_pc_salto : STD_LOGIC_VECTOR(31 downto 0);                -- Direccion salto PC (EXE->PC)
signal s_pc_mux_ctr : STD_LOGIC;                                  -- Control multiplexor (0-PC+4/1-PC_salto)
signal s_pc_next : STD_LOGIC_VECTOR(31 downto 0);                 -- Direccion PC seleccionada
signal s_pc_reg : STD_LOGIC_VECTOR(31 downto 0) := (others=>'0'); -- Registro PC
signal s_pc_enable : STD_LOGIC;                                   -- Habilita registro PC

-- Se�ales de Instruccion
signal s_inst : STD_LOGIC_VECTOR(31 downto 0); -- Intruccion

-- Registros de cambio de fase
signal s_if_pc_reg : STD_LOGIC_VECTOR(31 downto 0);   -- Registro PC (IF->ID)
signal s_if_pc_enable : STD_LOGIC;                    -- Habilitar registro PC (IF->ID)
signal s_if_inst_reg : STD_LOGIC_VECTOR(31 downto 0); -- Resgistro instruccion (IF->ID)
signal s_if_inst_enable : STD_LOGIC;                  -- Habilitar resgistro instruccion (IF->ID)
---------------------------------Instruction Fetch---------------------------------

---------------------------------Instruction Decode---------------------------------
component Phase1_InstructionDecode
   Port ( clk, rst : in STD_LOGIC;
   -- Entradas (IF->ID)
--      in_pc            : in STD_LOGIC_VECTOR(31 downto 0);  -- Entrada de contador de programa
      in_instruction   : in STD_LOGIC_VECTOR(31 downto 0);  -- Instruccion actual

   -- Salidas (ID->EXE)
--      out_pc       : out STD_LOGIC_VECTOR(31 downto 0); -- Salida de contador de programa
      out_busA     : out STD_LOGIC_VECTOR(31 downto 0); -- Datos de registro A
      out_busB     : out STD_LOGIC_VECTOR(31 downto 0); -- Datos de registro B
      out_regW0    : out STD_LOGIC_VECTOR(3 downto 0);  -- Registro destino 0 (bits 15-12)
      out_regW1    : out STD_LOGIC_VECTOR(3 downto 0);  -- Registro destino 1 (bits 14-11)
      out_entero   : out STD_LOGIC_VECTOR(31 downto 0);  -- entero con extension de signo
      
   -- Se�ales de control (WB->ID)
      in_ctr_WREnable : in STD_LOGIC;
      in_regW         : in STD_LOGIC_VECTOR(3 downto 0);   -- 
      in_busW         : in STD_LOGIC_VECTOR(31 downto 0);  -- 

   -- Se�ales de control (ID->EXE)
      out_WB_control  : out STD_LOGIC_VECTOR(11 downto 0);
      out_MEM_control : out STD_LOGIC_VECTOR(9 downto 0);
      out_EXE_control : out STD_LOGIC_VECTOR(9 downto 0)
   );
end component;

-- Registros de cambio de fase
   -- Se�al de PC
   signal s_id_pc_reg         : STD_LOGIC_VECTOR(31 downto 0);
   signal s_id_pc_enable      : STD_LOGIC;
   -- Se�ales de datos
   signal s_id_busA           : STD_LOGIC_VECTOR(31 downto 0);
   signal s_id_busA_reg       : STD_LOGIC_VECTOR(31 downto 0);
   signal s_id_busA_enable    : STD_LOGIC;
   signal s_id_busB           : STD_LOGIC_VECTOR(31 downto 0);
   signal s_id_busB_reg       : STD_LOGIC_VECTOR(31 downto 0);
   signal s_id_busB_enable    : STD_LOGIC;
   -- Se�ales de entero
   signal s_id_entero         : STD_LOGIC_VECTOR(31 downto 0);
   signal s_id_entero_reg     : STD_LOGIC_VECTOR(31 downto 0);
   signal s_id_entero_enable  : STD_LOGIC;
   -- Re�ales de registros destino
   signal s_id_regW0          : STD_LOGIC_VECTOR(3 downto 0);
   signal s_id_regW0_reg      : STD_LOGIC_VECTOR(3 downto 0);
   signal s_id_regW0_enable   : STD_LOGIC;
   signal s_id_regW1          : STD_LOGIC_VECTOR(3 downto 0);
   signal s_id_regW1_reg      : STD_LOGIC_VECTOR(3 downto 0);
   signal s_id_regW1_enable   : STD_LOGIC;
   -- Se�ales de control (ID->EXE)
   signal s_id_WB_ctr         : STD_LOGIC_VECTOR(11 downto 0);
   signal s_id_WB_ctr_reg     : STD_LOGIC_VECTOR(11 downto 0);
   signal s_id_WB_ctr_enable  : STD_LOGIC;
   signal s_id_MEM_ctr        : STD_LOGIC_VECTOR(9 downto 0);
   signal s_id_MEM_ctr_reg    : STD_LOGIC_VECTOR(9 downto 0);
   signal s_id_MEM_ctr_enable : STD_LOGIC;
   signal s_id_EXE_ctr        : STD_LOGIC_VECTOR(9 downto 0);
   signal s_id_EXE_ctr_reg    : STD_LOGIC_VECTOR(9 downto 0);
   signal s_id_EXE_ctr_enable : STD_LOGIC;
---------------------------------Instruction Decode---------------------------------

begin

--TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST
s_pc_salto     <= test_pc_salto;
s_pc_mux_ctr   <= test_pc_mux_ctr;

s_pc_enable       <= test_if_enable;
s_if_inst_enable  <= test_if_enable;
s_if_pc_enable    <= test_if_enable;

test_id_pc_reg       <= s_id_pc_reg;
test_id_busA_reg     <= s_id_busA_reg; 
test_id_busB_reg     <= s_id_busB_reg;
test_id_entero_reg   <= s_id_entero_reg; 
test_id_regW0_reg    <= s_id_regW0_reg;
test_id_regW1_reg    <= s_id_regW1_reg;
test_id_WB_ctr_reg   <= s_id_WB_ctr_reg; 
test_id_MEM_ctr_reg  <= s_id_MEM_ctr_reg; 
test_id_EXE_ctr_reg  <= s_id_EXE_ctr_reg; 

s_id_pc_enable       <= test_id_enable;
s_id_busA_enable     <= test_id_enable; 
s_id_busB_enable     <= test_id_enable;
s_id_entero_enable   <= test_id_enable; 
s_id_regW0_enable    <= test_id_enable;
s_id_regW1_enable    <= test_id_enable;
s_id_WB_ctr_enable   <= test_id_enable; 
s_id_MEM_ctr_enable  <= test_id_enable; 
s_id_EXE_ctr_enable  <= test_id_enable; p

--TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST

---------------------------------PC---------------------------------

   -- Multiplexor para contador de programa
i_pc_mux: mux2
   port map( 
      in_A => s_pc4,
      in_B => s_pc_salto,
      sel => s_pc_mux_ctr,
      out_C => s_pc_next
   );

i_pc_reg0: reg_async 
   port map( 
      clk => clk,
      rst => rst,
      enable => s_pc_enable,
      in_data => s_pc_next,
      out_data => s_pc_reg
   );
---------------------------------PC---------------------------------

---------------------------------Instruction Fetch---------------------------------
i_phase0: Phase0_InstructionFetch 
   generic map(
      address_size => 32,
      instruction_size => 32   
   ) 
   port map(
      in_pc => s_pc_reg,
      out_pc => s_pc4,
      out_instruction => s_inst
   );
   
i_if_pc_reg0: reg_async 
   port map( 
      clk => clk,
      rst => rst,
      enable => s_if_pc_enable,
      in_data => s_pc4,
      out_data => s_if_pc_reg
   );

i_if_inst_reg0: reg_async 
   port map( 
      clk => clk,
      rst => rst,
      enable => s_if_inst_enable,
      in_data => s_inst,
      out_data => s_if_inst_reg
   );
---------------------------------Instruction Fetch---------------------------------

---------------------------------Instruction Decode---------------------------------
i_phase1: Phase1_InstructionDecode 
   port map ( 
      clk => clk, 
      rst => rst,  
         
   -- Entradas (IF->ID)
      in_instruction => s_if_inst_reg,

   -- Salidas (ID->EXE)
      out_busA => s_id_busA,
      out_busB => s_id_busB,
      out_regW0 => s_id_regW0,
      out_regW1 => s_id_regW1,
      out_entero => s_id_entero,
      
   -- Se�ales de control (WB->ID)
      in_ctr_WREnable => test_id_ctr_WREnable,
      in_regW => test_id_regW,
      in_busW => test_id_busW,

   -- Se�ales de control (ID->EXE)
      out_WB_control => s_id_WB_ctr,
      out_MEM_control => s_id_MEM_ctr,
      out_EXE_control => s_id_EXE_ctr
   );

i_id_pc_reg0: reg_async 
   port map( 
      clk => clk,
      rst => rst,
      enable => s_id_pc_enable,
      in_data => s_if_pc_reg,
      out_data => s_id_pc_reg
   );
   
i_id_WB_ctr_reg0: reg_async 
   generic map(
      size => 12
   )
   port map( 
      clk => clk,
      rst => rst,
      enable => s_id_WB_ctr_enable,
      in_data => s_id_WB_ctr,
      out_data => s_id_WB_ctr_reg
   );
   
i_id_MEM_ctr_reg0: reg_async 
   generic map(
      size => 10
   )
   port map( 
      clk => clk,
      rst => rst,
      enable => s_id_MEM_ctr_enable,
      in_data => s_id_MEM_ctr,
      out_data => s_id_MEM_ctr_reg
   );
   
i_id_EXE_ctr_reg0: reg_async 
   generic map(
      size => 10
   )
   port map( 
      clk => clk,
      rst => rst,
      enable => s_id_EXE_ctr_enable,
      in_data => s_id_EXE_ctr,
      out_data => s_id_EXE_ctr_reg
   );

i_id_busA_reg0: reg_async 
   port map( 
      clk => clk,
      rst => rst,
      enable => s_id_busA_enable,
      in_data => s_id_busA,
      out_data => s_id_busA_reg
   );

i_id_busB_reg0: reg_async 
   port map( 
      clk => clk,
      rst => rst,
      enable => s_id_busB_enable,
      in_data => s_id_busB,
      out_data => s_id_busB_reg
   );

i_id_entero_reg0: reg_async 
   port map( 
      clk => clk,
      rst => rst,
      enable => s_id_entero_enable,
      in_data => s_id_entero,
      out_data => s_id_entero_reg
   );

i_id_regW0_reg0: reg_async 
   generic map(
      size => 4
   )
   port map( 
      clk => clk,
      rst => rst,
      enable => s_id_regW0_enable,
      in_data => s_id_regW0,
      out_data => s_id_regW0_reg
   );

i_id_regW1_reg0: reg_async 
   generic map(
      size => 4
   )
   port map( 
      clk => clk,
      rst => rst,
      enable => s_id_regW1_enable,
      in_data => s_id_regW1,
      out_data => s_id_regW1_reg
   );

---------------------------------Instruction Decode---------------------------------

end Behavioral;

