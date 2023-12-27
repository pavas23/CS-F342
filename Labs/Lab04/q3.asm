# take two numbers input from user and print A+B and A-B

.data
msg1: .asciiz "\nEnter the first number: "
msg2: .asciiz "\nEnter the second number: "
msg3: .asciiz "\nA+B = "
msg4: .asciiz "\nA-B = "

.text
main:

# print msg1
la $a0, msg1
li $v0, 4
syscall

# read float 1,it will be stored in $f0
li $v0, 6
syscall
mov.s $f1, $f0

# print msg2
la $a0, msg2
li $v0, 4
syscall

# read float 2
li $v0, 6
syscall
mov.s $f2, $f0

add.s $f12, $f0, $f1

# print msg3
la $a0, msg3
li $v0, 4
syscall

li $v0, 2
syscall

sub.s $f12, $f1, $f2

# print msg4
la $a0, msg4
li $v0, 4
syscall

li $v0, 2
syscall

# exit
li $v0, 10
syscall
