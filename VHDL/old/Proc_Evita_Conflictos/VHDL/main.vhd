----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:22:59 01/07/2015 
-- Design Name: 
-- Module Name:    main - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library work;
   use work.my_package.all;
   
entity main is
   Port(
      clk, rst : in STD_LOGIC
--      out_test : out std_logic_vector(31 downto 0)
   );
end main;

architecture Behavioral of main is
--------------------------------Common--------------------------------
   component mux2 is
      Generic (
         size : INTEGER := 32
      );
      Port ( 
         in_0 : in STD_LOGIC_VECTOR (size-1 downto 0);
         in_1 : in STD_LOGIC_VECTOR (size-1 downto 0);
         sel : in STD_LOGIC;
         out_0 : out STD_LOGIC_VECTOR (size-1 downto 0)
      );
   end component;
--------------------------------Common--------------------------------


----------------------------Instruction Fetch-----------------------------
   component IF_main is
      Port( 
         clk, rst       : in STD_LOGIC;
         out_paradas    : out tipo_paradas;
         out_nula       : out STD_LOGIC;
         out_valid_data : out STD_LOGIC;
         
         -- Contador de programa actual
         in_pc          : in std_logic_vector(31 downto 0);
         -- Contador de programa siguiente
         out_pc         : out std_logic_vector(31 downto 0);
         -- Instruccion correspondiente a PC actual
         out_inst       : out std_logic_vector(31 downto 0)
      );
   end component;
   
   -- Se�ales paradas
   signal IF_out_paradas    : tipo_paradas;
   signal IF_out_nula       : STD_LOGIC;
   signal IF_out_valid_data : STD_LOGIC;
   
   -- Se�ales de funcion
   signal IF_in_pc          : std_logic_vector(31 downto 0);
   signal IF_out_pc4        : std_logic_vector(31 downto 0);
   signal IF_out_inst       : std_logic_vector(31 downto 0);

   -- Se�ales de registros
   signal IF_out_pc_reg     : std_logic_vector(31 downto 0);
   signal IF_out_pc4_reg    : std_logic_vector(31 downto 0);
   signal IF_out_inst_reg   : std_logic_vector(31 downto 0);
   
   signal IF_pc_next        : std_logic_vector(31 downto 0);

----------------------------Instruction Fetch-----------------------------

