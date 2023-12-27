.data
array: .word 1 10 15 -3 456 -876 34 12 66 9 100 112
len: .word 12
msg1: .asciiz "\nThe max element is: "
msg2: .asciiz "\nThe min element is: "

.text
main:
la $t0, array
lw $t1, len # $t1 will store the len of array

lw $t4, 0($t0) # for max ele

# counter
li $t5,0
add $t8, $zero, $t0 # $to will point to current ele

loop:
    beq $t5, $t1, done # if counter reaches the len
    lw $t6, 0($t8)
    blt $t6, $t4 greater
    j after
    greater:
    move $t4, $t6
    after:
    addi $t5, $t5, 1
    addi $t8, $t8, 4
    j loop

done:
    # print msg1
    la $a0, msg1
    li $v0, 4
    syscall

    # print max ele
    move $a0, $t4
    li $v0, 1
    syscall

exit:
    li $v0, 10
    syscall



