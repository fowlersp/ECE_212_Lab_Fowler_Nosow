//--------------------------------------------------------------
// datapath.sv - single-cycle MIPS datapath
// David_Harris@hmc.edu and Sarah_Harris@hmc.edu 23 October 2005
// Updated to SystemVerilog dmh 12 November 2010
// Refactored into separate files & updated using additional SystemVerilog
// features by John Nestor May 2018
// Key modifications to this file (to enhance clarity):
//  1. Use explicit port connections in instantiations
//  2. Use explicitly named instruction subfields
//--------------------------------------------------------------

module datapath(input  logic        clk, reset,
  input logic         memtoreg_d, memwrite_d, pcsrc_d, alusrc_d,
  input logic         regdst_d, regwrite_d, jump_d,
  input logic [2:0]   alucontrol_d,
  output logic        zero_d,
  output logic [31:0] pc_f,
  input logic [31:0]  instr_f,
  output logic [31:0] instr_d,
  output logic memwrite_m,
  output logic [31:0] aluout_m,
  output logic [31:0] writedata_m,
  input logic [31:0]  readdata_m);


  //--------------------------------------------------------------
  //   Signal Declarations
  //--------------------------------------------------------------
  //   IF Declarations

  logic [31:0]                     pcplus4_f, pcnextbr_f, pcnext_f;
  // instr_f already declared as an input port

  //   ID Declarataions (not control signals are module inputs)

  logic [4:0]                      rs_d;
  logic [4:0]                      rt_d;
  logic [4:0]                      rd_d;
  logic [15:0]                     immed_d;  // i-type immediate field
  logic [25:0]                     jpadr_d;  // j-type pseudo-address
  logic [31:0]                     pcnextbr_d, pcplus4_d, pcbranch_d;
  logic [31:0]                     rd1_d, rd2_d;
  logic [31:0]                     signimm_d, signimmsh_d;
  logic [31:0]                     pcjump_d;

  // EX Declarataions

  logic         memtoreg_e, memwrite_e, alusrc_e;
  logic         regdst_e, regwrite_e;
  logic [2:0]   alucontrol_e;

  logic [4:0]                      rs_e;
  logic [4:0]                      rt_e;
  logic [4:0]                      rd_e;
  logic [4:0]                      writereg_e;
  logic [31:0]                     srca_e, srcb_e;
  logic [31:0]                     rd1_e, rd2_e;
  logic [31:0]                     signimm_e;
  logic [31:0]                     aluout_e;
  logic [31:0]                     writedata_e;
  logic                            zero_e; // unused ALU port

  // MEM Declarataions

  logic                            memtoreg_m, regwrite_m;
  logic [4:0]                      writereg_m;  // WB Declarations

  // WB Declarataions

  logic                            regwrite_w, memtoreg_w;
  logic [4:0]                      writereg_w;
  logic [31:0]                     readdata_w, aluout_w, result_w;

  //--------------------------------------------------------------
  //   IF Stage
  //--------------------------------------------------------------

  pr_pc U_PC_F(.clk, .reset, .stall_f(1'b0), .pcnext_f, .pc_f);

  adder U_PCADD_F(.a(pc_f), .b(32'h4), .y(pcplus4_f));

  mux2 #(32) U_PCBRMUX_F(.d0(pcplus4_f), .d1(pcbranch_d), .s(pcsrc_d), .y(pcnextbr_f));

  mux2 #(32)  U_PCJMUX_F(.d0(pcnextbr_f), .d1(pcjump_d), .s(jump_d), .y(pcnext_f));

  //--------------------------------------------------------------
  //   ID Stage (note control signals arrive here)
  //--------------------------------------------------------------

  pr_f_d U_PR_F_D(.clk, .reset, .stall_d(1'b0),
                  .instr_f, .pcplus4_f,
                  .instr_d, .pcplus4_d);

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

  assign zero_d = (rd1_d == rd2_d);

  signext     U_SE_D(.a(immed_d), .y(signimm_d));

  sl2         U_IMMSH_D(.a(signimm_d), .y(signimmsh_d));

  adder       U_PCADD_D(.a(pcplus4_d), .b(signimmsh_d), .y(pcbranch_d));

  //--------------------------------------------------------------
  //   EX Stage
  //--------------------------------------------------------------

  pr_d_e U_PR_D_E(.clk, .reset, .flush_e(1'b0),
                  .regwrite_d, .memtoreg_d, .memwrite_d, .alucontrol_d,
                  .alusrc_d, .regdst_d, .rd1_d, .rd2_d,
                  .rs_d, .rt_d, .rd_d, .signimm_d,
                  .regwrite_e, .memtoreg_e, .memwrite_e, .alucontrol_e,
                  .alusrc_e, .regdst_e, .rd1_e, .rd2_e,
                  .rs_e, .rt_e, .rd_e, .signimm_e);

  // add forwarding muxes here
  assign srca_e = rd1_e;  // temporary
  assign writedata_e = rd2_e; // temporary


                  // ALU logic
  mux2 #(32)  U_SRCBMUX(.d0(writedata_e), .d1(signimm_e), .s(alusrc_e), .y(srcb_e));

  alu U_ALU(.a(srca_e), .b(srcb_e), .f(alucontrol_e),
                  .y(aluout_e), .zero(zero_e));

  mux2 #(5)   U_WRMUX(.d0(rt_e), .d1(rd_e), .s(regdst_e), .y(writereg_e));

  //--------------------------------------------------------------
  //   MEM Stage
  //--------------------------------------------------------------

  pr_e_m U_PR_E_M(.clk, .reset,
         .regwrite_e, .memtoreg_e, .memwrite_e,
         .aluout_e, .writedata_e, .writereg_e,
         .regwrite_m, .memtoreg_m, .memwrite_m,
         .aluout_m, .writedata_m, .writereg_m);

  // memory connected through i/o ports

  //--------------------------------------------------------------
  //   WB Stage
  //--------------------------------------------------------------

  pr_m_w U_PR_M_W(.clk, .reset,
        .regwrite_m, .memtoreg_m, .aluout_m, .readdata_m, .writereg_m,
        .regwrite_w, .memtoreg_w, .aluout_w, .readdata_w, .writereg_w);

    mux2 #(32)  U_RESMUX(.d0(aluout_w), .d1(readdata_w),.s(memtoreg_w), .y(result_w));

endmodule
