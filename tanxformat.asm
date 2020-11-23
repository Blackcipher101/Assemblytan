.text
.globl main

main:
	li $t0,3 		# Initilize N
	l.s $f4,one     	# Set Accuracey
	li $v0,4        	# syscall for Print String
	la $a0, prompt1 	# load address of prompt
	syscall         	# print the prompt
	li $v0,6        	# Reads user number
	syscall
	lwc1 $f20 zero
	add.s $f20 $f20 $f0     # taking a copy of the angle
	mul.s $f2,$f0,$f0 	# x^2
	mov.s $f12,$f0 		# Answer
	li $t7 0
#---------------- -------------------------------- --------------------------------
for:
	beq $t7 10 endfor
	abs.s $f1,$f0  		# compares to the non-negative value of the series
	c.lt.s $f1,$f4 		# is number < 1.0e-6?
	#bc1t endfor
	subu $t1,$t0,1 		# (n-1)
	mul $t1,$t1,$t0		 # n(n-1)
	mtc1 $t1, $f3 		# move n(n-1) to a floating register
	cvt.s.w $f3, $f3 	# converts n(n-1) to a float
	div.s $f3,$f2,$f3 	# (x^2)/(n(n-1))
	neg.s $f3,$f3 		# -(x^2)/(n(n-1))
	mul.s $f0,$f0,$f3 	# (Series*x^2)/(n(n-1))

	add.s $f12,$f12,$f0 	# Puts answer into $f12

	addu $t0,$t0,2 		# Increment n
	addi $t7 $t7 1
	b for 			# Goes to the beggining of the loop
endfor:
#---------------- -------------------------------- --------------------------------

mov.s $f25 $f12   		# f25 --> stores sin x value
lwc1 $f12 zero


# ------------------------------------- calculation for cos

li $t0,3 			# Initilize N
l.s $f4,one 			# Set Accuracey
lwc1 $f31 halfPi
sub.s $f20 $f31 $f20 
mul.s $f2,$f20,$f20 		# x^2
mov.s $f12,$f20 		# Answer
li $t7 0
for1:
beq $t7 10 endfor1
abs.s $f1,$f20 			# compares to the non-negative value of the series
c.lt.s $f1,$f4 			# is number < 1.0e-6?
#bc1t endfor
subu $t1,$t0,1 			# (n-1)
mul $t1,$t1,$t0 		# n(n-1)
mtc1 $t1, $f3			# move n(n-1) to a floating register
cvt.s.w $f3, $f3                # converts n(n-1) to a float
div.s $f3,$f2,$f3	 	# (x^2)/(n(n-1))
neg.s $f3,$f3 			# -(x^2)/(n(n-1))
mul.s $f20,$f20,$f3 		# (Series*x^2)/(n(n-1))

add.s $f12,$f12,$f20 		# Puts answer into $f12

addu $t0,$t0,2 			# Increment n
addi $t7 $t7 1
b for1 				# Goes to the beggining of the loop
endfor1:
lwc1 $f24 zero
add.s $f24 $f24 $f12   		# storing cos value in f24
lwc1 $f12 zero

div.s $f12 $f25 $f24

li $v0,2 			# Prints answer in $f12
syscall
li $v0,10 			# code 10 == exit
syscall 			# Halt the program.
#---------------- -------------------------------- --------------------------------
.data
prompt1: .asciiz "Please enter the angle 'x' in radians to calculate Tan(x): "
one: .float 1.0
halfPi: .float 1.57
zero: .float 0
