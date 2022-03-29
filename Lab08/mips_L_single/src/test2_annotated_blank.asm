# test2.asm
# 23 March 2006 S. Harris sharris@hmc.edu
# Test MIPS instructions.
# Prelab - annotate test2.asm to explain what happens

#        Assembly                  Description                   Address   Machine
main:   ori  $t0, $0,  0x8000   # initialize $t0=0x00008000      0x00      34088000
       addi $t1, $0,  -32768    # initialize $t1=-32768          0x04      20098000
       ori  $t2, $t0, 0x8001    # $t2=(0x8001OR-32768)=0x8001    0x08      350A8001
       beq  $t0, $t1, there     # Should not 0x8000!=-32768      0x0c      11090005
       slt  $t3, $t1, $t0       # $t3 = -32768<0x8000 = 1        0x10      0128582A
       bne  $t3, $0,  here      # $t3 != 0 so go to here         0x14      15600001
       j    there               # Should not happen              0x18      08000024
here:   sub  $t2, $t2, $t0      # $t2 = 0x8001 - 0x8000 = 1      0x1c      01485022
       ori  $t0, $t0, 0xFF      # $t0=(0x8000OR0xFF)=0x80FF      0x20      350800FF
there: add  $t3, $t3, $t2       # $t3=1 + 1 = 2                  0x24      016A5820
       sub  $t0, $t2, $t0       # $t0=1 - 0x80ff = 0xFFFF7F02    0x28      01484022
       sw   $t0, 82($t3)        # [32851] = $t0                  0x2c      AD680052
