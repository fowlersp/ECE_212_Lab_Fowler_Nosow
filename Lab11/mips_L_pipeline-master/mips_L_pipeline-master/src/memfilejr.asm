#      	Assembly              	Description      	Addr 	Machine
main:	addi $2, $0, 16 	# initialize $2 = 16	0 	20020016
  		jr $2 				# should be taken 		4 	00400008
		add $0, $0, $0		# Nop					8	00000020
  		addi $2, $0, 1 		# shouldn't happen 		c 	20020001
		sw $2, 84($0) 		# write mem[84] = 16 	10 	ac020054
