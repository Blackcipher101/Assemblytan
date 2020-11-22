.data
str1: .asciiz "Give integer X from 1 to 20 "
str2: .asciiz "Give integer Y from 0 to 5 "
errormsg: .asciiz "Out of range.\n"
nline: .asciiz "\n"
result1: .asciiz " raised to "
result2: .asciiz " gives: "
.text

error:
li $v0,4  #print string1
la $a0,errormsg
syscall
beq $s2,$zero,getX
j getY

.globl main
main:
addi $s0,$zero,21 #s0=21
addi $s1,$zero,6 #s1=6

getX:
addi $s2,$zero,0 #s2=0 to input x and 1 to input y
li $v0,4
la $a0,str1
syscall  #print string1
li $v0,5
syscall  #read int
slt $s3,$v0,$s0 #$s3=($v0<$s0) if(x<21) $s1=1
move $t0,$v0

getY:
addi $s2,$zero,1
li $v0,4
la $a0,str2
syscall  #print string2
li $v0,5
syscall  #read int
slt $s3,$v0,$s1 #$s3=($v0<$s1) if(x<6) $s3=1
move $t1,$v0

beq $t1,$zero,else #if (t1=0) t2=1, t1=y,t2=result
addi $t2,$zero,1
addi $s4,$zero,0

loop:  #if s4<t1
slt $s5,$s4,$t1 #$s5=($s4<$t1) if(x<21) $s5=1
beq $s5,$zero,printresult 
#if $s1=0 goto printresult(s4=t1)
mul $t2,$t2,$t0 #t2=t2*t0
addi $s4,$s4,1
j loop

else:
addi $t2,$zero,1
j printresult

printresult:
li $v0,1
move $a0,$t0
syscall  #print X
li $v0,4
la $a0,result1
syscall  #print " raised to "
li $v0,1
move $a0,$t1
syscall  #print Y
li $v0,4
la $a0,result2
syscall  #print " gives "
li $v0,1
move $a0,$t2
syscall  #print result(t2)
li $v0,10
syscall  #exit