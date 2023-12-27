.data
msg1: .asciiz "Enter length of number\n"
msg2: .asciiz "Enter number\n"
msg3: .asciiz "\nArmstrong number\n"
msg4: .asciiz "\nNot Armstrong number\n"
str: .space 40

.text
main:

li $t6, 153

la $a0, msg1
li $v0, 4
syscall

li $v0, 5
syscall
move $t0, $v0 # $t0 -> n

la $a0, msg2
li $v0, 4
syscall

# read number as string
li $a1, 10
la $a0, str
li $v0, 8
syscall

move $t1, $a0 # base address of number
li $t2, 0 # position

move $a0, $t0
move $a1, $t1
move $a2, $t2

jal find_ans

# now we will have new number in $v0
move $a0, $v0
# print the value returned
li $v0, 1
syscall

# number to be checked
li $t6,1634 
beq $a0, $t6, equal

# not equal
la $a0, msg4
li $v0, 4
syscall
j exit

equal:
    la $a0, msg3
    li $v0, 4
    syscall
    j exit

find_ans:
    # $a0 -> n, and $a1 -> base address of number, $a2 -> position
    # baseCase
    addi $t3, $a0, -1 # $t3 -> n-1
    beq $a2, $t3, baseCase

    addi $sp, $sp, -20
    sw $a0, ($sp)
    sw $a1, 4($sp)
    sw $a2, 8($sp)
    sw $ra, 12($sp)

    # increment the position
    addi $a2, $a2, 1
    jal find_ans
    # now ans is in $v0

    # find sum
    sw $v0, 16($sp)

    # find power of curr pos
    lw $a2, 8($sp)
    lw $a1, 4($sp)
    add $t4, $a1, $a2
    lb $t5, ($t4)
    addi $t5, $t5, -48
    move $a0, $t5
    lw $t6, ($sp)
    move $a1, $t6
    jal find_power

    # now ans is in $v0
    lw $t1, 16($sp)
    add $t2, $t1, $v0
    move $v0, $t2
    lw $ra, 12($sp)
    addi $sp, $sp, 20
    jr $ra

    baseCase:
        addi $sp, $sp, -4
        sw $ra, ($sp)

        add $t4, $a1, $a2
        lb $t5, ($t4)
        addi $t5, $t5, -48
        move $a0, $t5
        move $a1, $t0
        jal find_power

        move $v0, $v0

        lw $ra, ($sp)
        addi $sp, $sp, 4
        jr $ra

find_power:
    # now $a0 will have x and $a1 will have p
    li $t4, 1
    move $t5, $a0

    while_loop:
        beq $t4, $a1, done
        mul $t5, $t5, $a0
        addi $t4, $t4, 1
        j while_loop

    done:
        move $v0, $t5
        jr $ra

exit:
    li $v0, 10
    syscall

