creat_project my_project ./my_project -part xc7a35tcpg236-1
add_files [glob ./srcs/sources_1/*.{v,vhdl,sv}]
add_files -fileset sim_1 [glob ./srcs/sim_1/*.{v,vhdl,sv}]
add_files -fileset constrs_1 [glob ./srcs/sources_1/*.xdc]
set_property top alu [current_fileset]
save_project_as my_project ./my_project
