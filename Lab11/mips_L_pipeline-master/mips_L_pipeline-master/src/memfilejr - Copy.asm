#      Assembly              	Description      		Addr 	Machine
main:	addi $7, $0, 16 		# initialize $7 = 16	0 	20070016
	addi $8, $0, 3		# initialize $8 = 3	4	20080003
	add $9, $7, $8		# $9 = 7 + 8		8	
	sw $9, 50($0)		# write mem[50] = 19	c
  	lw $7, 50($0) 		# $7 = mem[50]		10 	00400008
	beq $7, $7, end		# Should be taken		14	00000020
  	addi $2, $0, 1 		# shouldn't happen 	18	20020001
end:	sw $7, 84($0) 		# write mem[84] = 19 	1c 	ac020054