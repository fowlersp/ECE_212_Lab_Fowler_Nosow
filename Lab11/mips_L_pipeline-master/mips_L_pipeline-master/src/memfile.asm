#      	Assembly              	Description      	Addr 	Machine
main:	addi $2, $0, 5 	# initialize $2 = 5	0 	20020005
  	addi $3, $0, 12 	# initialize $3 = 12 	4 	2003000c
	add $0, $0, $0		#Nop			8	00000020
	add $0, $0, $0		#Nop			c	00000020
  	addi $7, $3, −9 	# initialize $7 = 3    	10 	2067fff71
	add $0, $0, $0		#Nop			14	00000020
	add $0, $0, $0		#Nop			18	00000020
  	or $4, $7, $2 		# $4 = (3 OR 5) = 7 	1c 	00e22025
	add $0, $0, $0		#Nop			20	00000020
	add $0, $0, $0		#Nop			24	00000020
  	and $5, $3, $4 	# $5 = (12 AND 7) =4 	28	00642824
	add $0, $0, $0		#Nop			2c	00000020
	add $0, $0, $0		#Nop			30	00000020
  	add $5, $5, $4 	# $5 = 4 + 7 = 11 	34 	00a42820
	add $0, $0, $0		#Nop			38	00000020
	add $0, $0, $0		#Nop			3c	00000020
 	beq $5, $7, end 	# shouldn't be taken 	40 	10a70015
	add $0, $0, $0		#Nop			44	00000020
  	slt $4, $3, $4 		# $4 = 12 < 7 = 0 	48 	0064202a
	add $0, $0, $0		#Nop			4c	00000020
	add $0, $0, $0		#Nop			50	00000020
  	beq $4, $0, around 	# should be taken 	54 	10800002
	add $0, $0, $0		#Nop			58	00000020
  	addi $5, $0, 0 		# shouldn’t happen 	5c 	20050000
around: slt $4, $7, $2 	  	# $4 = 3 < 5 = 1 	60 	00e2202a
	add $0, $0, $0		#Nop			64	00000020
	add $0, $0, $0		#Nop			68	00000020
  	add $7, $4, $5 	# $7 = 1 + 11 = 12 	6c 	00853820
	add $0, $0, $0		#Nop			70	00000020
	add $0, $0, $0		#Nop			74	00000020
 	sub $7, $7, $2 	# $7 = 12 − 5 = 7 	78 	00e23822
	add $0, $0, $0		#Nop			7c	00000020
	add $0, $0, $0		#Nop			80	00000020
  	sw $7, 68($3) 		# [80] = 7 		84 	ac670044
 	lw $2, 80($0) 		# $2 = [80] = 7 	88 	8c020050
  	j end 			# should be taken 	8c 	08000046
	add $0, $0, $0		#Nop			90	00000020
  	addi $2, $0, 1 		# shouldn't happen 	94 	20020001
end: 	sw $2, 84($0) 		# write mem[84] = 7 	98 	ac020054