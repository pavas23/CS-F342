.data
val: .float 1.23045
msg: .asciiz "Enter a number: "

.text
main:

# print the number from data segment
l.s $f0,val
mov.s $f12, $f0
li $v0, 2
syscall

# print msg
la $a0, msg
li $v0, 4
syscall

# take input from user, it will store value in $f0
li $v0, 6
syscall
mov.s $f12, $f0

# printing the input
li $v0, 2
syscall

#exit
li $v0, 10
syscall




