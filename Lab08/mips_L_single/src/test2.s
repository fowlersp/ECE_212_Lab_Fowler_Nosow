# test2.s
# 23 March 2006 S. Harris sharris@hmc.edu
# Test MIPS instructions.
# Modified to run on MPLAB MIPS simulator including delay slots
# implemented as nop pseudoinstructions
# To get correct translation to machine language for branches, comment out the nops.
# This won't simulate correctly but will give correct branch offsets
# jump addresses will need to be translated by hand

.global main # define main as a global label
.set noreorder # don't let the assembler reorder instructions
main: ori  $t0, $0,  0x8000
      addi $t1, $0,  -32768
      ori  $t2, $t0, 0x8001
      beq  $t0, $t1, there
      nop #delay slot
      slt  $t3, $t1, $t0
      bne  $t3, $0,  here
      nop #delay slot
      j    there
      nop #delay slot
here: sub  $t2, $t2, $t0
      ori  $t0, $t0, 0xFF
there:	add  $t3, $t3, $t2
      sub  $t0, $t2, $t0
      sw   $t0, 82($t3)
loop: j loop            # end of simulation
      nop #delay slot
