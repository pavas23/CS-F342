# take two integers and print a*b a/b and a%b

.data
msg1: .asciiz "\nEnter the first number:"
msg2: .asciiz "\nEnter the second number: "
msg3: .asciiz "\n Product is: "
msg4: .asciiz "\n Quotient is: "
msg5: .asciiz "\n Remainder is: "

.text
main:

# print msg1
la $a0, msg1
li $v0, 4
syscall

# read int 1
li $v0, 5
syscall
move $t0,$v0

# print msg2
la $a0, msg2
li $v0, 4
syscall

# read int 2
li $v0, 5
syscall
move $t1, $v0

# a*b
mult $t0, $t1
mflo $a1

# print msg3
la $a0, msg3
li $v0, 4
syscall

# print a*b
move $a0, $a1
li $v0, 1
syscall

# a/b
div $t0, $t1
mflo $a1 # $a1 will have quotient

# print msg4
la $a0, msg4
li $v0, 4
syscall

# print a/b
move $a0, $a1
li $v0, 1
syscall

mfhi $a1 # $a1 will have remainder now

# print msg5
la $a0, msg5
li $v0, 4
syscall

# print a%b
move $a0, $a1
li $v0, 1
syscall

# exit
exit:
li $v0, 10
syscall

