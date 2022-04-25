#      	Assembly              	Description      	Addr 	Machine
main:	addi $2, $0, 5 		# initialize $2 = 5		0 	20020005
  		jal end 			# should be taken 		4 	0c000004
		add $0, $0, $0		#Nop					8	00000020
  		addi $2, $0, 1 		# shouldn't happen 		c 	20020001
end:	add $0, $0, $0		#Nop					10	00000020
	 	sw $31, 84($0) 		# write mem[84] = 8 	14 	ac1f0054
