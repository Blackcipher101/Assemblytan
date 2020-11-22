.data
input: .asciiz "Enter a number to find it's factorial: "
print: .asciiz "\nThe factorial of the number is "
number: .word 0
factNo: .word 0
.text
    .globl main
    main:
    	# read number
    	li $v0 4
    	la $a0 input
    	syscall
    	
    	li $v0 5 # read int
    	syscall 
    	
    	sw $v0 number
    	
    	# call fact function
    	lw $a0 number
    	jal fact
    	sw $v0 factNo
    	
    	# print
    	li $v0 4
    	la $a0 print
    	syscall
    	
    	li $v0, 1
    	lw $a0 factNo
    	syscall
    	
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