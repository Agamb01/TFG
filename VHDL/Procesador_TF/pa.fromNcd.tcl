
# PlanAhead Launch Script for Post PAR Floorplanning, created by Project Navigator

create_project -name Procesador_TF -dir "D:/TFG/TFG/VHDL/Procesador_TF/planAhead_run_2" -part xc7a100tcsg324-1
set srcset [get_property srcset [current_run -impl]]
set_property design_mode GateLvl $srcset
set_property edif_top_file "D:/TFG/TFG/VHDL/Procesador_TF/cpu.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {D:/TFG/TFG/VHDL/Procesador_TF} }
set_property target_constrs_file "Nexys4_Master.ucf" [current_fileset -constrset]
add_files [list {Nexys4_Master.ucf}] -fileset [get_property constrset [current_run]]
link_design
read_xdl -file "D:/TFG/TFG/VHDL/Procesador_TF/cpu.ncd"
if {[catch {read_twx -name results_1 -file "D:/TFG/TFG/VHDL/Procesador_TF/cpu.twx"} eInfo]} {
   puts "WARNING: there was a problem importing \"D:/TFG/TFG/VHDL/Procesador_TF/cpu.twx\": $eInfo"
}
