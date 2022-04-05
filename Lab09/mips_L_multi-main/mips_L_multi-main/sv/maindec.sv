//-------------------------------------------------------
// maindec.sv - Multicyle MIPS contoroller FSM
// David_Harris@hmc.edu 8 November 2005
// Update to SystemVerilog 17 Nov 2010 DMH
// Refactord and updated by John Nestor June 2018
// Key changes to this module:
//  1. replace state code parameters with enum
//     (simulator will display symbolic state names)
//  2. import opcodes from mips_decls_p package
//  3. set control signals individually in state machine
//     instead of as a bitvector (easier to understand
//     and follows state diagram in Fig. 7.42)
//------------------------------------------------

module maindec(
    input  logic       clk, reset,
    input  mips_decls_p::opcode_t  opcode,
    output logic       pcwrite, memwrite, irwrite, regwrite,
    output logic       alusrca, branch, iord, memtoreg, regdst,
    output logic [1:0] alusrcb, pcsrc,
    output logic [1:0] aluop
    );

   import mips_decls_p::*;

   enum logic [3:0] {
     FETCH   = 4'd0,
     DECODE  = 4'd1,
     MEMADR  = 4'd2,
     MEMRD   = 4'd3,
     MEMWB   = 4'd4,
     MEMWR   = 4'd5,
     RTYPEEX = 4'd6,
     RTYPEWB = 4'd7,
     BEQEX   = 4'd8,
     ADDIEX  = 4'd9,
     ADDIWB  = 4'd10,
     JEX     = 4'd11,
     ERROR   = 4'd12
  } state, next;

  // state register
  always_ff @(posedge clk)
    if(reset) state = FETCH;
    else state = next;

  // ADD CODE HERE
  // Finish entering the next state logic below.  We've completed the first
  // two states, FETCH and DECODE, for you.  See Figure 7.42 in the book.

  // next state logic
  always_comb begin
      case(state)
          FETCH:   next = DECODE;
          DECODE:  begin
              case(opcode)
                  OP_LW:      next = MEMADR;
                  OP_SW:      next = MEMADR;
                  OP_RTYPE:   next = RTYPEEX;
                  OP_BEQ:     next = BEQEX;
                  OP_ADDI:    next = ADDIEX;
                  OP_J:       next = JEX;
                  default:     next = ERROR; // should never happen
              endcase
          end
      // Add code here
        MEMADR: begin
            case(opcode)
                OP_LW:       next = MEMRD;
                OP_SW:       next = MEMWR;
                default:     next = ERROR;
            endcase
        end 
        MEMRD: next = MEMWB;
        MEMWB: next = FETCH;
        MEMWR: next = FETCH;
        RTYPEEX: next = RTYPEWB;
        RTYPEWB: next = FETCH;
        BEQEX: next = FETCH;
        ADDIEX: next = ADDIWB;
        ADDIWB: next = FETCH;
        JEX: next = FETCH;
        ERROR:   next = ERROR;  // stay in ERROR state until reset
        default: next = ERROR;  // should never happen but go to ERROR if it does
    endcase
 end
  // output logic

  // ADD CODE HERE
  // Finish entering the output logic below.  We've entered the
  // output logic for the first two states, FETCH(S0) and DECODE(S1), for you.
  always_comb begin
      // default output values
      pcwrite = 0;
      memwrite = 0;
      irwrite = 0;
      regwrite = 0;
      alusrca = 0;
      branch = 0;
      iord = 0;
      memtoreg = 0;
      regdst = 0;
      alusrcb = 2'b00;
      pcsrc = 2'b00;
      aluop = 2'b00;
      case(state)
          FETCH: begin
              iord = 0;
              alusrca = 0;
              alusrcb = 2'b01;
              aluop = 2'b00;
              pcsrc = 2'b00;
              irwrite = 1;
              pcwrite = 1;
          end
          DECODE: begin
              alusrca = 0;
              alusrcb = 2'b11;
              aluop = 2'b00;
          end
          //new fsm states
          MEMADR: begin
              alusrca = 1;
              alusrcb = 2'b10;
              aluop = 2'b00;
          end 
          MEMRD: iord = 1;
          MEMWB: begin
              regdst = 0;
              memtoreg = 1;
              regwrite = 1;
          end
          MEMWR: begin
              iord = 1;
              memwrite = 1;
          end
          RTYPEEX: begin
              alusrca = 1;
              alusrcb = 2'b00;
              aluop = 2'b10;
          end
          RTYPEWB: begin
              regdst = 1;
              memtoreg = 0;
              regwrite = 1;
          end
          BEQEX: begin
              alusrca = 1;
              alusrcb = 2'b00;
              aluop = 2'b01;
              pcsrc = 2'b01;
              branch = 1;
          end
          ADDIEX: begin
              alusrca = 1;
              alusrcb = 2'b10;
              aluop = 2'b00;
          end
          ADDIWB: begin
              regdst = 0;
              memtoreg = 0;
              regwrite = 1;
          end
          JEX: begin
              pcsrc = 2'b10;
              pcwrite = 1;
          end
          // add code here to specify outputs for remaining states
          // note you only need to add values specified in each state bubble
          // because default values are set before the case statement

          // just use default values set before case

      endcase // case (state)
  end

endmodule
