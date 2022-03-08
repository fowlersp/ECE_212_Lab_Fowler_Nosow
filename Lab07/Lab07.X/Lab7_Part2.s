.global main # define main as a global label
.set noreorder # don't let the assembler reorder instructions
main: addi $a0,$0,8 # n = 8 (find 8th fib number)
jal fibr # call fib(8)
addi $0, $0, 0 # branch delay slot
addi $a0,$0,10 # n = 10 
jal fibr # call fib(10)
addi $0, $0, 0 # branch delay slot
addi $a0,$0,1 # n = 1 
jal fibr # call fib(1)
addi $0, $0, 0 # branch delay slot
addi $a0,$0,2 # n = 2
jal fibr # call fib(2)
addi $0, $0, 0 # branch delay slot
done: j done # infinite loop
add $0, $0, $0 # branch delay slot

#fibr(n) function
fibr:      addi $sp, $sp, -12
	sw $a0, 8($sp)
	sw $s0, 4($sp)
	sw $ra, 0($sp)
	addi $t0, $0, 2
	slt $t1, $a0, $t0
	beq $t1, $0, else
	addi $v0, $0, 1
	addi $sp, $sp, 12
	jr $ra
else:   add $a0, $a0, -1
	jal fibr
	add $s0, $0, $v0
	add $a0, $a0, -1
	jal fibr
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $a0, 8($sp)	
	add $sp, $sp, 12
	add $v0, $s0, $v0
	jr $ra




