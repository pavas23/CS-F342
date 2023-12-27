# fiboncci sequence recursively
.data
msg: .asciiz "Enter value of n\n"
new_line: .asciiz "\n"

.text
main:

# taking value of n as input
la $a0, msg
li $v0, 4
syscall

li $v0, 5
syscall

move $a0, $v0

# now we have value of n in $a0
# call recursive function
jal fib
move $a0, $v0
li $v0, 1
syscall

# now we will have value of nth fib number in $v0
j exit

fib:
    # check base case
    # $a0 == 1 or $a0 == 2
    li $t4, 1
    li $t5, 2
    beq $a0, $t4, baseCase
    beq $a0, $t5, baseCase

    addi $sp, $sp, -12
    sw $a0, ($sp)
    sw $ra, 4($sp)

    # calling fib(n-1) and fib(n-2)
    addi $a0, $a0, -1 # $a0 = n-1
    jal fib
    move $t0, $v0 # $t0 = fib(n-1)

    # store all variables in a stack which u need after recursion call
    sw $v0, 8($sp)

    # store value of $a0 from stack
    lw $a0, ($sp)
    addi $a0, $a0, -2
    jal fib
    move $t1, $v0 # $t1 = fib(n-2)

    # we need fib(n-1) + fib(n-2) i.e $t0 + $t1
    lw $t0, 8($sp)
    add $t2, $t0, $t1
    lw $ra, 4($sp)
    addi $sp, $sp, 12
    move $v0, $t2
    jr $ra

    baseCase:
        li $v0, 1
        jr $ra

exit:
    li $v0, 10
    syscall

