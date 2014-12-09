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

      -- Test in (EXE)
      test_exe_enable     : in STD_LOGIC;

      -- Test out (EXE)
      test_exe_PCBr_reg      : out STD_LOGIC_VECTOR(31 downto 0);
      test_exe_ALU_bus_reg   : out STD_LOGIC_VECTOR(31 downto 0);
      test_exe_ALU_flags_reg : out STD_LOGIC_VECTOR(0 downto 0);
      test_exe_busB_reg      : out STD_LOGIC_VECTOR(31 downto 0);
      test_exe_regW_reg      : out STD_LOGIC_VECTOR(3 downto 0);
      test_exe_WB_ctr_reg    : out STD_LOGIC_VECTOR(11 downto 0);
      test_exe_MEM_ctr_reg   : out STD_LOGIC_VECTOR(9 downto 0)
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

---------------------------------inst Fetch---------------------------------
component Phase0_InstructionFetch is
   Generic (
      address_size : INTEGER := 32;
      inst_size : INTEGER := 32
   );
   Port (
      in_pc : in STD_LOGIC_VECTOR (address_size-1 downto 0);               -- Direccion de salto
      out_pc : out STD_LOGIC_VECTOR (address_size-1 downto 0);             -- Valor de pc siguiente
      out_inst : out STD_LOGIC_VECTOR (inst_size-1 downto 0) -- Valor de Instruccion
   ); 
end component;

-- Señales Registro PC
signal s_pc4 : STD_LOGIC_VECTOR(31 downto 0);                     -- Direccion PC+4
signal s_pc_salto : STD_LOGIC_VECTOR(31 downto 0);                -- Direccion salto PC (EXE->PC)
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
---------------------------------inst Fetch---------------------------------

---------------------------------inst Decode---------------------------------
component Phase1_InstructionDecode
   Port ( clk, rst : in STD_LOGIC;
   -- Entradas (IF->ID)
      in_inst   : in STD_LOGIC_VECTOR(31 downto 0);  -- Instruccion actual

   -- Salidas (ID->EXE)
      out_busA     : out STD_LOGIC_VECTOR(31 downto 0); -- Datos de registro A
      out_busB     : out STD_LOGIC_VECTOR(31 downto 0); -- Datos de registro B
      out_regW0    : out STD_LOGIC_VECTOR(3 downto 0);  -- Registro destino 0 (bits 15-12)
      out_regW1    : out STD_LOGIC_VECTOR(3 downto 0);  -- Registro destino 1 (bits 14-11)
      out_entero   : out STD_LOGIC_VECTOR(31 downto 0);  -- entero con extension de signo
      
   -- Señales de control (WB->ID)
      in_ctr_WREnable : in STD_LOGIC;
      in_regW         : in STD_LOGIC_VECTOR(3 downto 0);   -- 
      in_busW         : in STD_LOGIC_VECTOR(31 downto 0);  -- 

   -- Señales de control (ID->EXE)
      out_WB_control  : out STD_LOGIC_VECTOR(11 downto 0);
      out_MEM_control : out STD_LOGIC_VECTOR(9 downto 0);
      out_EXE_control : out STD_LOGIC_VECTOR(9 downto 0)
   );
end component;

-- Registros de cambio de fase
   -- Señal de PC
   signal s_id_pc_reg         : STD_LOGIC_VECTOR(31 downto 0);
   signal s_id_pc_enable      : STD_LOGIC;
   -- Señales de datos
   signal s_id_busA           : STD_LOGIC_VECTOR(31 downto 0);
   signal s_id_busA_reg       : STD_LOGIC_VECTOR(31 downto 0);
   signal s_id_busA_enable    : STD_LOGIC;
   signal s_id_busB           : STD_LOGIC_VECTOR(31 downto 0);
   signal s_id_busB_reg       : STD_LOGIC_VECTOR(31 downto 0);
   signal s_id_busB_enable    : STD_LOGIC;
   -- Señales de entero
   signal s_id_entero         : STD_LOGIC_VECTOR(31 downto 0);
   signal s_id_entero_reg     : STD_LOGIC_VECTOR(31 downto 0);
   signal s_id_entero_enable  : STD_LOGIC;
   -- Reñales de registros destino
   signal s_id_regW0          : STD_LOGIC_VECTOR(3 downto 0);
   signal s_id_regW0_reg      : STD_LOGIC_VECTOR(3 downto 0);
   signal s_id_regW0_enable   : STD_LOGIC;
   signal s_id_regW1          : STD_LOGIC_VECTOR(3 downto 0);
   signal s_id_regW1_reg      : STD_LOGIC_VECTOR(3 downto 0);
   signal s_id_regW1_enable   : STD_LOGIC;
   -- Señales de control (ID->EXE)
   signal s_id_WB_ctr         : STD_LOGIC_VECTOR(11 downto 0);
   signal s_id_WB_ctr_reg     : STD_LOGIC_VECTOR(11 downto 0);
   signal s_id_WB_ctr_enable  : STD_LOGIC;
   signal s_id_MEM_ctr        : STD_LOGIC_VECTOR(9 downto 0);
   signal s_id_MEM_ctr_reg    : STD_LOGIC_VECTOR(9 downto 0);
   signal s_id_MEM_ctr_enable : STD_LOGIC;
   signal s_id_EXE_ctr        : STD_LOGIC_VECTOR(9 downto 0);
   signal s_id_EXE_ctr_reg    : STD_LOGIC_VECTOR(9 downto 0);
   signal s_id_EXE_ctr_enable : STD_LOGIC;
