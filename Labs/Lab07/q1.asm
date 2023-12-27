.data
msg: .asciiz "The value is: "

.text
main:

la $a1, msg
li $a0, 20 # storing the value in $a0 register
jal increase_value
j exit

increase_value:
    addi $sp, $sp, -8 # 4 bytes for each value, so we go 8 bytes downwards in the stack
    sw $a0, 0($sp)
    sw $ra, 4($sp) # since we are having a nested procedure, which will overwrite the current value of $ra, store the value of $ra in $sp+4

    addi $a0, $a0, 10

    jal print_value # print value is a nested procedure

    lw $a0, 0($sp)
    lw $ra, 4($sp)
    addi $sp, $sp, 8
    jr $ra


print_value:
    addi $sp, $sp, -4
    sw $a0, ($sp)

    # for printing the string
    move $a0, $a1
    li $v0, 4
    syscall

    lw $a0, ($sp)
    li $v0, 1
    syscall

    lw $a0, ($sp)
    addi $sp, $sp, 4

    jr $ra

exit:
    li $v0, 10
    syscall



