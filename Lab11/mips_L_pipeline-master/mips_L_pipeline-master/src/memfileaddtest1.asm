#      Assembly              	Description      		Addr 	Machine
main:	addi $10, $0, 16 		# initialize $10 = 16	0 	200A0016
	addi $8, $0, 3		# initialize $8 = 3	4	20080003
	add $9, $7, $8		# $9 = 7 + 8		8	010A4820
	sw $9, 50($0)		# write mem[50] = 19	c	AC090032
  	lw $10, 50($0) 		# $7 = mem[50]		10 	8C0A0032
	beq $10, $10, end		# Should be taken		14	114A0001
  	addi $10, $0, 1 		# shouldn't happen 	18	200A0001
end:	sw $10, 84($0) 		# write mem[84] = 19 	1c 	ac0A0054