----------------------------Instruction Decode----------------------------
   component ID_main is
      Port( 
         clk, rst       : in STD_LOGIC;
         in_paradas     : in tipo_paradas;
         in_nula        : in STD_LOGIC;
         out_paradas    : out tipo_paradas;
         out_nula       : out STD_LOGIC;
         out_valid_data : out STD_LOGIC;
         
      -- Entradas (IF->ID)
         in_inst   : in STD_LOGIC_VECTOR(31 downto 0);  -- Instruccion actual

      -- Salidas (ID->EXE)
         out_busA     : out STD_LOGIC_VECTOR(31 downto 0); -- Datos de registro A
         out_busB     : out STD_LOGIC_VECTOR(31 downto 0); -- Datos de registro B
         out_regW     : out STD_LOGIC_VECTOR(3 downto 0);  -- Registro destino
         out_entero   : out STD_LOGIC_VECTOR(31 downto 0); -- Entero con extension de signo
         
      -- Se�ales de control (WB->ID)
         in_WREnable    : in STD_LOGIC; 
         in_regW        : in STD_LOGIC_VECTOR(3 downto 0); 
         in_busW        : in STD_LOGIC_VECTOR(31 downto 0); 

      -- Se�ales de control (ID->EXE)
         out_WB_control  : out STD_LOGIC_VECTOR(1 downto 0);
           -- [1]=MemtoReg, [0]=RegWrite
         out_MEM_control : out STD_LOGIC_VECTOR(5 downto 0);
           -- [5:2]=BRCond(Negative,Zero,Cond,Incond), [1]=MemRead, [0]=MemWrite
         out_EXE_control : out STD_LOGIC_VECTOR(3 downto 0);
           -- [3:1]=ALUop, [0]=ALUsrc
           
      -- Entradas y salidas de paso, sirven para simplificar el dise�o superior
         in_PC : in STD_LOGIC_VECTOR(31 downto 0);
         out_PC : out STD_LOGIC_VECTOR(31 downto 0)
      );
   end component;

   -- Se�ales paradas
   signal ID_in_paradas     : tipo_paradas;
   signal ID_in_nula        : STD_LOGIC;
   signal ID_out_paradas    : tipo_paradas;
   signal ID_out_nula       : STD_LOGIC;
   signal ID_out_valid_data : STD_LOGIC;
   
   -- Se�ales de funcion
    -- Entradas (IF->ID)
    signal ID_in_inst    : std_logic_vector(31 downto 0);

    -- Salidas (ID->EXE)
    signal ID_out_busA   : STD_LOGIC_VECTOR(31 downto 0); 
    signal ID_out_busB   : STD_LOGIC_VECTOR(31 downto 0);
    signal ID_out_regW   : STD_LOGIC_VECTOR(3 downto 0);  
    signal ID_out_entero : STD_LOGIC_VECTOR(31 downto 0); 

    -- Se�ales de control (WB->ID)
    signal ID_in_WREnable   : STD_LOGIC; 
    signal ID_in_regW       : STD_LOGIC_VECTOR(3 downto 0); 
    signal ID_in_busW       : STD_LOGIC_VECTOR(31 downto 0); 

    -- Se�ales de control
    signal ID_out_WB_control  : STD_LOGIC_VECTOR(1 downto 0);
    signal ID_out_MEM_control : STD_LOGIC_VECTOR(5 downto 0);
    signal ID_out_EXE_control : STD_LOGIC_VECTOR(3 downto 0);
   
   -- Se�ales de paso
   signal ID_in_pc          : std_logic_vector(31 downto 0);
   signal ID_out_pc         : std_logic_vector(31 downto 0);

   -- Se�ales de registros
   signal ID_out_busA_reg        : std_logic_vector(31 downto 0);
   signal ID_out_busB_reg        : std_logic_vector(31 downto 0);
   signal ID_out_regW_reg        : std_logic_vector(3 downto 0);
   signal ID_out_entero_reg      : std_logic_vector(31 downto 0);
   
   signal ID_out_WB_control_reg  : std_logic_vector(1 downto 0);
   signal ID_out_MEM_control_reg : std_logic_vector(5 downto 0);
   signal ID_out_EXE_control_reg : std_logic_vector(3 downto 0);
   
   signal ID_out_pc_reg          : std_logic_vector(31 downto 0);
----------------------------Instruction Decode----------------------------

