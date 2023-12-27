.data
# to make an array of integers between 0 and 1000
array: .word 5 4 3 2 1
space: .asciiz " "
size: .word 5

.text
main:

la $t0, array
lw $t1, size # n
li $t2, 1 # c

loop:
    beq $t2, $t1, done
    move $t3, $t2  # c -> d
    inner_loop:
        bgt $t3, 0, cond
        addi $t2, $t2, 1
        j loop # d == 0
        cond:
            move $t4, $t3
            li $t5, 4
            mul $t4, $t4, $t5
            add $t4, $t0, $t4

            lw $a0, ($t4)  # arr[d]
            addi $t4, $t4, -4
            lw $a1, ($t4) # arr[d-1]
            blt $a0, $a1, swap
            addi $t2, $t2, 1
            j loop # arr[d] >= arr[d-1]
            swap:
                # d < 0 && arr[d] < arr[d-1]
                sw $a0, ($t4) # arr[d-1] = arr[d]
                addi $t4, $t4, 4
                sw $a1, ($t4) # arr[d] = arr[d-1]
                addi $t3, $t3, -1 # d--
                j inner_loop

done:
    la $t0, array
    li $t2, 0
    print_loop:
        lw $a0, ($t0)
        li $v0, 1
        syscall

        la $a0, space
        li $v0, 4
        syscall

        addi $t0, $t0, 4
        addi $t2, $t2, 1

        beq $t2, $t1, exit
        j print_loop

exit:
    li $v0, 10
    syscall
