# program to take a string from user and print its reverse
.data
str: .space 6
rev: .space 6
msg1: .asciiz "\nThe reverse string is: "

.text
main:

# take string input
la $a0, str
li $a1, 6
li $v0, 8
syscall

# print the string
la $a0, str
li $v0, 4
syscall

# reverse
li $t1, 4
la $t0, str
add $t0,$t0,$t1 # $t0 will point to last char in string
la $t4, str
addi $t4, $t4, -1

la $t2, rev # $t2 is pointing to start loc in rev array


whileloop:
    lb $t3, 0($t0)
    sb $t3, 0($t2)
    addi $t2, $t2, 1 # increment the $t2 pointer for rev string
    addi $t0, $t0, -1 # decrement the $t0 pointer for original string
    beq $t0, $t4 done # if $t0 reaches base address of str, it means we are done
    j whileloop

done:
    # print the rev string
    la $a0, msg1
    li $v0, 4
    syscall
    la $a0, rev
    li $v0, 4
    syscall
    j exit

exit:
    li $v0, 10
    syscall
