.data
num1: .word 100
num2: .word 20
msg1: .asciiz "num1 is greater than num2: \n"
msg2: .asciiz "\nnum2 is greater than num1: \n"
msg3: .asciiz "\nnum1 and num2 are equal: \n"

.text
main:
lw $t0, num1
lw $t1, num2

beq $t0, $t1, equal
bgt $t0, $t1, greater

la $a0, msg2
li $v0, 4
syscall
j exit

greater:
la $a0, msg1
li $v0, 4
syscall
b exit

equal:
la $a0, msg3
li $v0, 4
syscall
b exit

exit:
li $v0, 10
syscall