---------------------------------Execution--------------------------------
   component EXE_main is
      Port( 
         clk, rst       : in STD_LOGIC;
         
         --Entradas modulo esperas
         in_paradas     : in tipo_paradas;
         in_nula        : in STD_LOGIC;
         out_paradas    : out tipo_paradas;
         out_nula       : out STD_LOGIC;
         out_valid_data : out STD_LOGIC;
         
         --Entradas (ID->EXE)
         in_PC          : in STD_LOGIC_VECTOR(31 downto 0);
         in_entero      : in STD_LOGIC_VECTOR(31 downto 0);
         in_busA        : in STD_LOGIC_VECTOR(31 downto 0);
         in_busB        : in STD_LOGIC_VECTOR(31 downto 0);
          
         --Salidas (EXE->MEM)
         out_PC_salto   : out STD_LOGIC_VECTOR(31 downto 0);
         out_ALU_bus    : out STD_LOGIC_VECTOR(31 downto 0);
         out_ALU_flags  : out STD_LOGIC_VECTOR(1 downto 0); -- Flags(N,Z)

         --Se�ales de control(ID->EXE)
         in_EXE_control : in STD_LOGIC_VECTOR(3 downto 0);
           -- [3:1]=ALUop, [0]=ALUsrc

      -- Entradas y salidas de paso, sirven para simplificar el dise�o superior
         in_regW         : in STD_LOGIC_VECTOR(3 downto 0);  -- Registro destino
         in_WB_control   : in STD_LOGIC_VECTOR(1 downto 0);
         in_MEM_control  : in STD_LOGIC_VECTOR(5 downto 0);
         
         out_BusB        : out STD_LOGIC_VECTOR(31 downto 0);
         out_regW        : out STD_LOGIC_VECTOR(3 downto 0);  -- Registro destino
         out_WB_control  : out STD_LOGIC_VECTOR(1 downto 0);
         out_MEM_control : out STD_LOGIC_VECTOR(5 downto 0)

      );
   end component;

   -- Se�ales paradas
   signal EXE_in_paradas     : tipo_paradas;
   signal EXE_in_nula        : STD_LOGIC;
   signal EXE_out_paradas    : tipo_paradas;
   signal EXE_out_nula       : STD_LOGIC;
   signal EXE_out_valid_data : STD_LOGIC;

   -- Se�ales de funcion
    --Entradas (ID->EXE)
    signal EXE_in_PC          : STD_LOGIC_VECTOR(31 downto 0);
    signal EXE_in_entero      : STD_LOGIC_VECTOR(31 downto 0);
    signal EXE_in_busA        : STD_LOGIC_VECTOR(31 downto 0);
    signal EXE_in_busB        : STD_LOGIC_VECTOR(31 downto 0);
    
    --Salidas (EXE->MEM)
    signal EXE_out_PC_salto   : STD_LOGIC_VECTOR(31 downto 0);
    signal EXE_out_ALU_bus    : STD_LOGIC_VECTOR(31 downto 0);
    signal EXE_out_ALU_flags  : STD_LOGIC_VECTOR(1 downto 0); -- Flags(N,Z)

   -- Se�ales de control
   signal EXE_in_EXE_control : STD_LOGIC_VECTOR(3 downto 0);

   -- Se�ales de paso
   signal EXE_in_regW        : STD_LOGIC_VECTOR(3 downto 0);
   signal EXE_in_WB_control  : STD_LOGIC_VECTOR(1 downto 0);
   signal EXE_in_MEM_control : STD_LOGIC_VECTOR(5 downto 0);

   signal EXE_out_BusB        : STD_LOGIC_VECTOR(31 downto 0);
   signal EXE_out_regW        : STD_LOGIC_VECTOR(3 downto 0);
   signal EXE_out_WB_control  : STD_LOGIC_VECTOR(1 downto 0);
   signal EXE_out_MEM_control : STD_LOGIC_VECTOR(5 downto 0);

   -- Se�ales de registros
   signal EXE_out_PC_salto_reg   : STD_LOGIC_VECTOR(31 downto 0);
   signal EXE_out_ALU_bus_reg    : STD_LOGIC_VECTOR(31 downto 0);
   signal EXE_out_ALU_flags_reg  : STD_LOGIC_VECTOR(1 downto 0); -- Flags(N,Z)

   signal EXE_out_BusB_reg        : STD_LOGIC_VECTOR(31 downto 0);
   signal EXE_out_regW_reg        : STD_LOGIC_VECTOR(3 downto 0);
   signal EXE_out_WB_control_reg  : STD_LOGIC_VECTOR(1 downto 0);
   signal EXE_out_MEM_control_reg : STD_LOGIC_VECTOR(5 downto 0);
---------------------------------Execution--------------------------------

