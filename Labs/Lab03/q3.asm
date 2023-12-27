# Take an integer length and a string as input, the string should be truncated at 
# the input length, then print this string. Note: this length includes the null 
# character.

.data
str: .asciiz " "
msg1: .asciiz "Enter length of string: "
msg2: .asciiz "\nEnter string: "
msg3: .asciiz "\nYou entered string: "

.text
main:
 
# print msg1
la $a0, msg1
li $v0, 4
syscall

# take length as input
li $v0, 5
syscall
move $t0, $v0

# print msg2
la $a0, msg2
li $v0, 4
syscall

# take input string
# for taking string input, $a0 should have the memory address where string is to be stored, and $a1 should contain the length of the string to be taken as input
la $a0, str
move $a1, $t0
li $v0, 8 
# this will take input from user only till $a1 length which is including the null character '\0', if length is 5 and i enter hello, it will read hell and put '\0' at the end
syscall

move $a2, $a0 # now $a2 will have base address of string

# print msg3
la $a0, msg3
li $v0, 4
syscall

# printing the string
la $a0, str
li $v0, 4
syscall

# exit
li $v0, 10
syscall
