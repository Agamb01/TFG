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
      
      -- Test in
      test_pc_salto : in STD_LOGIC_VECTOR(31 downto 0);
      test_pc_mux_ctr : in STD_LOGIC;
      test_enable : in STD_LOGIC;
      
      -- Test out
      test_pc  : out STD_LOGIC_VECTOR(31 downto 0);
      test_instr : out STD_LOGIC_VECTOR(31 downto 0)
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

-- Señales Registro PC
signal s_pc4 : STD_LOGIC_VECTOR(31 downto 0);                     -- Direccion PC+4
signal s_pc_salto : STD_LOGIC_VECTOR(31 downto 0);                -- Direccion salto PC (de fase exe)
signal s_pc_mux_ctr : STD_LOGIC;                                  -- Control multiplexor (0-PC+4/1-PC_salto)
signal s_pc_next : STD_LOGIC_VECTOR(31 downto 0);                 -- Direccion PC seleccionada
signal s_pc_reg : STD_LOGIC_VECTOR(31 downto 0) := (others=>'0'); -- Registro PC
signal s_pc_enable : STD_LOGIC;                                   -- Habilita registro PC

-- Señales de Instruccion
signal s_inst : STD_LOGIC_VECTOR(31 downto 0); -- Intruccion

-- Registros de cambio de fase
signal s_if_pc_reg : STD_LOGIC_VECTOR(31 downto 0);   -- Registro PC (IF->ID)
signal s_if_pc_enable : STD_LOGIC;                    -- Habilitar registro PC (IF->ID)
signal s_if_inst_reg : STD_LOGIC_VECTOR(31 downto 0); -- Resgistro instruccion (IF->ID)
signal s_if_inst_enable : STD_LOGIC;                  -- Habilitar resgistro instruccion (IF->ID)
---------------------------------Instruction Fetch---------------------------------

begin

--TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST
test_instr <= s_if_inst_reg;
test_pc <= s_if_pc_reg;

s_pc_salto <= test_pc_salto;
s_pc_mux_ctr <= test_pc_mux_ctr;

s_pc_enable <= test_enable;
s_if_inst_enable <= test_enable;
s_if_pc_enable <= test_enable;

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




end Behavioral;

