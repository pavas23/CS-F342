.data
x: .word 0xfffffff
msg: .asciiz "\nThe number after flipping all bits is\n"

.text
main:

# taking input from user
li $v0, 5
syscall
move $t0, $v0

lw $t1, x

# print x
move $a0, $t1
li $v0, 1
syscall

# take xor to reverse bits
xor $t2, $t1, $t0

# print ans
move $a0, $t2
li $v0, 1
syscall

li $v0, 10
syscall
