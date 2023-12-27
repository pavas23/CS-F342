# to check if a string is a palindrome or not

.data
msg1: .asciiz "Enter the input string: "
msg2: .asciiz "The string is a palindrome: "
msg3: .asciiz "The string is not a palindrome: "
str:  .space 50

.text
main:

# print msg1
la $a0, msg1
li $v0, 4
syscall

# assigning $a1 as length of string, and $a0 will point to base address of array
li $a1, 50
la $a0, str
li $v0, 8
syscall

# $t0 is pointing to start of the string
move $t0, $a0

# printing the input string
la $a0, str
li $v0, 4
syscall

add $t1, $zero, $t0
incrementPtr:
    addi $t1, $t1, 1
    lb $t2, 0($t1)
    beqz $t2, lastIndex
    j incrementPtr

lastIndex:
    # now $t1 is pointing towards the '\0' character, but we have entered a '\n' char also, so last char will be at $t1-1
    sub $t1, $t1, 2
    j checkPalindrome

checkPalindrome:
    bge $t0, $t1 done
    lb $t3, 0($t0)
    lb $t4, 0($t1)
    bne $t3, $t4, notPalindrome
    addi $t0, $t0, 1
    addi $t1, $t1, -1
    j checkPalindrome

notPalindrome:
    # string is not a palindrome
    la $a0, msg3
    li $v0, 4
    syscall
    j exit

done:
    # string is a palindrome
    la $a0, msg2
    li $v0, 4
    syscall
    j exit

exit:
    li $v0, 10
    syscall
