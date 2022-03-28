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
// Extended version (Lab08 Solution March 2022)
// includes extensions for:
//    ori instruction (including controlled sign extension)
//    bne (modified controller)
//--------------------------------------------------------------

module datapath(
    input  logic        clk, reset,
    input logic         memtoreg, pcsrc, alusrc,
    input logic         regdst, regwrite, jump,
    input logic [2:0]   alucontrol,
    output logic        zero,
    output logic [31:0] pc,
    input logic [31:0]  instr,
    output logic [31:0] aluout,
    output logic [31:0] writedata,
    input logic [31:0]  readdata
    );

    // instruction fields of interest in the datapath

    logic [4:0]                      rs;
    logic [4:0]                      rt;
    logic [4:0]                      rd;
    logic [15:0]                     immed;  // i-type immediate field
    logic [25:0]                     jpadr;  // j-type pseudo-address

    assign rs = instr[25:21];
    assign rt = instr[20:16];
    assign rd = instr[15:11];
    assign immed = instr[15:0];
    assign jpadr = instr[25:0];

    // internal datapath signals

    logic [4:0]                      writereg;
    logic [31:0]                     pcnext, pcnextbr, pcplus4, pcbranch;
    logic [31:0]                     signimm, signimmsh;
    logic [31:0]                     srca, srcb;
    logic [31:0]                     result;
    logic [31:0]                     pcjump;

    // next PC logic

    assign pcjump = { pcplus4[31:28], jpadr, 2'b00 };  // jump target address

    flopr #(32) U_PCREG(.clk(clk), .reset(reset), .d(pcnext), .q(pc));

    adder       U_PCADD1(.a(pc), .b(32'h4), .y(pcplus4));

    sl2         U_IMMSH(.a(signimm), .y(signimmsh));

    adder       U_PCADD2(.a(pcplus4), .b(signimmsh), .y(pcbranch));

    mux2 #(32)  U_PCBRMUX(.d0(pcplus4), .d1(pcbranch), .s(pcsrc),.y(pcnextbr));

    mux2 #(32)  U_PCMUX(.d0(pcnextbr), .d1(pcjump), .s(jump), .y(pcnext));

    mux2 #(5)   U_WRMUX(.d0(rt), .d1(rd), .s(regdst), .y(writereg));

    mux2 #(32)  U_RESMUX(.d0(aluout), .d1(readdata),.s(memtoreg), .y(result));

    regfile     U_RF(.clk(clk), .we3(regwrite), .ra1(rs), .ra2(rt),
                     .wa3(writereg), .wd3(result), .rd1(srca), .rd2(writedata));

    signext     U_SE(.a(immed), .y(signimm));

    // ALU logic
    mux2 #(32)  U_SRCBMUX(.d0(writedata), .d1(signimm), .s(alusrc), .y(srcb));

    alu         U_ALU(.a(srca), .b(srcb), .f(alucontrol),
                      .y(aluout), .zero(zero));

endmodule