---------------------------------inst Decode---------------------------------

---------------------------------Execution---------------------------------
component Phase2_Execution 
   port (  
      --Entradas
      in_PC          : in STD_LOGIC_VECTOR(31 downto 0);
      in_entero      : in STD_LOGIC_VECTOR(31 downto 0);
      in_busA        : in STD_LOGIC_VECTOR(31 downto 0);
      in_busB        : in STD_LOGIC_VECTOR(31 downto 0);
      in_regW0       : in STD_LOGIC_VECTOR(3 downto 0);
      in_regW1       : in STD_LOGIC_VECTOR(3 downto 0);
       
      --Salidas
      out_PC_salto   : out STD_LOGIC_VECTOR(31 downto 0);
      out_ALU_flags   : out STD_LOGIC_VECTOR(0 downto 0);
      out_ALU_bus     : out STD_LOGIC_VECTOR(31 downto 0);
      out_regW       : out STD_LOGIC_VECTOR(3 downto 0);

      --Señales de control
      in_EXE_control : in STD_LOGIC_VECTOR(9 downto 0)
   );
end component;

   -- Señal de direccion de salto PC(EXE->IF)
   signal s_exe_PCBr             : STD_LOGIC_VECTOR(31 downto 0);
   signal s_exe_PCBr_reg         : STD_LOGIC_VECTOR(31 downto 0);
   signal s_exe_PCBr_enable      : STD_LOGIC;
   
-- Registros de cambio de fase(EXE->MEM)
   -- Señales de datos(EXE->MEM)
   signal s_exe_ALU_bus           : STD_LOGIC_VECTOR(31 downto 0);
   signal s_exe_ALU_bus_reg       : STD_LOGIC_VECTOR(31 downto 0);
   signal s_exe_ALU_bus_enable    : STD_LOGIC;
   signal s_exe_ALU_flags        : STD_LOGIC_VECTOR(0 downto 0);
   signal s_exe_ALU_flags_reg     : STD_LOGIC_VECTOR(0 downto 0);
   signal s_exe_ALU_flags_enable  : STD_LOGIC;
   signal s_exe_busB_reg         : STD_LOGIC_VECTOR(31 downto 0);
   signal s_exe_busB_enable      : STD_LOGIC;
   -- Reñales de registro destino(EXE->MEM)
   signal s_exe_regW             : STD_LOGIC_VECTOR(3 downto 0);
   signal s_exe_regW_reg         : STD_LOGIC_VECTOR(3 downto 0);
   signal s_exe_regW_enable      : STD_LOGIC;
   -- Señales de control (EXE->MEM)
   signal s_exe_WB_ctr_reg       : STD_LOGIC_VECTOR(11 downto 0);
   signal s_exe_WB_ctr_enable    : STD_LOGIC;
   signal s_exe_MEM_ctr_reg      : STD_LOGIC_VECTOR(9 downto 0);
   signal s_exe_MEM_ctr_enable   : STD_LOGIC;
---------------------------------Execution---------------------------------


begin

--TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST
s_pc_salto     <= test_pc_salto;
s_pc_mux_ctr   <= test_pc_mux_ctr;

s_pc_enable       <= test_if_enable;
s_if_inst_enable  <= test_if_enable;
s_if_pc_enable    <= test_if_enable;

s_id_pc_enable       <= test_id_enable;
s_id_busA_enable     <= test_id_enable; 
s_id_busB_enable     <= test_id_enable;
s_id_entero_enable   <= test_id_enable; 
s_id_regW0_enable    <= test_id_enable;
s_id_regW1_enable    <= test_id_enable;
s_id_WB_ctr_enable   <= test_id_enable; 
s_id_MEM_ctr_enable  <= test_id_enable; 
s_id_EXE_ctr_enable  <= test_id_enable;

