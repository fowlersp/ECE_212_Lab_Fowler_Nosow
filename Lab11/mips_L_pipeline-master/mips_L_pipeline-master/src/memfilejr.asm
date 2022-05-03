#      Assembly              	Description      		Addr 	Machine
main:	addi $2, $0, 18 		# initialize $2 = 18	0 	20020018
	add $0, $0, $0		# Nop				4	00000020
	add $0, $0, $0		# Nop				8	00000020
  	jr $2 			# should be taken 	c 	00400008
	add $0, $0, $0		# Nop				10	00000020
  	addi $2, $0, 1 		# shouldn't happen 	14	20020001
	sw $2, 84($0) 		# write mem[84] = 16 	18 	ac020054
