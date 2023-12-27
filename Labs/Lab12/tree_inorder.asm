.data
array: .word 1 2 3 4 -1 5 6
space: .asciiz " "
msg: .asciiz "Inorder traversal is: \n"

.text
main:

la $a0, array
move $s0, $a0 # s0 has base of array
li $a1, 7

li $a0, 0 # 0th index
addi $sp, $sp, -4
sw $ra, ($sp)

# a0 has ith index
jal inorder_tree

lw $ra, ($sp)
addi $sp, $sp, 4
j exit

inorder_tree:
    # check if node is NULL or not i.e -1
    # $a0, has ith index
    move $s1, $a0 # now $s1 has ith index
    add $a0, $a0, $a0
    add $a0, $a0, $a0
    add $a0, $s0, $a0
    lw $t1, ($a0)
    beq $t1, -1, nullNode

    add $sp, $sp, -12
    sw $s1, ($sp)
    sw $t1, 4($sp)
    sw $ra, 8($sp)

    # left index
    add $s1, $s1, $s1 # 2*i
    addi $s1, $s1, 1
    # now $s1 has left child index
    move $a0, $s1
    # check if left index < 6
    bge $a0, $a1, leftchilddoesntexist
    jal inorder_tree

    leftchilddoesntexist:
    # right index
    lw $s1, ($sp)
    add $s1, $s1, $s1
    addi $s1, $s1, 2
    move $a0, $s1
    bge $a0, $a1, rightchilddoesntexist
    jal inorder_tree

    rightchilddoesntexist:
    lw $t1, 4($sp)
    # $t1 has value of ith node
    move $a0, $t1
    li $v0, 1
    syscall

    la $a0, space
    li $v0, 4
    syscall
    lw $a0, ($sp)
    lw $ra, 8($sp)
    addi $sp, $sp, 12
    jr $ra

    nullNode:
        jr $ra

exit:
    li $v0, 10
    syscall