----------------------------------Memory----------------------------------
   component MEM_main is
      Port (
         clk, rst       : in STD_LOGIC;
         in_paradas     : in tipo_paradas;
         in_nula        : in STD_LOGIC;
         out_paradas    : out tipo_paradas;
         out_nula       : out STD_LOGIC;
         out_valid_data : out STD_LOGIC;

         --Entradas (EXE->MEM)
         in_ALUbus  : in STD_LOGIC_VECTOR (31 downto 0);
         in_busB    : in STD_LOGIC_VECTOR (31 downto 0);
         in_flags   : in STD_LOGIC_VECTOR (1 downto 0);
         -- in_BRdir   : in STD_LOGIC_VECTOR (31 downto 0);

         --Salidas (MEM->WB) 
         out_MEMbus : out  STD_LOGIC_VECTOR (31 downto 0);

         --Salidas (MEM->Branch)
         -- out_BRdir  : out STD_LOGIC_VECTOR (31 downto 0);
         out_BRctr  : out STD_LOGIC;

         --Se�ales de control (ID->MEM)
         in_MEM_control : in STD_LOGIC_VECTOR(5 downto 0);
           -- [5:2]=BRCond(Negative,Zero,Cond,Incond), [1]=MemRead, [0]=MemWrite

         -- Entradas y salidas de paso, sirven para simplificar el dise�o superior
         in_PC_salto     : in STD_LOGIC_VECTOR(31 downto 0);
         in_regW         : in STD_LOGIC_VECTOR(3 downto 0);  -- Registro destino
         in_WB_control   : in STD_LOGIC_VECTOR(1 downto 0);
         
         out_PC_salto    : out STD_LOGIC_VECTOR(31 downto 0);
         out_ALUbus      : out STD_LOGIC_VECTOR(31 downto 0);
         out_regW        : out STD_LOGIC_VECTOR(3 downto 0);  -- Registro destino
         out_WB_control  : out STD_LOGIC_VECTOR(1 downto 0)

      );
   end component;

   -- Se�ales paradas
   signal MEM_in_paradas     : tipo_paradas;
   signal MEM_in_nula        : STD_LOGIC;
   signal MEM_out_paradas    : tipo_paradas;
   signal MEM_out_nula       : STD_LOGIC;
   signal MEM_out_valid_data : STD_LOGIC;

   -- Se�ales de funcion
    --Entradas (EXE->MEM)
    signal MEM_in_ALUbus  : STD_LOGIC_VECTOR (31 downto 0);
    signal MEM_in_busB    : STD_LOGIC_VECTOR (31 downto 0);
    signal MEM_in_flags   : STD_LOGIC_VECTOR (1 downto 0);

    --Salidas (MEM->Branch)
    signal MEM_out_BRctr  : STD_LOGIC;

    --Salidas (MEM->WB)
    signal MEM_out_MEMbus : STD_LOGIC_VECTOR (31 downto 0);

   -- Se�ales de control
   signal MEM_in_MEM_control : STD_LOGIC_VECTOR(5 downto 0);

   -- Se�ales de paso
   signal MEM_in_PC_salto     : STD_LOGIC_VECTOR(31 downto 0);
   signal MEM_in_regW         : STD_LOGIC_VECTOR(3 downto 0);
   signal MEM_in_WB_control   : STD_LOGIC_VECTOR(1 downto 0);

   signal MEM_out_PC_salto    : STD_LOGIC_VECTOR(31 downto 0);
   signal MEM_out_ALUbus      : STD_LOGIC_VECTOR(31 downto 0);
   signal MEM_out_regW        : STD_LOGIC_VECTOR(3 downto 0);
   signal MEM_out_WB_control  : STD_LOGIC_VECTOR(1 downto 0);

   -- Se�ales de registros
   signal MEM_out_MEMbus_reg  : STD_LOGIC_VECTOR(31 downto 0);

   signal MEM_out_ALUbus_reg     : STD_LOGIC_VECTOR(31 downto 0);
   signal MEM_out_regW_reg       : STD_LOGIC_VECTOR(3 downto 0);
   signal MEM_out_WB_control_reg : STD_LOGIC_VECTOR(1 downto 0);
----------------------------------Memory----------------------------------

