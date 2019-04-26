digraph cluster_cpu_top {
label = "cpu_top";
define(`digraph',`subgraph')
include(`cpu_top_interface.dot')

include(`cpu.dot')

include(`srams.dot')

// cpu_top_input
cpu_top_input_pc_rtvec -> cpu_input_pc_rtvec  [ color="black" ];
cpu_top_input_core_mhartid -> cpu_input_core_mhartid  [ color="black" ];
cpu_top_input_ext_irq_a -> cpu_input_ext_irq_a  [ color="black" ];
cpu_top_input_sft_irq_a -> cpu_input_sft_irq_a  [ color="black" ];
cpu_top_input_tmr_irq_a -> cpu_input_tmr_irq_a  [ color="black" ];
cpu_top_input_tcm_sd -> srams_inout_itcm_interface  [ color="black" ];
cpu_top_input_tcm_sd -> srams_inout_dtcm_interface  [ color="black" ];
cpu_top_input_tcm_ds -> srams_inout_itcm_interface  [ color="black" ];
cpu_top_input_tcm_ds -> srams_inout_dtcm_interface  [ color="black" ];
cpu_top_input_test_mode -> cpu_input_test_mode  [ color="black" ];
cpu_top_input_test_mode -> srams_input_test_mode  [ color="black" ];
cpu_top_input_clk -> cpu_input_clk  [ color="black" ];
cpu_top_input_rst_n -> cpu_input_rst_n  [ color="black" ];
// cpu_top_output
cpu_output_inspect_pc -> cpu_top_output_inspect_pc  [ color="black" ];
cpu_output_inspect_dbg_irq -> cpu_top_output_inspect_dbg_irq  [ color="black" ];
cpu_output_inspect_mem_cmd_valid -> cpu_top_output_inspect_mem_cmd_valid  [ color="black" ];
cpu_output_inspect_mem_cmd_ready -> cpu_top_output_inspect_mem_cmd_ready  [ color="black" ];
cpu_output_inspect_mem_rsp_valid -> cpu_top_output_inspect_mem_rsp_valid  [ color="black" ];
cpu_output_inspect_mem_rsp_ready -> cpu_top_output_inspect_mem_rsp_ready  [ color="black" ];
cpu_output_inspect_core_clk -> cpu_top_output_inspect_core_clk  [ color="black" ];
cpu_output_core_csr_clk -> cpu_top_output_core_csr_clk  [ color="black" ];
cpu_output_core_wfi -> cpu_top_output_core_wfi  [ color="black" ];
cpu_output_tm_stop -> cpu_top_output_tm_stop  [ color="black" ];
// cpu_top_inout
cpu_top_inout_debug_interface -> cpu_inout_debug_interface  [ dir="both", style="bold", color="black" ];
cpu_top_inout_itcm_ext_interface -> cpu_inout_itcm_ext_interface  [ dir="both", style="bold", color="black" ];
cpu_top_inout_dtcm_ext_interface -> cpu_inout_dtcm_ext_interface  [ dir="both", style="bold", color="black" ];
cpu_top_inout_ppi_interface -> cpu_inout_ppi_interface  [ dir="both", style="bold", color="black" ];
cpu_top_inout_clint_interface -> cpu_inout_clint_interface  [ dir="both", style="bold", color="black" ];
cpu_top_inout_plic_interface -> cpu_inout_plic_interface  [ dir="both", style="bold", color="black" ];
cpu_top_inout_fio_interface -> cpu_inout_fio_interface  [ dir="both", style="bold", color="black" ];
cpu_top_inout_mem_interface -> cpu_inout_mem_interface  [ dir="both", style="bold", color="black" ];
// wire
cpu_inout_itcm_interface -> srams_inout_itcm_interface  [ dir="both", color="black", label="itcm_interface" ];
cpu_inout_dtcm_interface -> srams_inout_dtcm_interface  [ dir="both", color="black", label="dtcm_interface" ];
}