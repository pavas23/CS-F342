# program to take input as 2 integers and print their sum and difference

.data
msg1: .asciiz "Enter the first number: \n"
msg2: .asciiz "Enter the second number: \n"
msg3: .asciiz "The sum of the numbers is: \n"
msg4: .asciiz "\nThe difference of the numbers is: \n"

.text
main:

# print msg1
la $a0, msg1
li $v0, 4
syscall

# read first integer
li $v0, 5
syscall
addi $t0, $v0, 0

# print msg2
la $a0, msg2
li $v0, 4
syscall

# read second integer
li $v0, 5
syscall
addi $t1, $v0, 0

# print msg3
la $a0, msg3
li $v0, 4
syscall

# add
add $a0, $t0, $t1
li $v0, 1
syscall

# print msg4
la $a0, msg4
li $v0, 4
syscall

# sub
sub $a0, $t0, $t1
li $v0, 1
syscall

# exit
li $v0, 10
syscall



