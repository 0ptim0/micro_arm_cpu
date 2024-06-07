onerror {resume}
quietly WaveActivateNextPane {} 0

add wave /top_module_tb/*
add wave /top_module_tb/DUT/*

add wave -divider "Control Unit"
add wave /top_module_tb/DUT/u_control_unit/*

add wave -divider "Registers"
add wave /top_module_tb/DUT/u_reg_file/*
add wave /top_module_tb/DUT/u_reg_file/regs[0]
add wave /top_module_tb/DUT/u_reg_file/regs[1]
add wave /top_module_tb/DUT/u_reg_file/regs[2]
add wave /top_module_tb/DUT/u_reg_file/regs[3]
add wave /top_module_tb/DUT/u_reg_file/regs[4]
add wave /top_module_tb/DUT/u_reg_file/regs[5]
add wave /top_module_tb/DUT/u_reg_file/regs[6]
add wave /top_module_tb/DUT/u_reg_file/regs[7]
add wave /top_module_tb/DUT/u_reg_file/regs[8]
add wave /top_module_tb/DUT/u_reg_file/regs[9]
add wave /top_module_tb/DUT/u_reg_file/regs[10]
add wave /top_module_tb/DUT/u_reg_file/regs[11]
add wave /top_module_tb/DUT/u_reg_file/regs[12]
add wave /top_module_tb/DUT/u_reg_file/regs[13]
add wave /top_module_tb/DUT/u_reg_file/regs[14]

add wave -divider "Data memory"
add wave /top_module_tb/DUT/u_data_mem/reg_mem_i[0]
add wave /top_module_tb/DUT/u_data_mem/reg_mem_i[1]
add wave /top_module_tb/DUT/u_data_mem/reg_mem_i[2]
add wave /top_module_tb/DUT/u_data_mem/reg_mem_i[3]
add wave /top_module_tb/DUT/u_data_mem/reg_mem_i[4]
add wave /top_module_tb/DUT/u_data_mem/reg_mem_i[5]
add wave /top_module_tb/DUT/u_data_mem/reg_mem_i[6]
add wave /top_module_tb/DUT/u_data_mem/reg_mem_i[7]
add wave /top_module_tb/DUT/u_data_mem/reg_mem_i[8]
add wave /top_module_tb/DUT/u_data_mem/reg_mem_i[9]
add wave /top_module_tb/DUT/u_data_mem/reg_mem_i[10]
add wave /top_module_tb/DUT/u_data_mem/reg_mem_i[11]
add wave /top_module_tb/DUT/u_data_mem/reg_mem_i[12]
add wave /top_module_tb/DUT/u_data_mem/reg_mem_i[13]
add wave /top_module_tb/DUT/u_data_mem/reg_mem_i[14]

update
