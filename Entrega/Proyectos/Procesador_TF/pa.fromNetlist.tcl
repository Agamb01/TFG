
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name Procesador_TF -dir "D:/TFG/TFG/VHDL/Procesador_TF/planAhead_run_2" -part xc7a100tcsg324-1
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "D:/TFG/TFG/VHDL/Procesador_TF/cpu.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {D:/TFG/TFG/VHDL/Procesador_TF} }
set_property target_constrs_file "Nexys4_Master.ucf" [current_fileset -constrset]
add_files [list {Nexys4_Master.ucf}] -fileset [get_property constrset [current_run]]
link_design
