.data
 	promptMessage: .ascii "Enter number"
	resultMessage:  .ascii "\nthe result"
	theNumber: .word 3
	thePower:  .word 2
 	theAnswer: .word 0
 
 .text
 	.globl main
 	main:
 		addi $a3,$zero, 3    #parameters
 		addi $a2, $zero, 2   #parameters
 		jal power            #call
 	
 	
		li $v0,1
		sw $v1, theAnswer   #return
		li $v0,1
		lw $a0, theAnswer
		syscall
	
	li $v0,10
	 syscall
	 
.globl power
power:
	li $t0,0
	li $v1,1
	loop:
    	bgt $t0,$a2,exit
    	addi $t0,$t0,1
    	mul $v1,$v1,$a3
    	j loop  

	exit:
	jr $ra
	