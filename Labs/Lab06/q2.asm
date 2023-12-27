.data
array: .byte 'a', 'b', 'c', 'd', 'e', 'f'
len: .word 6
character: .byte 'g'
msg1: .asciiz "\nCharacter found in array: \n"
msg2: .asciiz "\nCharacter not found in array \n"

.text
main:

la $t0, array
lb $t2, character
lb $t4, len
li $t5, 0

loop:
    lb $t1, 0($t0)
    # beq $t5, $t4 notFound
    beq $t1, $zero, notFound
    beq $t1, $t2, found
    addi $t0, $t0, 1
    addi $t5, $t5, 1
    j loop

notFound:
    la $a0, msg2
    li $v0, 4
    syscall
    j exit

found:
    la $a0, msg1
    li $v0, 4
    syscall
    j exit

exit:
li $v0, 10
syscall




