--
--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 
--
--   To use any of the example code shown below, uncomment the lines and modify as necessary
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;

package IDs_regs_fallos is

   -- IDs para los diferentes registros de tolerancia
   -- ID_0 no debe ser asignado a ningun registro, indica que no se aplica ningun fallo a ningun registro
   type t_ID_reg is (
      -- Sin seleccion de registro
      ID_0, 
      
      -- Registros de fase IF->ID
      id_IF_out_pc_reg, id_IF_out_inst_reg, id_IF_out_pc4_reg,
      
      -- Registros de fase ID->EXE
      id_ID_out_busA_reg, id_ID_out_busB_reg, id_ID_out_regW_reg, id_ID_out_entero_reg, 
      id_ID_out_WB_control_reg, id_ID_out_MEM_control_reg, id_ID_out_EXE_control_reg,
      id_ID_out_pc_reg,
      
      -- Registros de fase EXE->MEM
      id_EXE_out_PC_salto, id_EXE_out_ALU_bus, id_EXE_out_ALU_flags, id_EXE_out_BusB, 
      id_EXE_out_regW, id_EXE_out_WB_control, id_EXE_out_MEM_control,      
      
      -- Registros de fase MEM->WB
      id_MEM_out_MEMbus, id_MEM_out_ALUbus, id_MEM_out_regW, id_MEM_out_WB_control
   );

   -- Informacion del fallo insertados
   type t_Fallo is
    record
     -- ID del registro afectado
      ID : t_ID_reg;-- 5 bits
     -- Registros afectados por el error:
      -- 000 -> Ningun afectado
      -- 100, 010, 001 -> Uno afectado
      -- 110, 101, 011 -> Dos afectados
      -- 111 -> Todos afectados
      reg : std_logic_vector(2 downto 0);
     -- Tipo de error:
       -- 0 -> Fuerza los bits seleccionados(bool[x]=1) del valor dato al registro seleccionado(reg)
       -- 1 -> Invierte los bits seleccionados(bool[x]=1) del registro seleccionado(reg)
      tipo : std_logic; 
     -- Seleccion de bits afectados.
      bool : std_logic_vector(31 downto 0);
     -- Valor forzado si existe fallo.
      dato : std_logic_vector(31 downto 0);
    end record;
    
   constant N_Tolerancia : integer := 3;
   constant size_data : integer := 32;
    
   type array_regs is array (0 to N_Tolerancia-1) of STD_LOGIC_VECTOR (size_data-1 downto 0);

    
end IDs_regs_fallos;
