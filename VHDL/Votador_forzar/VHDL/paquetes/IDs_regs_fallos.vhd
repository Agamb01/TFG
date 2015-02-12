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
   type t_ID_reg is (ID_0, ID_Reg_PC, ID_Reg_Inst);

   -- Informacion del fallo insertados
   type t_Fallo is
    record
     -- ID del registro afectado
      ID : t_ID_reg;
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
