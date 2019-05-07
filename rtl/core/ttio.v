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

    // The TTIO Write-Back/Commit Interface
    output ttio_o_valid,
    input  ttio_o_ready,
    output [`E203_XLEN-1:0] ttio_o_wbck_wdat,
    output ttio_o_wbck_err,
    output ttio_o_cmt_misalgn,
    output ttio_o_cmt_ld,
    output ttio_o_cmt_st,
    output ttio_o_cmt_buserr,
    output [`E203_ADDR_SIZE-1:0] ttio_o_cmt_badaddr,

    // The ICB Interface to LSU-ctrl
    //    * Bus CMD channel
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
    //    * Bus RSP channel
    input                        ttio_icb_rsp_valid,
    output                       ttio_icb_rsp_ready,
    input                        ttio_icb_rsp_err  ,
    input                        ttio_icb_rsp_excl_ok,
    input  [`E203_XLEN-1:0]      ttio_icb_rsp_rdata,


    // To share the ALU datapath, generate interface to ALU
        // The operands and info to ALU
    output [`E203_XLEN-1:0] ttio_req_alu_op1,
    output [`E203_XLEN-1:0] ttio_req_alu_op2,
    output ttio_req_alu_add,
    input  [`E203_XLEN-1:0] ttio_req_alu_res,

    input  clk,
    input  rst_n
);

wire flush_block = ttio_i_flush_req;

wire ttio_i_settr = ttio_i_info[`E203_DECINFO_TTIO_SETTR] & (~flush_block);
wire ttio_i_setti = ttio_i_info[`E203_DECINFO_TTIO_SETTI] & (~flush_block);
wire ttio_i_getti = ttio_i_info[`E203_DECINFO_TTIO_GETTI] & (~flush_block);
wire ttio_i_move = ttio_i_info[`E203_DECINFO_TTIO_MOVE] & (~flush_block);
wire ttio_i_ttiat = ttio_i_info[`E203_DECINFO_TTIO_TTIAT] & (~flush_block);
wire ttio_i_ttoat = ttio_i_info[`E203_DECINFO_TTIO_TTOAT] & (~flush_block);

wire [2:0] ttio_i_rtidx = ttio_i_info[`E203_DECINFO_TTIO_RTIDX];
wire [1:0] ttio_i_size = 2'b10;
wire ttio_i_usign = 1'b0;
wire ttio_i_excl = 1'b0;

wire ttio_i_size_b = (ttio_i_size == 2'b00);
wire ttio_i_size_hw = (ttio_i_size == 2'b01);
wire ttio_i_size_w  = (ttio_i_size == 2'b10);

wire ttio_i_addr_unalgn = (ttio_i_size_hw & ttio_icb_cmd_addr[0])
                        | (ttio_i_size_w & (|ttio_icb_cmd_addr[1:0]));

wire ttio_addr_unalgn = ttio_i_addr_unalgn;

wire ttio_i_unalgni = (ttio_addr_unalgn & ttio_i_ttiat);
wire ttio_i_unalgno = (ttio_addr_unalgn & ttio_i_ttoat);
wire ttio_i_unalgnio = ttio_i_unalgni | ttio_i_unalgno;
wire ttio_i_algni = (~ttio_addr_unalgn) & ttio_i_ttiat;
wire ttio_i_algno = (~ttio_addr_unalgn) & ttio_i_ttoat;
wire ttio_i_algnio = ttio_i_algni | ttio_i_algno;

// output
assign ttio_o_amo_wait = 1'b0;

assign ttio_req_alu_add  = 1'b1;
assign ttio_req_alu_op1 =  ttio_i_rs1;
assign ttio_req_alu_op2 =  ttio_i_imm;

assign ttio_i_ready = ttio_icb_cmd_ready & ttio_o_ready;
assign ttio_i_longpipe = ttio_i_algnio;

assign ttio_o_valid = (ttio_i_valid & ( ttio_i_algnio | ttio_i_unalgnio) & ttio_icb_cmd_ready);

assign ttio_o_wbck_wdat = {`E203_XLEN{1'b0 }};
assign ttio_o_wbck_err = ttio_o_cmt_buserr | ttio_o_cmt_misalgn;

assign ttio_o_cmt_buserr  = 1'b0;
assign ttio_o_cmt_badaddr = ttio_icb_cmd_addr;
assign ttio_o_cmt_misalgn = ttio_i_unalgnio;
assign ttio_o_cmt_ld      = ttio_i_ttiat & (~ttio_i_excl); 
assign ttio_o_cmt_st      = ttio_i_ttoat | ttio_i_excl;

assign ttio_icb_rsp_ready = 1'b1;

assign ttio_icb_cmd_valid = ((ttio_i_algnio & ttio_i_valid) & (ttio_o_ready));
assign ttio_icb_cmd_addr = ttio_req_alu_res[`E203_ADDR_SIZE-1:0];
assign ttio_icb_cmd_read = (ttio_i_algnio & ttio_i_ttiat);

wire [`E203_XLEN-1:0] algnst_wdata = 
        ({`E203_XLEN{ttio_i_size_b }} & {4{ttio_i_rs2[7:0]}})
        | ({`E203_XLEN{ttio_i_size_hw}} & {2{ttio_i_rs2[15:0]}})
        | ({`E203_XLEN{ttio_i_size_w }} & {1{ttio_i_rs2[31:0]}});
wire [`E203_XLEN/8-1:0] algnst_wmask = 
        ({`E203_XLEN/8{ttio_i_size_b }} & (4'b0001 << ttio_icb_cmd_addr[1:0]))
        | ({`E203_XLEN/8{ttio_i_size_hw}} & (4'b0011 << {ttio_icb_cmd_addr[1],1'b0}))
        | ({`E203_XLEN/8{ttio_i_size_w }} & (4'b1111));

assign ttio_icb_cmd_wdata = algnst_wdata;
assign ttio_icb_cmd_wmask = algnst_wmask; 
assign ttio_icb_cmd_back2ttio = 1'b0;
assign ttio_icb_cmd_lock     = 1'b0;
assign ttio_icb_cmd_excl     = 1'b0;

assign ttio_icb_cmd_itag     = ttio_i_itag;
assign ttio_icb_cmd_usign    = ttio_i_usign;
assign ttio_icb_cmd_size     = ttio_i_size;

endmodule