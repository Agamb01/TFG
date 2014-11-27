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

entity Processor is
   Port ( 
      clk, rst : in STD_LOGIC -- Clock y reset estandar
   );
end Processor;

architecture Behavioral of Processor is

component reg is
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

---------------------------------Instruction Fetch---------------------------------
component Phase0_InstructionFetch is
   Generic (
      address_size : INTEGER := 32;
      instruction_size : INTEGER := 32
   );
   Port ( clk, rst : in STD_LOGIC; -- Clock y reset estandar
   -- Entradas
      in_pc : in STD_LOGIC_VECTOR (address_size-1 downto 0);       -- Direccion de salto
   -- Salidas
      out_pc : out STD_LOGIC_VECTOR (address_size-1 downto 0);   -- Valor de pc siguiente
      out_instruction : out STD_LOGIC_VECTOR (instruction_size-1 downto 0)  -- Valor de Instruccion
   ); 
end component;

signal s_ctr_mux_pc : STD_LOGIC;

signal s_pc4 : STD_LOGIC_VECTOR(31 downto 0);
signal s_pc_salto : STD_LOGIC_VECTOR(31 downto 0);
signal s_pc_next : STD_LOGIC_VECTOR(31 downto 0);
signal s_pc_reg : STD_LOGIC_VECTOR(31 downto 0);

signal s_pc_enable : STD_LOGIC;

---------------------------------Instruction Fetch---------------------------------

begin

---------------------------------Instruction Fetch---------------------------------

   -- Multiplexor para contador de programa
p_mux_pc: process(s_pc_salto_ctr, s_pc4, s_pc_salto)
   begin
      if s_pc_salto_ctr='0' then
         s_pc_next <= s_pc4;
      else
         s_pc_next <= s_pc_salto;   
      end if;
   end process;

i_phase0: Phase0_InstructionFetch 
   generic map(
      address_size => 32,
      instruction_size => 32   
   ) 
   port map(
      clk => clk,
      rst => rst,
      in_pc => s_pc_reg,
      out_pc => s_pc4,
      out_instruction => s_instruction
   );

i_pc_reg: reg 
   generic map(
      size => 32
   )
   port map( 
      clk => clk,
      rst => rst,
      enable => s_pc_enable,
      in_data => s_pc_next,
      out_data => s_pc_reg
   );
---------------------------------Instruction Fetch---------------------------------




end Behavioral;

