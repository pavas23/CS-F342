.data
list: .word 17 5 92 87 41 10 23 55 72 36
space: .asciiz " "

.text
main:
li $s7, 10 # size of input
addi $s3, $s7, -1

la $a0, list # this will contain the base address

outer_loop:
    beq $s3, 0, done
    li $a2, 0 # count
    la $a0, list
    inner_loop:
        beq $a2, $s3, done_inner
        addi $a1, $a0, 4

        # load the curr element
        lw $t0, ($a0)
        # load the next element
        lw $t1, ($a1)

        addi $a2, $a2, 1

        # curr > next, then swap
        bgt $t0, $t1, swap
        addi $a0, $a0, 4
        j inner_loop

        swap:
            sw $t1, ($a0)
            sw $t0, ($a1)
            addi $a0, $a0, 4
            j inner_loop
    
    done_inner:
        addi $s3, $s3, -1
        j outer_loop

done:
    la $a1, list
    li $a2, 0
    print_loop:
        lw $a0, ($a1)
        li $v0, 1
        syscall

        la $a0, space
        li $v0, 4
        syscall

        addi $a1, $a1, 4
        addi $a2, $a2, 1
        beq $a2, $s7, exit
        j print_loop

exit:
    li $v0, 10
    syscall

