digraph cluster_cpu {
label="cpu";
define(`digraph',`subgraph')
include(`cpu_interface.dot')

include(`reset_ctrl.dot')

include(`clk_ctrl.dot')

include(`irq_sync.dot')

include(`extend_csr.dot')

include(`core.dot')

include(`itcm_ctrl.dot')

include(`dtcm_ctrl.dot')

// cpu_input
cpu_input_pc_rtvec -> core_input_pc_rtvec  [ color="black" ];
cpu_input_core_mhartid -> core_input_core_mhartid  [ color="black" ];
cpu_input_dbg_irq_a -> irq_sync_input_dbg_irq_a  [ color="black" ];
cpu_input_ext_irq_a -> irq_sync_input_ext_irq_a  [ color="black" ];
cpu_input_sft_irq_a -> irq_sync_input_sft_irq_a  [ color="black" ];
cpu_input_tmr_irq_a -> irq_sync_input_tmr_irq_a  [ color="black" ];
cpu_input_test_mode -> reset_ctrl_input_test_mode  [ color="black" ];
cpu_input_test_mode -> clk_ctrl_input_test_mode  [ color="black" ];
cpu_input_test_mode -> core_input_test_mode  [ color="black" ];
cpu_input_test_mode -> itcm_ctrl_input_test_mode  [ color="black" ];
cpu_input_test_mode -> dtcm_ctrl_input_test_mode  [ color="black" ];
cpu_input_clk -> clk_ctrl_input_clk  [ color="black" ];
// cpu_output
core_output_inspect_pc -> cpu_output_inspect_pc  [ color="black" ];
irq_sync_output_dbg_irq_r -> cpu_output_inspect_dbg_irq  [ color="black" ];
core_inout_mem_interface -> cpu_output_inspect_mem_cmd_valid  [ color="black" ];
cpu_inout_mem_interface -> cpu_output_inspect_mem_cmd_ready  [ color="black" ];
cpu_inout_mem_interface -> cpu_output_inspect_mem_rsp_valid  [ color="black" ];
core_inout_mem_interface -> cpu_output_inspect_mem_rsp_ready  [ color="black" ];
cpu_input_clk -> cpu_output_inspect_core_clk  [ color="black" ];
clk_ctrl_output_clk_core_exu -> cpu_output_core_csr_clk  [ color="black" ];
reset_ctrl_output_rst_itcm -> cpu_output_rst_itcm  [ color="black" ];
reset_ctrl_output_rst_dtcm -> cpu_output_rst_dtcm  [ color="black" ];
core_output_core_wfi -> cpu_output_core_wfi  [ color="black" ];
core_output_core_wfi -> clk_ctrl_input_core_wfi  [ color="black" ];
core_output_tm_stop -> cpu_output_tm_stop  [ color="black" ];
clk_ctrl_input_rst_n -> reset_ctrl_input_rst_n  [ color="black" ];
// cpu_inout
cpu_inout_debug_interface -> core_inout_debug_interface  [ dir="both", color="black", label="debug_interface" ];
cpu_inout_itcm_ext_interface -> itcm_ctrl_inout_ext2itcm_interface  [ dir="both", color="black", label="ext2itcm_interface" ];
cpu_inout_dtcm_ext_interface -> dtcm_ctrl_inout_ext2dtcm_interface  [ dir="both", color="black", label="ext2dtcm_interface" ];
cpu_inout_ppi_interface -> core_inout_ppi_interface  [ dir="both", color="black", label="ppi_interface" ];
cpu_inout_clint_interface -> core_inout_clint_interface  [ dir="both", color="black", label="clint_interface" ];
cpu_inout_plic_interface -> core_inout_plic_interface  [ dir="both", color="black", label="plic_interface" ];
cpu_inout_fio_interface -> core_inout_fio_interface  [ dir="both", color="black", label="fio_interface" ];
cpu_inout_mem_interface -> core_inout_mem_interface  [ dir="both", color="black", label="mem_interface" ];
clk_ctrl_output_clk_aon -> cpu_inout_itcm_interface  [ color="black" ];
clk_ctrl_output_clk_itcm -> cpu_inout_itcm_interface  [ color="black" ];
clk_ctrl_output_dtcm_ls -> cpu_inout_dtcm_interface  [ color="black" ];
clk_ctrl_output_clk_dtcm -> cpu_inout_dtcm_interface  [ color="black" ];
// wire
core_output_core_cgstop -> clk_ctrl_input_core_cgstop  [ color="black" ];
core_output_tcm_cgstop -> itcm_ctrl_input_tcm_cgstop  [ color="black" ];
core_output_tcm_cgstop -> dtcm_ctrl_input_tcm_cgstop  [ color="black" ];
core_output_ifu_active -> clk_ctrl_input_core_ifu_active  [ color="black" ];
core_output_exu_active -> clk_ctrl_input_core_exu_active  [ color="black" ];
core_output_lsu_active -> clk_ctrl_input_core_lsu_active  [ color="black" ];
core_output_biu_active -> clk_ctrl_input_core_biu_active  [ color="black" ];
reset_ctrl_output_rst_core -> extend_csr_input_rst_n  [ color="black" ];
reset_ctrl_output_rst_core -> core_input_rst_n  [ color="black" ];
clk_ctrl_output_clk_core_ifu -> core_input_clk_core_ifu  [ color="black" ];
clk_ctrl_output_clk_core_exu -> extend_csr_input_clk  [ color="black" ];
clk_ctrl_output_clk_core_exu -> core_input_clk_core_exu  [ color="black" ];
clk_ctrl_output_clk_core_lsu -> core_input_clk_core_lsu  [ color="black" ];
clk_ctrl_output_clk_core_biu -> core_input_clk_core_biu  [ color="black" ];
clk_ctrl_output_clk_itcm -> itcm_ctrl_input_clk  [ color="black" ];
itcm_ctrl_output_itcm_active -> clk_ctrl_input_itcm_active  [ color="black" ];
clk_ctrl_output_clk_dtcm -> dtcm_ctrl_input_clk  [ color="black" ];
dtcm_ctrl_output_dtcm_active -> clk_ctrl_input_dtcm_active  [ color="black" ];
reset_ctrl_output_rst_aon -> clk_ctrl_input_rst_n  [ color="black" ];
reset_ctrl_output_rst_aon -> irq_sync_input_rst_n  [ color="black" ];
clk_ctrl_output_clk_aon -> reset_ctrl_input_clk  [ color="black" ];
clk_ctrl_output_clk_aon -> irq_sync_input_clk  [ color="black" ];
clk_ctrl_output_clk_aon -> core_input_clk_aon  [ color="black" ];
irq_sync_output_ext_irq_r -> core_input_ext_irq_r  [ color="black" ];
irq_sync_output_sft_irq_r -> core_input_sft_irq_r  [ color="black" ];
irq_sync_output_tmr_irq_r -> core_input_tmr_irq_r  [ color="black" ];
itcm_ctrl_inout_ifu2itcm_interface -> core_inout_ifu2itcm_interface  [ dir="both", color="black", label="ifu2itcm_interface" ];
itcm_ctrl_inout_lsu2itcm_interface -> core_inout_lsu2itcm_interface  [ dir="both", color="black", label="lus2itcm_interface" ];
dtcm_ctrl_inout_lsu2dtcm_interface -> core_inout_lsu2dtcm_interface  [ dir="both", color="black", label="lsu2dtcm_interface" ];
extend_csr_inout_eai_csr_interface -> core_inout_eai_csr_interface  [ dir="both", color="black", label="eai_csr_interface" ];
}