cpu_top: cpu_top.dot
	git add cpu_top.dot
	git commit -m "File Transport"
	git push

cpu_top.dot: cpu_top.m4 cpu_top_interface.dot cpu.dot srams.dot
	m4 cpu_top.m4 > cpu_top.dot

cpu_top_interface.dot: cpu_top_interface.m4 cpu_top_input.dot cpu_top_output.dot cpu_top_inout.dot
	m4 cpu_top_interface.m4 > cpu_top_interface.dot

cpu.dot: cpu.m4 cpu_interface.dot reset_ctrl.dot clk_ctrl.dot irq_sync.dot extend_csr.dot core.dot itcm_ctrl.dot dtcm_ctrl.dot
	m4 cpu.m4 > cpu.dot

cpu_interface.dot: cpu_interface.m4 cpu_input.dot cpu_output.dot cpu_inout.dot
	m4 cpu_interface.m4 > cpu_interface.dot

reset_ctrl.dot:

clk_ctrl.dot:

irq_sync.dot:

extend_csr.dot:

core.dot: core.m4 core_interface.dot ifu.dot exu.dot lsu.dot biu.dot
	m4 core.m4 > core.dot

core_interface.dot: core_interface.m4 core_input.dot core_output.dot core_inout.dot
	m4 core_interface.m4 > core_interface.dot

itcm_ctrl.dot:

dtcm_ctrl.dot:

srams.dot: srams.m4 srams_interface.dot
	m4 srams.m4 > srams.dot

srams_interface.dot: srams_interface.m4 srams_input.dot srams_output.dot srams_inout.dot
	m4 srams_interface.m4 > srams_interface.dot
