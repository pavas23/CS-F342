# find factorial of a given integer recursively
.data
msg: .asciiz "Enter the number n \n"

.text
main:

# taking input for number n
la $a0, msg
li $v0, 4
syscall

li $v0, 5
syscall

move $a0, $v0
jal find_factorial

# now we will have factorial value in $v0
move $a0, $v0
li $v0, 1
syscall
j exit

find_factorial:
    # now we have our n value in $a0 register
    # check base case
    beq $a0, $zero, baseCase

    addi $sp, $sp, -8
    sw $a0, ($sp)
    sw $ra, 4($sp)

    # doing n as n-1
    addi $a0, $a0, -1

    jal find_factorial

    # now we will have our value of fact(n-1) in $v0
    move $t1, $v0
    lw $t2, ($sp)

    # now find n*fact(n-1) i.e $t2 * $t1
    mul $t3, $t1, $t2

    # now we need to return
    lw $ra, 4($sp)
    move $v0, $t3
    addi $sp, $sp, 8
    jr $ra

    baseCase:  
        li $v0, 1
        jr $ra

exit:
    li $v0, 10
    syscall


