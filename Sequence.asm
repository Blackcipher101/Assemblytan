.data
promt: .asciiz "Enter number:"
.text    
	
	li $v0,4
	la $a0,promt
	syscall
		
	# get integer
	li $v0,5 
	syscall
	move $s0, $v0
numberseries:  beq $s0, 0, end
      addi $s0, $s0,-1

      
      move $a0,$s0
      li $v0,1
      syscall
      j numberseries
end:  li $v0, 10
	syscall 