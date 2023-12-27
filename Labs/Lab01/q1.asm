# program for taking two numbers as input and printing the output

.data
msg1: .asciiz "Enter first number: "
msg2: .asciiz "Enter second number: "
msg3: .asciiz "The sum of two numbers is: "

.text
main:
	# to print the string, load the address in $a0 and then print 
	la $a0, msg1
	li $v0, 4
	syscall

	# to read int, and value is stored in $v0
	li $v0, 5
	syscall
	move $t0, $v0

	# to print the second string
	la $a0, msg2
	li $v0, 4
	syscall

	# for reading second integer
	li $v0, 5
	syscall
	move $t1, $v0

	# for printing the message
	la $a0, msg3
	li $v0, 4
	syscall

	# for adding the numbers
	add $a0, $t0, $t1
	
	# to print integer
	li $v0, 1
	syscall

	# to exit the program
	li $v0, 10
	syscall

	