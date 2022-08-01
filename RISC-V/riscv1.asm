	addi s1,s1,3
	lui  s1,0xFFFFF		#I/O address
	
switch:				#read
	lw s0,0x70(s1)		#read switch
	#lui t0,0x00E00        	#test example
	#addi t0,t0,0x181
	#addi s0,t0,0
	andi s2,s0,0x7F		# s2 <- |A|
	andi t0,s0,0x80		# t0 <- A sign
	andi a1,s0,0x7f
	beq t0,x0,A_neg		# if A is negative, go to A_neg
	xori a1,a1,-1
	addi a1,a1,1		#get negative of A in a1
A_neg:	
	srli s0,s0,8		# right move 8 bits
	andi s3,s0,0x7f		# s3 <- |B|
	andi t1,s0,0x80		# B sign
	andi a2,s0,0x7f
	beq t1,x0,B_neg		# if B is negative, go to B_neg
	xori a2,a2,-1
	addi a2,a2,1		# get negative of B in a2
B_neg:
	srli s0,s0,0xD
	andi s4,s0,0xF		# get op in s4
	
	add a0,x0,x0		# compare
	beq s4,a0,no_op		# op=000
	addi a0,a0,1
	beq s4,a0,op_add	# op=001
	addi a0,a0,1
	beq s4,a0,op_sub	# op=010
	addi a0,a0,1
	beq s4,a0,op_and	# op=011
	addi a0,a0,1
	beq s4,a0,op_or		# op=100
	addi a0,a0,1
	beq s4,a0,op_sll	# op=101
	addi a0,a0,1
	beq s4,a0,op_sra	# op=110
	addi a0,a0,1			
	beq s4,a0,op_mul	# op=111
	
no_op:
	add s0,x0,x0		#always 0
	jal x0,write
op_add:
	add s0,a1,a2
	jal x0,write
op_sub:
	sub s0,a1,a2
	jal x0,write
op_and:
	and s0,a1,a2
	jal x0,write
op_or:
	or s0,a1,a2
	jal x0,write
op_sll:
	sll s0,a1,a2
	jal x0,write
op_sra:
	sra s0,a1,a2
	jal x0,write
	
op_mul:
	addi t3,x0,7		# yuanmayiweicheng
	slli s2,s2,7		#init
	addi s0,x0,0
	L1:
	beq t3,x0,end		#if t3=0, means mul is over
	andi t4,s3,0x1
	beq t4,x0,L2		#if=1,add;=0, go to L2
	add s0,s0,s2		#add A		
	L2:
	srli s3,s3,1		# B>>1
	srli s0,s0,1		# result>>1
	addi t3,t3,-1		# cnt - 1
	jal x0,L1
	end:
	xor t5,t0,t1		# get sign
	srai t5,t5,7
	beq t5,x0,write
	xori s0,s0,-1		# get negative of result
	addi s0,s0,1
	jal x0,write
	
write:				#write led and dk
	sw s0,0x60(s1)		#write led
	sw s0,0x00(s1)		#write dk
	jal x0,switch
	

	
