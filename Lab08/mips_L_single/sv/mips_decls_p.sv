//-----------------------------------------------------------------------------
// mips_decls_p.sv
// John Nestor, Lafayette College May 2018
// Common declarations for MIPS architecture (opcodes, function codes)
// For use in the MIPS single cycle, multicycle, and pipelined designs
//-----------------------------------------------------------------------------

package mips_decls_p;

    // opcodes from Table B.1 - add more as needed
    typedef enum logic [5:0] {
    OP_RTYPE   = 6'd0,
    OP_BLTGEZ  = 6'd1,
    OP_J       = 6'd2,
    OP_JAL     = 6'd3,
    OP_BEQ     = 6'd4,
    OP_BNE     = 6'd5,
    OP_ADDI    = 6'd8,
    OP_ORI     = 6'd13,
    OP_LW      = 6'd35,
    OP_SW      = 6'd43
    } opcode_t;

    // function codes from table B.2 - add more as needed
    typedef enum logic [5:0] {
    F_ADD = 6'd32,
    F_SUB = 6'd34,
    F_AND = 6'd36,
    F_OR  = 6'd37,
    F_XOR = 6'd38,
    F_NOR = 6'd39,
    F_SLT = 6'd42
    } funct_t;

endpackage
