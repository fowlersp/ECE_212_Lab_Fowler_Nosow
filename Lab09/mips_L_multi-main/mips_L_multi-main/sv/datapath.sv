//--------------------------------------------------------------------
// datapath.sv - Multicycle MIPS datapath
// David_Harris@hmc.edu 23 October 2005
// David_Harris@hmc.edu 23 October 2005
// Updated to SystemVerilog dmh 12 November 2010
// Refactored into separate files & updated using additional SystemVerilog
// features by John Nestor May 2018
// Key modifications to this module:
//  1. Use enums from new package to make opcode & function codes
//     display symbolic names  during simulation
//  2. Explicitly break out and use instruction subfields (opcode, rs, rt, etc.
//
//--------------------------------------------------------------------

// The datapath unit is a structural verilog module.  That is,
// it is composed of instances of its sub-modules.  For example,
// the instruction register is instantiated as a 32-bit flopenr.
// The other submodules are likewise instantiated.

module datapath(
    input  logic        clk, reset,
    input logic         pcen, irwrite, regwrite,
    input logic         alusrca, iord, memtoreg, regdst,
    input logic [1:0]   alusrcb, pcsrc,
    input logic [2:0]   alucontrol,
    output mips_decls_p::opcode_t opcode,
    output mips_decls_p::funct_t funct,
    output logic        zero,
    output logic [31:0] adr, writedata,
    input logic [31:0]  readdata
    );


   import mips_decls_p::*;

   // instruction fields
   logic [31:0]                     instr, pcnext, pcadr, aluout; //Outputs of various registers
   logic [31:0]                     data, regresult, rd1, rd2, A, B; //regfile I/O
   logic [31:0]                     scra, scrb, aluresult;  //alu I/O
   logic [31:0]                     signimm, shiftsignimm; //immediate wires
   logic [31:0]                     pcjump; //jump addr
   logic [4:0]                      rs, rt, rd, writereg;  // register fields
   logic [15:0]                     immed;       // i-type immediate field
   logic [25:0]                     jmpimmed;    // j-type pseudo-address
   logic [27:0]                     shiftjmpimm;
   

  // extract instruction fields from instruction
   assign opcode = opcode_t'(instr[31:26]);
   assign funct = funct_t'(instr[5:0]);
   assign rs = instr[25:21];
   assign rt = instr[20:16];
   assign rd = instr[15:11];
   assign immed = instr[15:0];
   assign jmpimmed = instr[25:0];
   assign pcjump = {pcadr[31:28], shiftjmpimm}; //concat the shifted jump addr with the four largest bits of the current instruction
   assign writedata = B;    //writedata is B register output

    //PC Register
    flopenr #(32)   PC_FFEN(.clk, .reset, .en(pcen), .d(pcnext), .q(pcadr));
    
    mux2 #(32)      IORD_MUX(.d0(padr), .d1(aluout), .s(iord), .y(adr));
    
    //Instr Register
    flopenr #(32)   IR_FFEN(.clk, .reset, .en(iwrite), .d(readdata), .q(instr));
    
    //Memory Address Register
    flopr #(32)     MDR_FF(.clk, .reset, .d(readdata), .q(data));
    
    mux2 #(32)      MTOR_MUX(.d0(aluout), .d1(data), .s(memtoreg), .y(regresult));
    
    mux2 #(5)       REGD_MUX(.d0(rt), .d1(rd), .s(regdst), .y(writereg));
    
    regfile         RF(.clk, .we3(regwrite), .ra1(rs), .ra2(rt), .wa3(writereg), .wd3(regresult), .rd1, .rd2);
    
    flopr #(32)     A_FF(.clk, .reset, .d(rd1), .q(A));
    
    flopr #(32)     B_FF(.clk, .reset, .d(rd2), .q(B));
    
    //ALUsrca mux
    mux2 #(32)      ALUSA_MUX(.d0(pcadr), .d1(A), .s(alusrca), .y(scra));
    
    signext         SE(.a(immed), .y(signimm));
    
    sl2             IMM_SL2(.a(signimm), .y(shiftsignimm));
    
    //ALUsrcb mux
    mux4 #(32)      ALUSB_MUX(.d0(B), .d1(32'd4), .d2(signimm), .d3(shiftsignimm), .s(alusrcb), .y(scrb));
    
    alu             ALU(.a(scra), .b(scrb), .f(alucontrol), .y(aluresult), .zero);
    
    //ALU Register
    flopr #(32)     ALUOUT_FF(.clk, .reset, .d(aluresult), .q(aluout));
    
    //Shift left for jump address
    sl2e #(26)      INSTR_SL2(.a(jmpimmed), .y(shiftjmpimm));
    
    //PCsrc Register
    mux3 #(32)      PCSRC_MUX(.d0(aluresult), .d1(aluout), .d2(pcjump), .s(pcsrc), .y(pcnext));
    
   // Your datapath hardware goes below.  Instantiate each of the submodules
   // that you need.  Feel free to copy ALU, muxes and other modules from
   // Lab 9.  This directory also includes parameterizable multipliexers
   // mux3.sv (paramaterized 3:1) and mux4.sv (paramterized 4:1)
   // Make sure to instantiate with the correct bitwidth!

   // Remember to give your instantiated modules applicable instance names
   // such as U_PCREG (PC register), U_WDMUX (Write Data Mux), etc.
   // so it's easier to find them during simulation and debugging.

endmodule
