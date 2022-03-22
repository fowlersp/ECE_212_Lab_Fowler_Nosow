.global main # define main as a global label
.set noreorder # don't let the assembler reorder instructions
main: addi $a0,$0,11 # n = 8 (find 8th fib number)
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
fibr:   addi $sp, $sp, -12 # move stack pointer to make space
	sw $a0, 8($sp) # add argument value to stack
	sw $s0, 4($sp)	# add previous value to stack
	sw $ra, 0($sp) # add return address to stack
	addi $t0, $0, 2
	slt $t1, $a0, $t0 # if n<2 return 1
	beq $t1, $0, else 
	add $0, $0, $0 # branch delay slot
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $a0, 8($sp)
	addi $sp, $sp, 12
	addi $v0, $a0, 0
	jr $ra
	add $0, $0, $0 # branch delay slot

else:   add $a0, $a0, -1
	jal fibr
	add $0, $0, $0 # branch delay 
	add $s0, $0, $v0
	add $a0, $a0, -1
	jal fibr
	add $0, $0, $0 # branch delay slot
	add $v0, $s0, $v0
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $a0, 8($sp)	
	addi $sp, $sp, 12
	jr $ra
	add $0, $0, $0 # branch delay slot




