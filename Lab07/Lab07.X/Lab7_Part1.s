.global main # define main as a global label
.set noreorder # don't let the assembler reorder instructions
main: addi $a0,$0,8 # n = 8 (find 8th fib number)
jal fib # call fib(8)
addi $0, $0, 0 # branch delay slot
addi $a0,$0,10 # n = 10 
jal fib # call fib(10)
addi $0, $0, 0 # branch delay slot
addi $a0,$0,1 # n = 1 
jal fib # call fib(1)
addi $0, $0, 0 # branch delay slot
addi $a0,$0,2 # n = 2
jal fib # call fib(2)
addi $0, $0, 0 # branch delay slot
done: j done # infinite loop
 add $0, $0, $0 # branch delay slot


# fib(n) function 
fib: 
addi $t0,$0, 0 # prev = fib(-1) 
addi $t1,$0, 1 # curr = fib(0)
beq $a0,$t0, end
add $0, $0, $0
beq $a0,$t1, end
add $0, $0, $0
addi $s0, $0, 1
loop:    slt $t2, $s0, $a0
	beq $t2, $0, end
	add $t3, $t0, $t1
	add $t0, $0, $t1
	add $t1, $0, $t3
	add $s0, $s0, 1
	j loop
	add $0, $0, $0 # branch delay slot
end:   
add $v0, $0, $t1
jr $ra # return to caller 
add $0, $0, $0 # branch delay slot



