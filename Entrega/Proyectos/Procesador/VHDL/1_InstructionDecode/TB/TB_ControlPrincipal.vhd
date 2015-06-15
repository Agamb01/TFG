--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:48:35 02/02/2015
-- Design Name:   
-- Module Name:   D:/TFG/TFG/VHDL/Proc_Evita_Conflictos/TB_ControlPrincipal.vhd
-- Project Name:  Proc_Evita_Conflictos
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ControlPrincipal
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TB_ControlPrincipal IS
END TB_ControlPrincipal;
 
ARCHITECTURE behavior OF TB_ControlPrincipal IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ControlPrincipal
    PORT(
         in_inst : IN  std_logic_vector(31 downto 0);
         out_WB_control  : out STD_LOGIC_VECTOR(1 downto 0);
           -- [1]=MemtoReg, [0]=RegWrite
         out_MEM_control : out STD_LOGIC_VECTOR(5 downto 0);
           -- [5:2]=BRCond(Negative,Zero,Cond,Incond), [1]=MemRead, [0]=MemWrite
         out_EXE_control : out STD_LOGIC_VECTOR(3 downto 0)
           -- [3:1]=ALUop, [0]=ALUsrc
        );
    END COMPONENT;
    

   --Inputs
   signal in_inst : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal out_WB_control : std_logic_vector(1 downto 0);
   signal out_MEM_control : std_logic_vector(5 downto 0);
   signal out_EXE_control : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace clk below with 
   -- appropriate port name 
 
   constant clk_period : time := 10 ns;
   signal clk : std_logic;
 
BEGIN
 
--   out_WB_control  : out STD_LOGIC_VECTOR(1 downto 0);
--     -- [1]=MemtoReg, [0]=RegWrite

--   out_MEM_control : out STD_LOGIC_VECTOR(5 downto 0);
--     -- [5:2]=BRCond(Negative,Zero,Cond,Incond), [1]=MemRead, [0]=MemWrite

--   out_EXE_control : out STD_LOGIC_VECTOR(3 downto 0)
--     -- [3:1]=ALUop, [0]=ALUsrc
 -- Tabla operaciones (ALUop)
-- ADD  000
-- SUB  001
-- MOV  010
-- MOVT 011

