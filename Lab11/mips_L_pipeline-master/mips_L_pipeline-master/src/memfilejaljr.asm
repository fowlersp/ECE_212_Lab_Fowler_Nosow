#      Assembly              	Description      		Addr 	Machine
main:	addi $a0, $0, 5 		# initialize $a0 = 5	0 	20040005
	addi $a1, $0, 7 		# initialize $a1 = 7	4 	20050007
	jal min			# jump to min		8	0C00000C
	add $0, $0, $0		# Nop				c	00000020
	addi $s0, $v0, 0		# Store $s0=min(5,7) 	10	20500000
	addi $a0, $0, 17 		# initialize $a0 = 17	14 	20040011
	addi $a1, $0, -5 		# initialize $a1 = -5	18 	2005FFFB
	jal min			# jump to min		1c	0C00000C
	add $0, $0, $0		# Nop				20	00000020
	addi $s1, $v0, 0		# Store $s1=min(-5,17)	24	20510000
	j end				# jump to end		28	08000017
	add $0, $0, $0		# Nop				30	00000020
min:  slt $t0, $a0, $a1		# $t0 = $a0 < $a1		34	0085402A
	add $0, $0, $0		# Nop				38	00000020
	add $0, $0, $0		# Nop				3c	00000020
	beq $t0, $0, else		# If $a1<$a0 go to else	40	11000004
	add $0, $0, $0		# Nop				44	00000020
	addi $v0, $a0, 0		# return $a0		48	20820000
  	jr $ra 			# should be taken 	4c 	03E00008
	add $0, $0, $0		# Nop				50	00000020
else: addi $v0, $a1, 0		# return $a			54	20A20000
	jr $ra			# jump to main		58	03E00008
	add $0, $0, $0		# Nop				5c	00000020
	add $0, $0, $0		# Nop				60	00000020
	sw $s0, 84($0) 		# write mem[84] = 5 	64 	ac020054