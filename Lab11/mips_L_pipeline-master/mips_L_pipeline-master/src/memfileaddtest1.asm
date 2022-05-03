#      Assembly              	Description      		Addr 	Machine
main:	addi $10, $0, 16 		# initialize $10 = 16	0 	200A0016
	addi $8, $0, 3		# initialize $8 = 3	4	20080003
	add $9, $8, $10		# 19 = 3 + 16		8	010A4820
	sw $9, 50($0)		# write mem[50] = 19	c	AC090032
  	lw $10, 50($0) 		# $10 = mem[50]		10 	8C0A0032
	add $10, $10, $10	# $10 = 2x$10		14	014A5020 
	addi $8, $0, 38		# $8 = 38			18	20080032
	beq $10, $8, end		# Should be taken		1c	11480001
  	addi $10, $0, 1 		# shouldn't happen 	20	200A0001
end:	sw $10, 84($0) 		# write mem[84] = 19 	24 	ac0A0054