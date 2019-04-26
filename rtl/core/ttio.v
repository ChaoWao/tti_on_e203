`include "e203_defines.v"

module ttio(
    input  ttio_i_valid,
    output ttio_i_ready,


    input  [`E203_XLEN-1:0] ttio_i_rs1,
    input  [`E203_XLEN-1:0] ttio_i_rs2,
    input  [`E203_XLEN-1:0] ttio_i_imm,
    input  [`E203_DECINFO_TTIO_WIDTH-1:0] ttio_i_info,
    input  [`E203_ITAG_WIDTH-1:0] ttio_i_itag,

    output ttio_i_longpipe,

    input  ttio_i_flush_req,
    input  ttio_i_flush_pulse,

    output ttio_o_amo_wait,
    input  ttio_i_oitf_empty,

    output ttio_o_valid,
    input  ttio_o_ready,
    output [`E203_XLEN-1:0] ttio_o_wbck_wdat,
    output ttio_o_wbck_err,

    output ttio_o_cmt_misalgn,
    output ttio_o_cmt_ld,
    output ttio_o_cmt_stamo,
    output ttio_o_cmt_buserr,
    output [`E203_ADDR_SIZE-1:0] ttio_o_cmt_badaddr,

    output                       ttio_icb_cmd_valid,
    input                        ttio_icb_cmd_ready,
    output [`E203_ADDR_SIZE-1:0] ttio_icb_cmd_addr,
    output                       ttio_icb_cmd_read,
    output [`E203_XLEN-1:0]      ttio_icb_cmd_wdata, 
    output [`E203_XLEN/8-1:0]    ttio_icb_cmd_wmask, 
    output                       ttio_icb_cmd_back2ttio, 
    output                       ttio_icb_cmd_lock,
    output                       ttio_icb_cmd_excl,
    output [1:0]                 ttio_icb_cmd_size,
    output [`E203_ITAG_WIDTH-1:0]ttio_icb_cmd_itag,
    output                       ttio_icb_cmd_usign,
    input                        ttio_icb_rsp_valid,
    output                       ttio_icb_rsp_ready,
    input                        ttio_icb_rsp_err  ,
    input                        ttio_icb_rsp_excl_ok,
    input  [`E203_XLEN-1:0]      ttio_icb_rsp_rdata,

    output [`E203_XLEN-1:0] ttio_req_alu_op1,
    output [`E203_XLEN-1:0] ttio_req_alu_op2,
    output ttio_req_alu_swap,
    output ttio_req_alu_add ,
    output ttio_req_alu_and ,
    output ttio_req_alu_or  ,
    output ttio_req_alu_xor ,
    output ttio_req_alu_max ,
    output ttio_req_alu_min ,
    output ttio_req_alu_maxu,
    output ttio_req_alu_minu,
    input  [`E203_XLEN-1:0] ttio_req_alu_res,

    output ttio_sbf_0_ena,
    output [`E203_XLEN-1:0] ttio_sbf_0_nxt,
    input  [`E203_XLEN-1:0] ttio_sbf_0_r,

    output ttio_sbf_1_ena,
    output [`E203_XLEN-1:0] ttio_sbf_1_nxt,
    input  [`E203_XLEN-1:0] ttio_sbf_1_r,

    input  clk,
    input  rst_n
);


endmodule