# Write a function to count the number of vowels in a given string and also return
# the string after removing the vowels and print that string in main function. Call the function
# twice with two different strings

.data

string: .asciiz "hellohowareyoudoingtoday"
removed: .asciiz "Letters removed: "
size: .word 24
vowels: .asciiz "aeiou"
endline: .asciiz "\n"

.text
main:
	# print original string
    la $a0, string
	li $v0, 4
	syscall

	la $a0, endline
    li $v0, 4
	syscall

	la $a0, string
	jal remove_vowels

	move $a1, $v0

	la $a0, removed
    li $v0, 4
	syscall

	# print number of removed letters
	move $a0, $a1
	li $v0, 1
	syscall

	# print modified string
	la $a0, endline
    li $v0, 4
	syscall

	la $a0, string
    li $v0, 4
	syscall

	li $v0, 10
	syscall

remove_vowels:
li $v0, 0
la $a0, string

check_letter:
	lb $a1, ($a0) # current_letter
	beq $a1, $zero, exit

	la $t1, vowels # string of vowels

	check_vowel:
		lb $t2, ($t1)
		beq $t2, $zero, end_vowel_loop
		beq $t2, $a1, remove_letter
		addi $t1, $t1, 1
		j check_vowel
		remove_letter: 
			addi $v0, $v0, 1
			move $t3, $a0
			move $t4, $a0
			addi $t4, $t4, 1
			remove_loop:
				lb $t5, ($t4)
				lb $t6, ($t3)
				beq $t6, $zero, end_remove_loop
				sb $t5, ($t3)
				addi $t4, $t4, 1
				addi $t3, $t3, 1
				j remove_loop
			end_remove_loop: addi $a0, $a0, -1
	end_vowel_loop: addi $a0, $a0, 1
	j check_letter

exit:
	jr $ra



