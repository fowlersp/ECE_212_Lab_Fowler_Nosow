`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2022 08:18:51 AM
// Design Name: 
// Module Name: datapath_f
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module datapath_f(input  logic        clk, reset,
  input logic         memtoreg_d, memwrite_d, pcsrc_d, alusrc_d,
  input logic         regdst_d, regwrite_d, jump_d, jal_d, jr_d,
  input logic         stall_f, flush_d, stall_d, forward_a_d, forward_b_d, flush_e,
  input logic [1:0]   forward_a_e, forward_b_e,        
  input logic [2:0]   alucontrol_d,
  output logic        zero_d, 
  output logic [31:0] pc_f,
  input logic [31:0]  instr_f,
  output logic [31:0] instr_d,
  output logic        memwrite_m,
  output logic [31:0] aluout_m,
  output logic [31:0] writedata_m,
  input logic [31:0]  readdata_m,
  output logic [4:0]  rs_d, rt_d, rs_e, rt_e, writereg_e, writereg_m, writereg_w,
  output logic        memtoreg_e, regwrite_e, memtoreg_m, regwrite_m, regwrite_w);


  //--------------------------------------------------------------
  //   Signal Declarations
  //--------------------------------------------------------------
  //   IF Declarations

  logic [31:0]                     pcplus4_f, pcnextbr_f, pcnext_f;
  // instr_f already declared as an input port

  //   ID Declarataions (not control signals are module inputs)

  logic [4:0]                      rd_d;
  logic [15:0]                     immed_d;  // i-type immediate field
  logic [25:0]                     jpadr_d;  // j-type pseudo-address
  logic [31:0]                     pcnextbr_d, pcplus4_d, pcbranch_d;
  logic [31:0]                     rd1_d, rd2_d;
  logic [31:0]                     signimm_d, signimmsh_d;
  logic [31:0]                     pcjump_d;
  logic [31:0]                     pc_d;
  logic [31:0]                     pcjump_sel;
  logic                            flush;
  logic [31:0]                     forad_result, forbd_result;

  // EX Declarataions


  logic [2:0]   alucontrol_e;

  logic [4:0]                      rd_e;
  logic [4:0]                      writereg_or_31_e;
  logic [31:0]                     srca_e, srcb_e;
  logic [31:0]                     rd1_e, rd2_e;
  logic [31:0]                     signimm_e;
  logic [31:0]                     aluout_e;
  logic [31:0]                     writedata_e;
  logic                            memwrite_e, zero_e; // unused ALU port
  logic [31:0]                     pc_e;

  // MEM Declarataions

  logic                            jal_m;
  logic [31:0]                     pc_m;

  // WB Declarataions

  logic                            memtoreg_w, jal_w;
  logic [31:0]                     readdata_w, aluout_w, result_w, result_or_PC_w;
  logic [31:0]                     pc_w;

  //--------------------------------------------------------------
  //   IF Stage
  //--------------------------------------------------------------

  pr_pc U_PC_F(.clk, .reset, .stall_f, .pcnext_f, .pc_f);

  adder U_PCADD_F(.a(pc_f), .b(32'h4), .y(pcplus4_f));

  mux2 #(32) U_PCBRMUX_F(.d0(pcplus4_f), .d1(pcbranch_d), .s(pcsrc_d), .y(pcnextbr_f));
  
  mux2 #(32)  U_PCJMUX_F(.d0(pcjump_d), .d1(rd1_d), .s(jr_d), .y(pcjump_sel));  // new mux

  mux2 #(32)  U_PCNMUX_F(.d0(pcnextbr_f), .d1(pcjump_sel), .s(jump_d), .y(pcnext_f));

  //--------------------------------------------------------------
  //   ID Stage (note control signals arrive here)
  //--------------------------------------------------------------

  pr_f_d U_PR_F_D(.clk, .reset, .flush_d, .stall_d,
                  .instr_f, .pcplus4_f, .pc_f,
                  .instr_d, .pcplus4_d, .pc_d);

  assign rs_d = instr_d[25:21];
  assign rt_d = instr_d[20:16];
  assign rd_d = instr_d[15:11];
  assign immed_d = instr_d[15:0];
  assign jpadr_d = instr_d[25:0];

  assign pcjump_d = { pcplus4_d[31:28], jpadr_d, 2'b00 };  // jump target address


  regfile     U_RF_D(.clk(clk), .we3(regwrite_w), .ra1(rs_d), .ra2(rt_d),
                     .wa3(writereg_w), .wd3(result_w),
                     .rd1(rd1_d), .rd2(rd2_d));

  // add forwarding muxes for comparator later

  //assign zero_d = (rd1_d == rd2_d);

  signext     U_SE_D(.a(immed_d), .y(signimm_d));

  sl2         U_IMMSH_D(.a(signimm_d), .y(signimmsh_d));

  adder       U_PCADD_D(.a(pcplus4_d), .b(signimmsh_d), .y(pcbranch_d));
  
  
  //forwarding muxes
  mux2 #(32)  U_FORAD(.d0(rd1_d), .d1(aluout_m), .s(forward_a_d), .y(forad_result));
  mux2 #(32)  U_FORBD(.d0(rd2_d), .d1(aluout_m), .s(forward_b_d), .y(forbd_result));
  
  //comparator
  comparator  U_COMP(.a(forad_result), .b(forbd_result), .y(zero_d));
  
  //--------------------------------------------------------------
  //   EX Stage
  //--------------------------------------------------------------

  pr_d_e U_PR_D_E(.clk, .reset, .flush_e,
                  .regwrite_d, .memtoreg_d, .memwrite_d, .alucontrol_d,
                  .alusrc_d, .regdst_d, .rd1_d, .rd2_d,
                  .rs_d, .rt_d, .rd_d, .signimm_d, .pc_d(pcplus4_d), .jal_d,
                  .regwrite_e, .memtoreg_e, .memwrite_e, .alucontrol_e,
                  .alusrc_e, .regdst_e, .rd1_e, .rd2_e,
                  .rs_e, .rt_e, .rd_e, .signimm_e, .pc_e, .jal_e);


                  // ALU logic
  mux2 #(32)  U_SRCB2MUX(.d0(writedata_e), .d1(signimm_e), .s(alusrc_e), .y(srcb_e));

  alu U_ALU(.a(srca_e), .b(srcb_e), .f(alucontrol_e),
                  .y(aluout_e), .zero(zero_e));

  mux2 #(5)   U_WRMUX(.d0(rt_e), .d1(rd_e), .s(regdst_e), .y(writereg_or_31_e));
  
  mux2 #(5)   U_JALWRMUX(.d0(writereg_or_31_e), .d1(5'd31), .s(jal_e), .y(writereg_e));
  
  //forwarding muxes
  mux3 #(32)  U_SRCAMUX(.d0(rd1_e), .d1(result_w), .d2(aluout_m), .d3(32'd0), .s(forward_a_e), .y(srca_e));
  mux3 #(32)  U_SRCB1MUX(.d0(rd3_e), .d1(result_w), .d2(aluout_m), .d3(32'd0), .s(forward_b_e), .y(writedata_e));


  //--------------------------------------------------------------
  //   MEM Stage
  //--------------------------------------------------------------

  pr_e_m U_PR_E_M(.clk, .reset,
         .regwrite_e, .memtoreg_e, .memwrite_e,
         .aluout_e, .writedata_e, .writereg_e, .pc_e, .jal_e,
         .regwrite_m, .memtoreg_m, .memwrite_m,
         .aluout_m, .writedata_m, .writereg_m, .pc_m, .jal_m);

  // memory connected through i/o ports

  //--------------------------------------------------------------
  //   WB Stage
  //--------------------------------------------------------------

  pr_m_w U_PR_M_W(.clk, .reset,
        .regwrite_m, .memtoreg_m, .aluout_m, .readdata_m, .writereg_m, .pc_m, .jal_m,
        .regwrite_w, .memtoreg_w, .aluout_w, .readdata_w, .writereg_w, .pc_w, .jal_w);

    mux2 #(32)  U_RESMUX(.d0(aluout_w), .d1(readdata_w),.s(memtoreg_w), .y(result_or_PC_w));
    
    mux2 #(32)   U_RESPCMUX(.d0(result_or_PC_w), .d1(pc_w), .s(jal_w), .y(result_w));

endmodule
