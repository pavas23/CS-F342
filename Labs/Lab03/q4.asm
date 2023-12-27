# take 2 numbers and a predefined number as input, print equal if a*b == predefined otherwise (a*b)%predefined

.data
msg1: .asciiz "Enter first number: "
msg2: .asciiz "\nEnter second number: "
num: .word 100
msg3: .asciiz "\nEqual"

.text
main:

# print msg1
la $a0, msg1
li $v0, 4
syscall

# take int 1
li $v0, 5
syscall
move $t0, $v0

# print msg2
la $a0, msg2
li $v0, 4
syscall

# take int 2
li $v0, 5
syscall
move $t1, $v0

# load the predefined number from memory to a reg
lw $t3, num

# find product
mult $t0, $t1
mflo $t2

beq $t2, $t3, equal
# not equal
div $t2, $t3
mfhi $t4
# print the remainder
move $a0, $t4
li $v0, 1
syscall
j exit

equal:
# print mg3
la $a0, msg3
li $v0, 4
syscall
j exit

exit:
li $v0, 10
syscall