--------------------------------Write Back--------------------------------

   signal WB_out_WB_control : std_logic_vector(1 downto 0);
   signal WB_out_regW       : std_logic_vector(3 downto 0);
   signal WB_out_busW       : std_logic_vector(31 downto 0);

--------------------------------Write Back--------------------------------

begin

----------------------------Instruction Fetch-----------------------------
   -- Asignacion de entradas para modulo ID
   i_mux_PC: mux2
      port map( 
         in_0  => IF_out_pc4,
         in_1  => MEM_out_PC_salto,
         sel   => MEM_out_BRctr,
         out_0 => IF_pc_next
      );


   -- Modulo IF
   i_IF: IF_main 
      port map (
         clk => clk,
         rst => rst, 
         
         out_paradas    => IF_out_paradas,
         out_nula       => IF_out_nula,
         out_valid_data => IF_out_valid_data,

         in_pc    => IF_out_pc_reg,
         out_pc   => IF_out_pc4,
         out_inst => IF_out_inst
      );   
   
   --Registros (IF -> ID) -- TODO: Sustituir por registros tolerantes a fallos
   p_IF_regs: process(clk, rst)
   begin
      if rst='0' then
         IF_out_pc_reg   <= (others=>'0');
         IF_out_pc4_reg  <= (others=>'0');
         IF_out_inst_reg <= (others=>'0');
      elsif rising_edge(clk) then
         IF_out_pc_reg   <= IF_pc_next;
         IF_out_pc4_reg  <= IF_out_pc4;
         IF_out_inst_reg <= IF_out_inst;
      end if;
   end process;
----------------------------Instruction Fetch-----------------------------

----------------------------Instruction Decode----------------------------
   -- Asignacion de entradas para modulo ID
    --Origen IF
      --Paradas
   ID_in_paradas <= IF_out_paradas;
   ID_in_nula <= IF_out_nula;
   
      --Registros
   ID_in_inst <= IF_out_inst_reg;
   
    --Origen WB
   ID_in_WREnable <= WB_out_WB_control(0); --RegWrite
   ID_in_regW     <= WB_out_regW;
   ID_in_busW     <= WB_out_busW;
   
    --Se�ales de paso 
   ID_in_pc <= IF_out_pc4_reg;

   -- Modulo ID
   i_ID: ID_main
      port map ( 
         clk            => clk,
         rst            => rst, 
         
         in_paradas     => ID_in_paradas,
         in_nula        => ID_in_nula,
         out_paradas    => ID_out_paradas,
         out_nula       => ID_out_nula,
         out_valid_data => ID_out_valid_data,
      
      -- Entradas (IF->ID)
         in_inst => ID_in_inst,

      -- Salidas (ID->EXE)
         out_busA => ID_out_busA, 
         out_busB => ID_out_busB,
         out_regW => ID_out_regW,
         out_entero => ID_out_entero, 
         
      -- Se�ales de control (WB->ID)
         in_WREnable => ID_in_WREnable, 
         in_regW => ID_in_regW,
         in_busW => ID_in_busW,

      -- Se�ales de control (ID->EXE)
         out_WB_control => ID_out_WB_control, 
         out_MEM_control => ID_out_MEM_control, 
         out_EXE_control => ID_out_EXE_control, 
           
      -- Entradas y salidas de paso, sirven para simplificar el dise�o superior
         in_PC => ID_in_PC, 
         out_PC => ID_out_PC 
      );
      
   --Registros (ID -> EXE) -- TODO: Sustituir por registros tolerantes a fallos
   p_ID_regs: process(clk, rst)
   begin
      if rst='0' then
         ID_out_busA_reg        <= (others=>'0');
         ID_out_busB_reg        <= (others=>'0');
         ID_out_regW_reg        <= (others=>'0');
         ID_out_entero_reg      <= (others=>'0');
         ID_out_WB_control_reg  <= (others=>'0');
         ID_out_MEM_control_reg <= (others=>'0');
         ID_out_EXE_control_reg <= (others=>'0');
         ID_out_pc_reg          <= (others=>'0');
      elsif rising_edge(clk) then
         ID_out_busA_reg        <= ID_out_busA;
         ID_out_busB_reg        <= ID_out_busB;
         ID_out_regW_reg        <= ID_out_regW;
         ID_out_entero_reg      <= ID_out_entero;
         ID_out_WB_control_reg  <= ID_out_WB_control;
         ID_out_MEM_control_reg <= ID_out_MEM_control;
         ID_out_EXE_control_reg <= ID_out_EXE_control;
         ID_out_pc_reg          <= ID_out_pc;
      end if;
   end process;
