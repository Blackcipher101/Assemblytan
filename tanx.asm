.data
input: .asciiz "Enter a the angle in radians to find it's tangent value: "
print: .asciiz "\nThe value of Tan(x) is: "
factNo: .word 0
sum: .double 0.0 # initialize sum
b: .double 0.0
temp: .double 0.0
doubleZero: .double 0.0
one: .double 1.0
.text
    .globl main
    main:
    	# read number
    	# ------- ------- ------- ------- ------- -------
    	li $v0 4
    	la $a0 input # print input statement
    	syscall
    	li $v0 7 # read angle in Float
    	syscall 
    	# ------- ------- ------- ------- ------- -------
    	
    	# move the input value to t9 register
    	# ------- ------- ------- ------- ------- -------
    	li $t9 0
    	move $v0 $t9
    	#mtc1 $t1 $f31
    	# ------- ------- ------- ------- ------- -------
    	l.d $f0 sum # initialize sum register 'f0'
    	
    	# start outermost loop
	# ------- ------- ------- ------- ------- -------
    	li $s0 1
        loop:
    	   bgt $s0 8 exit
    	   li $t5 0
    	   l.d $f25 $t5	# b=0.0
    	   mul $s1 $s0 2     # Bn = 2*i
    	   li $s2 0
    	   # Second loop
    	   loop2: 
    	     bgt $s2 $s1 exit1
    	     l.d $f2 temp    # initialize 'temp' variable
    	     li $s3 0
    	     # Third loop
    	     loop3:
    	        bgt $s3 $s2 exit2
    	        
    	        # ------- ------- ------- ------- ------- -------
    	        # -1^r
    	        li $a3 0
    	        li $a2 0
    	     	addi $a3,$zero, -1 
    	     	add $a2, $a2 $s3 
    	     	jal power
    	     	l.d $f3 doubleZero
    	     	li $t1 0   # initialize t1 to 0
    	     	add $t1 $t1 $v1
    	     	mtc1 $t1 $f3   # load f3's value
    	     	# ------- ------- ------- ------- ------- -------
    	     	# k!
    	     	li $t1 0   # initialize t1 to 0
    	     	add $t1 $t1 $s2
    	     	li $a0 0
    	     	add $a0 $a0 $t1
    	     	jal fact
    	     	li $t1 0
    	     	add $t1 $t1 $v0
    	     	mtc1 $t1 $f4
    	     	# ------- ------- ------- ------- ------- -------
    	     	# multiplying the first two terms of the numerator
    	     	l.d $f4 b
    	     	li $t1 1
    	     	mul.s $f4 $f3 $f4
    	     	# ------- ------- ------- ------- ------- -------
    	     	# Finding r^Bn
    	     	li $a3 0
    	     	li $a2 0
    	     	add $a3,$a3,$s3
    	     	add $a2, $a2 $s1
    	     	jal power
    	     	l.d $f5 doubleZero
    	     	li $t1 0   # initialize t1 to 0
    	     	add $t1 $t1 $v1
    	     	mtc1 $t1 $f5   # load f3's value
    	     	# ------- ------- ------- ------- ------- -------
    	     	# Getting the whole numerator term (f5)
    	     	mul.s $f5 $f5 $f4
    	     	# ------- ------- ------- ------- ------- -------
    	     	# r!
    	     	li $a0 0
    	     	add $a0 $a0 $s3
    	     	jal fact
    	     	li $t1 0
    	     	add $t1 $t1 $v0
    	     	mtc1 $t1 $f6
    	     	# ------- ------- ------- ------- ------- -------
    	     	# (k-r)!
    	     	li $t1 0
    	     	li $t2 0
    	     	addi $t1 $s2 0
    	     	addi $t2 $s3 0
    	     	sub $t3 $t1 $t2 #f7
    	     	li $a0 0
    	     	addi $a0 $t3 0
    	     	jal fact
    	     	li $t1 0
    	     	add $t1 $t1 $v0
    	     	mtc1 $t1 $f8
    	     	# ------- ------- ------- ------- ------- -------
    	     	# calculating the denominator eterm
    	     	l.d $f9 b
    	     	mul.s $f9 $f8 $f6
    	     	# ------- ------- ------- ------- ------- -------
    	     	# dividing numerator with denominator
    	     	l.d $f10 b
    	     	div.d $f10 $f5 $f9
    	     	# ------- ------- ------- ------- ------- -------
    	     	# temp+= $f10
    	     	l.d $f2 b
    	     	add.d $f2 $f2 $f10
    	     	# ------- ------- ------- ------- ------- -------
    	     	# Exit innermost loop
    	     	addi $s3 $s3 1
    	     	j loop3
    	     exit2:
    	     # Inside middle loop
    	     # b+= temp/k+1
    	     # b -> f1
    	     # temp -> f2
    	     # k -> s2
    	     li $t0 0
    	     add $t0 $s2 1
    	     mtc1 $t0 $f11
    	     l.d $f10 b
    	     div.d $f10 $f2 $f11
    	     add.d $f1 $f1 $f10
    	     # ------- ------- ------- ------- ------- -------
    	     # Exit middle loop
    	     addi $s2 $s2 1
    	     j loop2
    	   exit1:
    	   # ------- ------- ------- ------- ------- -------
    	   # enter outermost loop
    	   # ------- ------- ------- ------- ------- -------
    	   # -4^i
    	   l.d $f13 b
    	   li $a3 0
       	   li $a2 0
       	   addi $a3,$a3,-4
	   add $a2, $a2 $s0
	   jal power
	   l.d $f13 doubleZero
	   li $t1 0   # initialize t1 to 0
	   add $t1 $t1 $v1
	   mtc1 $t1 $f13   # load f13's value
	   # ------- ------- ------- ------- ------- -------
	   # -4^i+1
	   l.d $f14 one
	   add.d $f14 $f14 $f13
	   # ------- ------- ------- ------- ------- -------
	   # multiplying the first 2 terms 
	   l.d $f15 b
	   mul.d $f15 $f14 $f13
	   # ------- ------- ------- ------- ------- -------
	   # multiplying the first 3 terms
	   l.d $f16 b
	   mul.d $f16 $f15 $f1
	   # ------- ------- ------- ------- ------- -------
	   # finding x power
	   li $t0 0
	   li $t1 0
	   li $t8 0
	   addi $t0 $s0 0
	   mul $t1 $t0 2 # -----> 2*i
	   #l.d $f17 b
	   #mtc1 $t1 $f17   # -----> 2*i
	   #l.d $f18 0
	   li $t2 0
	   sub $t2 $t1 1   # --------> 2i -1
	   move $t1 $t8    # t8 -----> 2*i
	   #sub.d $f18 $f17 $f24    # --------> 2i -1
	   # ------- ------- ------- ------- ------- -------
	   # x ^ 2*i -1
	   # 2^i-1 --> t2
	   # x --> t9
	   # t9 ^ t2
	   li $a3 0
	   li $a2 0
	   add $a3 $a3 $t9   # x---> t9 
	   add $a2 $a2 $t2
	   jal power
	   l.d $f19 doubleZero
	   li $t1 0   # initialize t1 to 0
    	   add $t1 $t1 $v1
    	   mtc1 $t1 $f19   # load f19's value
	   # ------- ------- ------- ------- ------- -------
	   # Numerator   -----> f21
	   l.d $f21 b
	   mul.d $f21 $f19 $f16
	   # ------- ------- ------- ------- ------- -------
	   # Denominator ----> f20
	   li $a0 0
	   add $a0 $a0 $t8
	   jal fact
	   li $t1 0
    	   add $t1 $t1 $v0
    	   mtc1 $t1 $f20
	   # ------- ------- ------- ------- ------- -------
	   # find the fraction term  -------> f22
	   l.d $f22 b
	   div.d $f22 $f21 $f20
	   # ------- ------- ------- ------- ------- -------
	   # SUMMATION
	   add.d $f0 $f0 $f22
    	# ------- ------- ------- ------- ------- -------
    	# Exit outermost loop
    	addi $s0 $s0 1
    	j loop
    	exit:
    	# ------- ------- ------- ------- ------- -------
    	
    	# print the output statement and the factorial value
    	# ------  ------  ------  ------  ------  ------
    	li $v0 4
    	la $a0 print
    	syscall
    	li $v0, 2
    	#lw $a0 factNo  # load the final value into $a0 for it to print!!
    	syscall
    	# ------  ------  ------  ------  ------  ------
    	    	
    	# stop execution
    	li $v0 10
    	syscall

# Factorial function
.globl fact
fact:
	subu $sp $sp 8
	sw $ra ($sp)
	sw $s0 4($sp)
	
	# Base case
	li $v0 1
	beq $a0 0 factDone
	
	# fact(number -1)
	move $s0 $a0
	sub $a0 $a0 1
	jal fact
	
	mul $v0 $s0 $v0
	
	factDone:
		lw $ra ($sp)
		lw $s0 4($sp)
		addu $sp $sp 8
		jr $ra

# Power function
.globl power
power:
	li $t0,1
	li $v1,1
	l:
    	bgt $t0,$a2,e
    	addi $t0,$t0,1
    	mul $v1,$v1,$a3
    	j l
	e:
	jr $ra