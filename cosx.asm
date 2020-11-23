.data
	inputMsg: .asciiz "Enter a number in radians: "
	const: .float 2.0
	one: .float 1.0
.text
    main:
    	lwc1 $f0 const
	add.s $f2 $f2 $f0
        addi $a2 $zero 3
        mul.s $f12 $f2 $f0
        #jal power
        mov.s $f12 $f2
        
        li $v0 2
        syscall
	
n

power:
    li $t0 1
    lwc1 $f1 one
    loop:
        bgt $t0 $a2 exit # $a2 is power
        addi $t0 $t0 1
        mul.s $f1 $f1 $f2 # power value is returned to $f1, base is $f2
        j loop
        exit:
        jr $ra