-- AND  100
-- ORR  101
-- EOR  110
-- CMP  111


 
	-- Instantiate the Unit Under Test (UUT)
   uut: ControlPrincipal PORT MAP (
          in_inst => in_inst,
          out_WB_control => out_WB_control,
          out_MEM_control => out_MEM_control,
          out_EXE_control => out_EXE_control
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      in_inst <= (others => '0');

    wait for 100 ns;	

--Operaciones Enteros
   --MOV R1, #13 --Entero esperado: 13
         in_inst(31 downto 16) <= "1111001001000000";
         in_inst(15 downto 0) <= "0000000100001101";
       wait for clk_period;	
       
   --MOVT R1, #15 --Entero esperado: 15
         in_inst(31 downto 16) <= "1111001011000000";
         in_inst(15 downto 0) <= "0000000100001111";
       wait for clk_period;	

--Operaciones de registros
   --Add R4, R2, R1
      in_inst <= "11101011000000100000010000000001";
    wait for clk_period;	

   --And R4, R2, R1
      in_inst <= "11101010000000100000010000000001";
    wait for clk_period;	

   --Cmp R2, R1
      in_inst <= "11101011101100100000111100000001";
    wait for clk_period;	

   --Eor R4, R2, R1
      in_inst <= "11101010100000100000010000000001";
    wait for clk_period;	

   --Mov R4, R1
      in_inst <= "11101010010011110000010000000001";
    wait for clk_period;	

   --Orr R4, R2, R1
      in_inst <= "11101010010000100000010000000001";
    wait for clk_period;	

   --Sub R4, R2, R1
      in_inst <= "11101011101000100000010000000001";
    wait for clk_period;	

--Operaciones LD/ST
   --LDR R1, R2, #0 --Entero esperado: 0
         in_inst(31 downto 16) <= "1111100010010001";
         in_inst(15 downto 0) <= "0010000000000000";
       wait for clk_period;	
         
   --STR R2, R3, #2 --Entero esperado: 2
         in_inst(31 downto 16) <= "1111100010000010";
         in_inst(15 downto 0) <= "0011000000000010"; 
       wait for clk_period;	

--Operaciones de salto
   --B #<+768> --Entero esperado: 768
         in_inst(31 downto 16) <= "1111000000000000";
         in_inst(15 downto 0) <= "1001000110000000"; 
       wait for clk_period;	
         
   --BEQ <-24>	   -- BrCond Igual que (Zero) 01 
      in_inst <= "11110100011111111010111111110100";
    wait for clk_period;	

   --BGT <-24>	   -- BrCond Mayor que (Positivo) 00
      in_inst <= "11110100001111111010111111110100";
    wait for clk_period;	
 
   --BLT <-24>	   -- BrCond Menor que (Negativo) 10
      in_inst <= "11110100101111111010111111110100";
    wait for clk_period;	
   
    wait;
   end process;

   -- Asserts process
   assert_proc: process
   begin		
--Comprobaciones:
--   out_WB_control  : out STD_LOGIC_VECTOR(1 downto 0);
--     -- [1]=MemtoReg, [0]=RegWrite

--   out_MEM_control : out STD_LOGIC_VECTOR(5 downto 0);
--     -- [5:2]=BRCond(Negative,Zero,Cond,Incond), [1]=MemRead, [0]=MemWrite

--   out_EXE_control : out STD_LOGIC_VECTOR(3 downto 0)
--     -- [3:1]=ALUop, [0]=ALUsrc
 -- Tabla operaciones (ALUop)
-- ADD  000
-- SUB  001
-- MOV  010
-- MOVT 011

-- AND  100
-- ORR  101
-- EOR  110
-- CMP  111

-- Instrucciones:
   --Operaciones Enteros
      --MOV R1, #13 --Entero esperado: 13         
      --MOVT R1, #15 --Entero esperado: 15
   --Operaciones de registros
      --Add R4, R2, R1
      --And R4, R2, R1
      --Cmp R2, R1
      --Eor R4, R2, R1
      --Mov R4, R1
      --Orr R4, R2, R1
      --Sub R4, R2, R1
   --Operaciones LD/ST
      --LDR R1, R2, #0 --Entero esperado: 0
      --STR R2, R3, #2 --Entero esperado: 2
   --Operaciones de salto
      --B #<+768> --Entero esperado: 768
      --BEQ <-24>	   -- BrCond Igual que (Zero) 01 
      --BGT <-24>	   -- BrCond Mayor que (Positivo) 00
      --BLT <-24>	   -- BrCond Menor que (Negativo) 10

   -- RESET
   wait for 100 ns;	
   wait for clk_period/2; -- Espera medio ciclo de reloj para sincornizar las comprobaciones
--      Assert out_EXE_control = "0000"
--         report "Intruccion RESET, EXE: Esperado '0000'"
--         severity ERROR;
--      Assert out_MEM_control = "000000"
--         report "Intruccion RESET, MEM: Esperado '000000'"
--         severity ERROR;
--      Assert out_WB_control = "00"
--         report "Intruccion RESET, WB: Esperado '00'"
--         severity ERROR;
--   wait for clk_period;
   
--Operaciones Enteros
   --MOV R1, #13
      Assert out_EXE_control = "0101"
         report "Intruccion MOV, EXE: Esperado '0101'"
         severity ERROR;
      Assert out_MEM_control = "000000"
         report "Intruccion MOV, MEM: Esperado '000000'"
         severity ERROR;
      Assert out_WB_control = "01"
         report "Intruccion MOV, WB: Esperado '01'"
         severity ERROR;
   wait for clk_period;

   --MOVT R1, #15
      Assert out_EXE_control = "0111"
         report "Intruccion MOVT, EXE: Esperado '0111'"
         severity ERROR;
      Assert out_MEM_control = "000000"
         report "Intruccion MOVT, MEM: Esperado '000000'"
         severity ERROR;
      Assert out_WB_control = "01"
         report "Intruccion MOVT, WB: Esperado '01'"
         severity ERROR;
   wait for clk_period;
   
--Operaciones de registros
   --Add R4, R2, R1
      Assert out_EXE_control = "0000"
         report "Intruccion ADD, EXE: Esperado '0000'"
         severity ERROR;
      Assert out_MEM_control = "000000"
         report "Intruccion ADD, MEM: Esperado '000000'"
         severity ERROR;
      Assert out_WB_control = "01"
         report "Intruccion ADD, WB: Esperado '01'"
         severity ERROR;
   wait for clk_period;

   --And R4, R2, R1
      Assert out_EXE_control = "1000"
         report "Intruccion AND, EXE: Esperado '1000'"
         severity ERROR;
      Assert out_MEM_control = "000000"
         report "Intruccion AND, MEM: Esperado '000000'"
         severity ERROR;
      Assert out_WB_control = "01"
         report "Intruccion AND, WB: Esperado '01'"
         severity ERROR;
   wait for clk_period;

   --Cmp R2, R1
      Assert out_EXE_control = "1110"
         report "Intruccion CMP, EXE: Esperado '1110'"
         severity ERROR;
      Assert out_MEM_control = "000000"
         report "Intruccion CMP, MEM: Esperado '000000'"
         severity ERROR;
      Assert out_WB_control = "00"
         report "Intruccion CMP, WB: Esperado '00'"
         severity ERROR;
   wait for clk_period;

   --Eor R4, R2, R1
      Assert out_EXE_control = "1100"
         report "Intruccion EOR, EXE: Esperado '1100'"
         severity ERROR;
      Assert out_MEM_control = "000000"
         report "Intruccion EOR, MEM: Esperado '000000'"
         severity ERROR;
      Assert out_WB_control = "01"
         report "Intruccion EOR, WB: Esperado '01'"
         severity ERROR;
   wait for clk_period;

   --Mov R4, R1
      Assert out_EXE_control = "0100"
         report "Intruccion MOV, EXE: Esperado '0100'"
         severity ERROR;
      Assert out_MEM_control = "000000"
         report "Intruccion MOV, MEM: Esperado '000000'"
         severity ERROR;
      Assert out_WB_control = "01"
         report "Intruccion MOV, WB: Esperado '01'"
         severity ERROR;
   wait for clk_period;

   --Orr R4, R2, R1
      Assert out_EXE_control = "1010"
         report "Intruccion ORR, EXE: Esperado '1010'"
         severity ERROR;
      Assert out_MEM_control = "000000"
         report "Intruccion ORR, MEM: Esperado '000000'"
         severity ERROR;
      Assert out_WB_control = "01"
         report "Intruccion ORR, WB: Esperado '01'"
         severity ERROR;
   wait for clk_period;

   --Sub R4, R2, R1
      Assert out_EXE_control = "0010"
         report "Intruccion SUB, EXE: Esperado '0010'"
         severity ERROR;
      Assert out_MEM_control = "000000"
         report "Intruccion SUB, MEM: Esperado '000000'"
         severity ERROR;
      Assert out_WB_control = "01"
         report "Intruccion SUB, WB: Esperado '01'"
         severity ERROR;
   wait for clk_period;

--Operaciones LD/ST
   --LDR R1, R2, #0
      Assert out_EXE_control = "0001"
         report "Intruccion LDR, EXE: Esperado '0001'"
         severity ERROR;
      Assert out_MEM_control = "000010"
         report "Intruccion LDR, MEM: Esperado '000010'"
         severity ERROR;
      Assert out_WB_control = "11"
         report "Intruccion LDR, WB: Esperado '11'"
         severity ERROR;
   wait for clk_period;

   --STR R2, R3, #2
      Assert out_EXE_control = "0001"
         report "Intruccion STR, EXE: Esperado '0001'"
         severity ERROR;
      Assert out_MEM_control = "000001"
         report "Intruccion STR, MEM: Esperado '000001'"
         severity ERROR;
      Assert out_WB_control = "00"
         report "Intruccion STR, WB: Esperado '00'"
         severity ERROR;
   wait for clk_period;
   
--Operaciones de salto
   --B #<+768> --Entero esperado: 768
      Assert out_EXE_control = "0001"
         report "Intruccion B, EXE: Esperado '0001'"
         severity ERROR;
      Assert out_MEM_control = "000100"
         report "Intruccion B, MEM: Esperado '000000'"
         severity ERROR;
      Assert out_WB_control = "00"
         report "Intruccion B, WB: Esperado '00'"
         severity ERROR;
   wait for clk_period;

   --BEQ <-24>	   -- BrCond Igual que (Zero) 01 
      Assert out_EXE_control = "0001"
         report "Intruccion BEQ, EXE: Esperado '0001'"
         severity ERROR;
      Assert out_MEM_control = "011000"
         report "Intruccion BEQ, MEM: Esperado '011000'"
         severity ERROR;
      Assert out_WB_control = "00"
         report "Intruccion BEQ, WB: Esperado '00'"
         severity ERROR;
   wait for clk_period;

   --BGT <-24>	   -- BrCond Mayor que (Positivo) 00
      Assert out_EXE_control = "0001"
         report "Intruccion BGT, EXE: Esperado '0001'"
         severity ERROR;
      Assert out_MEM_control = "001000"
         report "Intruccion BGT, MEM: Esperado '001000'"
         severity ERROR;
      Assert out_WB_control = "00"
         report "Intruccion BGT, WB: Esperado '00'"
         severity ERROR;
   wait for clk_period;

   --BLT <-24>	   -- BrCond Menor que (Negativo) 10
      Assert out_EXE_control = "0001"
         report "Intruccion BLT, EXE: Esperado '0001'"
         severity ERROR;
      Assert out_MEM_control = "101000"
         report "Intruccion BLT, MEM: Esperado '101000'"
         severity ERROR;
      Assert out_WB_control = "00"
         report "Intruccion BLT, WB: Esperado '00'"
         severity ERROR;
   wait for clk_period;

      
--   out_MEM_control : out STD_LOGIC_VECTOR(5 downto 0);
--     -- [5:2]=BRCond(Negative,Zero,Cond,Incond), [1]=MemRead, [0]=MemWrite

--   out_WB_control  : out STD_LOGIC_VECTOR(1 downto 0);
--     -- [1]=MemtoReg, [0]=RegWrite

      
   wait;
   end process;

END;
