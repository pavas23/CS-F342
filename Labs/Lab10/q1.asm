# dynamic array of elements of size N
.data
msg: .asciiz "Enter value of N\n"

.text
main:

# taking input for N
la $a0, msg
li $v0, 4
syscall

li $v0, 5
syscall

# number of bytes needed will be 4*N
move $a2, $v0
li $a1, 4
mul $a0, $a2, $a1 # now $a0 will have number of bytes to be allocated
li $v0, 9 # sbrk system call code is 9
syscall

move $v1, $v0

# now $v0 will have the base address
li $a3, 0
loop:
    sw $a3, ($v0)
    addi $a3, $a3, 1
    beq $a3, $a2, findAns
    addi $v0, $v0, 4
    j loop

findAns:
    # for finding sum
    li $a3, 0
    li $t0, 0
    findSum:
        lw $t1, ($v1)
        add $t0, $t0, $t1
        addi $a3, $a3, 1
        beq $a3, $a2, done
        addi $v1, $v1, 4
        j findSum

done:
    move $a0, $t0
    li $v0, 1
    syscall
    li $v0, 10
    syscall

