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
beq $a0,$t0, end # if n = 0 go to end and return 1
add $0, $0, $0 # branch delay
beq $a0,$t1, end # if n = 1 go to end and return 1
add $0, $0, $0 # branch delay
addi $s0, $0, 1 # initial value is 1
loop:    slt $t2, $s0, $a0 # s0 < n
	beq $t2, $0, end # if t2 == 0 which means s0 >= n end
	add $t3, $t0, $t1 # a = fib(n-1) + fib(n)
	add $t0, $0, $t1 # fib(n-1) = fib(n)
	add $t1, $0, $t3 # fib(n) = a
	add $s0, $s0, 1  # s0++
	j loop
	add $0, $0, $0 # branch delay slot
end:   
add $v0, $0, $t1 # return fib(n)
jr $ra # return to caller 
add $0, $0, $0 # branch delay slot