s_exe_busB_enable      <= test_exe_enable;
s_exe_WB_ctr_enable    <= test_exe_enable; 
s_exe_MEM_ctr_enable   <= test_exe_enable; 
s_exe_PCBr_enable      <= test_exe_enable;
s_exe_ALU_flags_enable <= test_exe_enable;
s_exe_ALU_bus_enable   <= test_exe_enable;
s_exe_regW_enable      <= test_exe_enable;

test_exe_busB_reg      <= s_exe_busB_reg;
test_exe_WB_ctr_reg    <= s_exe_WB_ctr_reg; 
test_exe_MEM_ctr_reg   <= s_exe_MEM_ctr_reg; 
test_exe_PCBr_reg      <= s_exe_PCBr_reg;
test_exe_ALU_flags_reg <= s_exe_ALU_flags_reg;
test_exe_ALU_bus_reg   <= s_exe_ALU_bus_reg;
test_exe_regW_reg      <= s_exe_regW_reg;

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

---------------------------------inst Fetch---------------------------------
i_phase0: Phase0_InstructionFetch 
   generic map(
      address_size => 32,
      inst_size => 32   
   ) 
   port map(
      in_pc => s_pc_reg,
      out_pc => s_pc4,
      out_inst => s_inst
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
---------------------------------inst Fetch---------------------------------

---------------------------------inst Decode---------------------------------
i_phase1: Phase1_InstructionDecode 
   port map ( 
      clk => clk, 
      rst => rst,  
         
   -- Entradas (IF->ID)
      in_inst => s_if_inst_reg,

   -- Salidas (ID->EXE)
      out_busA => s_id_busA,
      out_busB => s_id_busB,
      out_regW0 => s_id_regW0,
      out_regW1 => s_id_regW1,
      out_entero => s_id_entero,
      
   -- Señales de control (WB->ID)
      in_ctr_WREnable => test_id_ctr_WREnable,
      in_regW => test_id_regW,
      in_busW => test_id_busW,

   -- Señales de control (ID->EXE)
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

---------------------------------inst Decode---------------------------------

---------------------------------Execution---------------------------------
i_exe_busB_reg0: reg_async
   port map( 
      clk => clk,
      rst => rst,
      enable => s_exe_busB_enable,
      in_data => s_id_busB_reg,
      out_data => s_exe_busB_reg
   );
   
i_exe_WB_ctr_reg0: reg_async 
   generic map(
      size => 12
   )
   port map( 
      clk => clk,
      rst => rst,
      enable => s_exe_WB_ctr_enable,
      in_data => s_id_WB_ctr_reg,
      out_data => s_exe_WB_ctr_reg
   );
   
i_exe_MEM_ctr_reg0: reg_async 
   generic map(
      size => 10
   )
   port map( 
      clk => clk,
      rst => rst,
      enable => s_exe_MEM_ctr_enable,
      in_data => s_id_MEM_ctr_reg,
      out_data => s_exe_MEM_ctr_reg
   );

i_phase2: Phase2_Execution
   port map (  
      --Entradas
      in_PC      => s_id_pc_reg,
      in_entero  => s_id_entero_reg,
      in_busA    => s_id_busA_reg,
      in_busB    => s_id_busB_reg,
      in_regW0   => s_id_regW0_reg,
      in_regW1   => s_id_regW1_reg,

      --Salidas
      out_PC_salto   => s_exe_PCBr,
      out_ALU_flags  => s_exe_ALU_flags,
      out_ALU_bus    => s_exe_ALU_bus,
      out_regW       => s_exe_regW,

      --Señales de control
      in_EXE_control  => s_id_EXE_ctr_reg
   );

i_exe_PCBr_reg0: reg_async 
   port map( 
      clk => clk,
      rst => rst,
      enable => s_exe_PCBr_enable,
      in_data => s_exe_PCBr,
      out_data => s_exe_PCBr_reg
   );
   
i_exe_ALU_flags_reg0: reg_async 
   generic map(
      size => 1
   )
   port map( 
      clk => clk,
      rst => rst,
      enable => s_exe_ALU_flags_enable,
      in_data => s_exe_ALU_flags,
      out_data => s_exe_ALU_flags_reg
   );
   
i_exe_ALU_bus_reg0: reg_async 
   port map( 
      clk => clk,
      rst => rst,
      enable => s_exe_ALU_bus_enable,
      in_data => s_exe_ALU_bus,
      out_data => s_exe_ALU_bus_reg
   );     
   
i_exe_regW_reg0: reg_async 
   generic map(
      size => 4
   )
   port map( 
      clk => clk,
      rst => rst,
      enable => s_exe_regW_enable,
      in_data => s_exe_regW,
      out_data => s_exe_regW_reg
   );   

---------------------------------Execution---------------------------------

end Behavioral;

