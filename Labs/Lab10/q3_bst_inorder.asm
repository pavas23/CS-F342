# BST in MIPS !!
.data
root: .word 0 0 0 # predefining root as NULL
space: .asciiz "\t"
input: .asciiz "Enter numbers to enter in binary search tree (0 to stop)\n"
output: .asciiz "Inorder traversal of binary search tree is:\n"

.text
main:

la $a0, input
li $v0, 4
syscall

li $v0, 5
syscall

beqz $v0, end_of_loop1 # to check if last input is 0
la $a0, root # loading address of root into $a0 for inserting values in BST

sw $v0, ($a0)
loop1:
    li $v0, 5
    syscall
    beqz $v0, end_of_loop1

    # storing value of $a0, as it is needed after this call
    addi $sp, $sp, -4
    sw $a0, ($sp)

    move $a1, $v0

    # so insert function takes current root address in $a0, and value to be inserted in $a1
    jal insert # calling subroutine to insert into BST

    # storing again value of base address of root
    lw $a0, ($sp)
    addi $sp, $sp, 4

    j loop1

end_of_loop1:
    la $a0, output
    li $v0, 4
    syscall

# performing inorder traversal
la $a0, root
jal inorder

# exiting the program
li $v0, 10
syscall

# function to recursively insert in BST
insert:
    move $t0, $a1 # $t0 -> val
    move $t1, $a0 # $t1 -> root address

    li $a0, 12 # to allocate 12 bytes, i.e for 3 integers, val, left_address, right_address
    li $v0, 9
    syscall

    sw $t0, ($v0)   # store val in newly created node
    sw $0, 4($v0)   # set left pointer to NULL
    sw $0, 8($v0)   # set right pointer to NULL

    move $a0, $t1
    # now we need to think if this node comes on left or right side of root
    lw $a1, ($a0) # root value is in $a1

    ble $t0, $a1, insert_left

    insert_right:
        # check if root->right == NULL
        addi $a0, $a0, 8
        lw $t1, ($a0)
        bne $t1, 0, root_right_not_null
        # insert on right of root
        sw $v0, ($a0)
        jr $ra
        root_right_not_null:
            # pass argument to this function as base address of root->right child
            move $a0, $t1
            move $a1, $t0

            # storing $ra in stack
            addi $sp, $sp, -8
            sw $ra, ($sp)
            sw $a0, 4($sp)

            jal insert # it will recursively insert in right-subtree

            # returning back
            lw $ra, ($sp)
            lw $a0, 4($sp)
            addi $sp, $sp, 8
            jr $ra

    insert_left:
        # check if root->left == NULL
        addi $a0, $a0, 4
        lw $t1, ($a0)
        bne $t1, 0, root_left_not_null
        # insert on left of root
        sw $v0, ($a0)
        jr $ra
        root_left_not_null:
            # pass argument to this function as base address of root->left child
            # now $t1, contains address of left child of root
            move $a0, $t1
            move $a1, $t0

            # storing $ra in stack
            addi $sp, $sp, -8
            sw $ra, ($sp)
            sw $a0, 4($sp)

            jal insert # it will recursively insert in left-subtree

            # returning back
            lw $ra, ($sp)
            lw $a0, 4($sp)
            addi $sp, $sp, 8
            jr $ra


# function for inorder traversal of BST
inorder:
    # check if current root is NULL or not
    beqz $a0, end_of_inorder # checking if base address is pointing to 0 or not

    addi $sp, $sp, -8
    sw $a0, ($sp)
    sw $ra, 4($sp)

    # left subtree
    # put left subtree root in $a0 register
    addi $a0, $a0, 4
    lw $t0, ($a0)
    move $a0, $t0
    jal inorder

    # print root
    lw $a0, ($sp)
    lw $t4, ($a0)
    move $a0, $t4
    li $v0, 1
    syscall

    la $a0, space
    li $v0, 4
    syscall

    # right subtree
    lw $a0, ($sp)
    addi $a0, $a0, 8
    lw $t0, ($a0)
    move $a0, $t0
    jal inorder

    # return back
    lw $ra, 4($sp)
    addi $sp, $sp, 8
    jr $ra

    end_of_inorder:
        jr $ra
