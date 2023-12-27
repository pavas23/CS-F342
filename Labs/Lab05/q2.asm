# code to find sum of first n natural numbers
.data
msg1: .asciiz "Enter value of n: \n"
msg2: .asciiz "\nSum of first n natural numbers is: \n"

.text
main:

# print msg1
la $a0, msg1
li $v0, 4
syscall

# take input
li $v0, 5
syscall

move $t2, $v0

addi $t0, $zero, 1
add $t3, $zero, $zero

whileloop: 
    bgt $t0, $t2, done
    add $t3, $t3, $t0
    addi $t0, $t0, 1
    j whileloop

done:
# print msg2
la $a0, msg2
li $v0, 4
syscall

move $a0, $t3
li $v0, 1
syscall


exit:
li $v0, 10
syscall
