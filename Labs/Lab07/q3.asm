# printing stars

.data
msg: .asciiz "Enter Number of lines\n"
star: .asciiz "*"
end_line: .asciiz "\n"

.text
main:

# take number of lines from user
la $a0, msg
li $v0, 4
syscall

li $v0, 5
syscall
move $a0, $v0

jal print_pattern
j exit

print_pattern:
    # initially number of stars is 1
    li $t0, 1
    addi $sp, $sp, -8
    sw $a0, ($sp)
    sw $ra, 4($sp)

    # calling helper function for each row
    print_loop:
        # place the arguments in $a1
        move $a1, $t0
        jal print_line

        # replace $a0 with original value stored in stack
        lw $a0, ($sp)

        # increment $t0
        beq $t0, $a0, done
        addi $t0, $t0, 1
        j print_loop
        done:
            lw $ra, 4($sp)
            addi $sp, $sp, 8
            jr $ra


print_line:
    move $t2, $a1
    # now $t2 contains number of stars in that line
    li $t3, 0
    for_loop:
        beq $t2, $t3, return_back
        
        # printing each star
        la $a0, star
        li $v0, 4
        syscall

        addi $t3, $t3, 1
        j for_loop

        return_back:
            # adding '\n' at end
            la $a0, end_line
            li $v0, 4
            syscall

            jr $ra


exit:
li $v0, 10
syscall
