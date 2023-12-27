.data
list: .float 17.34 5.231 92.234 87.23 41.213 10.213 232.12 55.213 72.353 36.0324
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
        l.s $f0, ($a0)
        # load the next element
        l.s $f1, ($a1)

        addi $a2, $a2, 1

        # curr > next, then swap
        c.le.s $f0, $f1
        bc1f swap
        addi $a0, $a0, 4
        j inner_loop

        swap:
            s.s $f1, ($a0)
            s.s $f0, ($a1)
            addi $a0, $a0, 4
            j inner_loop
    
    done_inner:
        addi $s3, $s3, -1
        j outer_loop

done:
    la $a1, list
    li $a2, 0
    print_loop:
        # storing single precision value in $f0 register
        l.s $f12, ($a1)
        li $v0, 2 # for printing single precision value
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