----------------------------Instruction Decode----------------------------

---------------------------------Execution--------------------------------
   -- Asignacion de entradas para modulo EXE
    --Origen ID
      --Paradas
   EXE_in_paradas <= ID_out_paradas;
   EXE_in_nula    <= ID_out_nula;
      --Registros
   EXE_in_PC      <= ID_out_pc_reg;
   EXE_in_entero  <= ID_out_entero_reg;
   EXE_in_busA    <= ID_out_busA_reg;
   EXE_in_busB    <= ID_out_busB_reg;
      --Se�ales de control
   EXE_in_EXE_control <= ID_out_EXE_control_reg;
   
    --Se�ales de paso 
   EXE_in_regW        <= ID_out_regW_reg;
   EXE_in_WB_control  <= ID_out_WB_control_reg;
   EXE_in_MEM_control <= ID_out_MEM_control_reg;
   EXE_in_BusB        <= ID_out_busB_reg;
   
   -- Modulo EXE
   i_EXE: EXE_main
      port map ( 
         clk            => clk,
         rst            => rst, 
         
         in_paradas     => EXE_in_paradas,
         in_nula        => EXE_in_nula,
         out_paradas    => EXE_out_paradas,
         out_nula       => EXE_out_nula,
         out_valid_data => EXE_out_valid_data,
         
         --Entradas (ID->EXE)
         in_PC     => EXE_in_PC,
         in_entero => EXE_in_entero,
         in_busA   => EXE_in_busA,
         in_busB   => EXE_in_BusB,
          
         --Salidas (EXE->MEM)
         out_PC_salto   => EXE_out_PC_salto,
         out_ALU_bus    => EXE_out_ALU_bus,
         out_ALU_flags  => EXE_out_ALU_flags,

         --Se�ales de control(ID->EXE)
         in_EXE_control => EXE_in_EXE_control,
           -- [3:1]=ALUop, [0]=ALUsrc

      -- Entradas y salidas de paso, sirven para simplificar el dise�o superior
         in_regW         => EXE_in_regW,
         in_WB_control   => EXE_in_WB_control,
         in_MEM_control  => EXE_in_MEM_control,
         
         out_BusB        => EXE_out_BusB,
         out_regW        => EXE_out_regW,
         out_WB_control  => EXE_out_WB_control,
         out_MEM_control => EXE_out_MEM_control
      );

   --Registros (EXE -> MEM) -- TODO: Sustituir por registros tolerantes a fallos
   p_EXE_regs: process(clk, rst)
   begin
      if rst='0' then
         EXE_out_PC_salto_reg    <= (others=>'0');
         EXE_out_ALU_bus_reg     <= (others=>'0');
         EXE_out_ALU_flags_reg   <= (others=>'0');

         EXE_out_BusB_reg        <= (others=>'0');
         EXE_out_regW_reg        <= (others=>'0');
         EXE_out_WB_control_reg  <= (others=>'0');
         EXE_out_MEM_control_reg <= (others=>'0');
      elsif rising_edge(clk) then
         EXE_out_PC_salto_reg    <= EXE_out_PC_salto;
         EXE_out_ALU_bus_reg     <= EXE_out_ALU_bus;
         EXE_out_ALU_flags_reg   <= EXE_out_ALU_flags;

         EXE_out_BusB_reg        <= EXE_out_BusB;
         EXE_out_regW_reg        <= EXE_out_regW;
         EXE_out_WB_control_reg  <= EXE_out_WB_control;
         EXE_out_MEM_control_reg <= EXE_out_MEM_control;
      end if;
   end process;
