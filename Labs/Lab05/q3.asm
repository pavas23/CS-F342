.data
float1: .asciiz "Enter first float: \n"
float2: .asciiz "\n Enter second float: \n"
newLine: .asciiz "\n"
equal: .asciiz "\nBoth numbers are equal\n"
minimum: .asciiz "\nThe minimum number is: \n"
maximum: .asciiz "\nThe maximum number is: \n"

.text
main:

la $a0, float1
li $v0, 4
syscall

li $v0, 6
syscall
mov.s $f1, $f0

la $a0, float2
li $v0, 4
syscall

li $v0, 6
syscall
mov.s $f2, $f0

c.lt.s $f1, $f2 # set the flag if $f1 < $ f2

bc1f firstIsMax
secondIsMax:
la $a0, minimum
li $v0, 4
syscall

mov.s $f12, $f1
li $v0, 2
syscall

la $a0, maximum
li $v0, 4
syscall

mov.s $f12, $f2
li $v0, 2
syscall

j exit

firstIsMax:
la $a0, minimum
li $v0, 4
syscall

mov.s $f12, $f2
li $v0, 2
syscall

la $a0, maximum
li $v0, 4
syscall

mov.s $f12, $f1
li $v0, 2
syscall

exit:
li $v0, 10
syscall