---------------------------------Execution--------------------------------

----------------------------------Memory----------------------------------
   -- Asignacion de entradas para modulo MEM
    --Origen EXE
      --Paradas
   MEM_in_paradas <= EXE_out_paradas;
   MEM_in_nula    <= EXE_out_nula;
   
      --Registros
   MEM_in_ALUbus  <= EXE_out_ALU_bus_reg;
   MEM_in_busB    <= EXE_out_BusB_reg;
   MEM_in_flags   <= EXE_out_ALU_flags_reg;

      --Se�ales de control
   MEM_in_MEM_control <= EXE_out_MEM_control_reg;
   
    --Se�ales de paso 
   MEM_in_PC_salto    <= EXE_out_PC_salto_reg;
   MEM_in_regW        <= EXE_out_regW_reg;
   MEM_in_WB_control  <= EXE_out_WB_control_reg;
      
   -- Modulo EXE
   i_MEM: MEM_main
      port map ( 
         clk            => clk,
         rst            => rst, 
         
         in_paradas     => MEM_in_paradas,
         in_nula        => MEM_in_nula,
         out_paradas    => MEM_out_paradas,
         out_nula       => MEM_out_nula,
         out_valid_data => MEM_out_valid_data,
         
         --Entradas (EXE->MEM)
         in_ALUbus => MEM_in_ALUbus,
         in_busB   => MEM_in_busB,
         in_flags  => MEM_in_flags,

         --Salidas (MEM->WB) 
         out_MEMbus => MEM_out_MEMbus,

         --Salidas (MEM->Branch)
         out_BRctr  => MEM_out_BRctr,

         --Se�ales de control (ID->MEM)
         in_MEM_control => MEM_in_MEM_control,

         -- Entradas y salidas de paso, sirven para simplificar el dise�o superior
         in_PC_salto     => MEM_in_PC_salto,
         in_regW         => MEM_in_regW,
         in_WB_control   => MEM_in_WB_control,
         
         out_PC_salto    => MEM_out_PC_salto,
         out_ALUbus      => MEM_out_ALUbus,
         out_regW        => MEM_out_regW,
         out_WB_control  => MEM_out_WB_control 
      );

   --Registros (MEM -> WB) -- TODO: Sustituir por registros tolerantes a fallos
   p_MEM_regs: process(clk, rst)
   begin
      if rst='0' then
         MEM_out_MEMbus_reg      <= (others=>'0');
         MEM_out_ALUbus_reg      <= (others=>'0');
         MEM_out_regW_reg        <= (others=>'0');
         MEM_out_WB_control_reg  <= (others=>'0');
      elsif rising_edge(clk) then
         MEM_out_MEMbus_reg      <= MEM_out_MEMbus;
         MEM_out_ALUbus_reg      <= MEM_out_ALUbus;
         MEM_out_regW_reg        <= MEM_out_regW;
         MEM_out_WB_control_reg  <= MEM_out_WB_control;
      end if;
   end process;
----------------------------------Memory----------------------------------

--------------------------------Write Back--------------------------------

   WB_out_WB_control <= MEM_out_WB_control_reg;
   WB_out_regW       <= MEM_out_regW_reg;
   
   i_mux_WRBus: mux2
      port map( 
         in_0  => MEM_out_ALUbus_reg,
         in_1  => MEM_out_MEMbus_reg,
         sel   => WB_out_WB_control(1), --MEMtoREG
         out_0 => WB_out_busW
      );


--------------------------------Write Back--------------------------------

---TEST---
--out_test <= MEM_out_MEMbus;

---TEST---

end Behavioral;

