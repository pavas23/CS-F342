#format of a node
#base - store the number
#base + 4 - address of the left node
#base + 8 - address of the right node

.data

root: .word 0 0 0 
input: .asciiz "Enter numbers to insert into the bst, press 0 to stop \n"
newline:.asciiz "\n"

.text
main:

la $a0, input
jal print

li $v0, 5
syscall
beq $v0, $zero, end
la $a0, root
sw $v0, 0($a0) #enter the first number into the bst

loop:

	li $v0, 5 #enter the remaining numbers
	syscall
	beq $v0, $zero, end
	# if the remaining part of this loop is executed, it means that this number has to be entered into the bst, so let us create a new node
	move $t0, $v0
	li $a0, 12
	li $v0, 9
	syscall
	sw $t0, 0($v0)
	sw $zero, 4($v0) #left
	sw $zero, 8($v0) #right
	move $a0, $v0
	la $a1, root
	jal insert
	j loop
	
end:

	la $a0, newline
	jal print
	la $a0, root
	lw $t0, 0($a0)
	beq $t0, $zero, finish #if the linked list is empty
	jal height
	move $a0, $v0
	li $v0, 1
	syscall
	finish:
		
		li $v0, 10
		syscall

insert:

	addi $sp, -4
	sw $ra, 0($sp) #return address successfully saved
	#now we will have to compare value stored at a0 with value stored at a1
	#kya mujhe is a1 ki value ko store karke rakhna hoga? mere hisaab se nahi
	lw $t0, 0($a0)
	lw $t1, 0($a1)
	slt $t2, $t0, $t1
	bne $t2, $zero, go_left
	j go_right
	
	return:
		
		lw $ra, 0($sp)
		addi $sp, 4
		jr $ra
		
	go_left:
		
		# ab yahe pe hum check karenge ki agar current ka left null hai, toh a0 ko idhar hi pel do and return
		# warna age call karenge, with address of currents left being loaded into a1
		lw $t3, 4($a1)
		beq $t3, $zero, insert_left
		move $a1, $t3
		jal insert
		j return
		
	go_right:
	
		lw $t3, 8($a1)
		beq $t3, $zero, insert_right
		move $a1, $t3
		jal insert
		j return
		
	insert_left:
	
		sw $a0, 4($a1)
		j return
		
	insert_right:
	
		sw $a0, 8($a1)
		j return
		
height:

	addi $sp, -12
	sw $ra, 4($sp)
	sw $a0, 0($sp)
	lw $t0, 4($a0) #left
	lw $t2, 8($a0)	#right
	sw $zero, 8($sp)
	beq $t0, $t2, base #only in the case that boht of them are null will their addresses be same
	beq $t0, $zero, right
	
	left:
	
		move $a0, $t0
		jal height
		lw $a0, 0($sp)
		lw $t2, 8($a0)
		beq $t2, $zero, fin
		sw $v0, 8($sp)
		
	right:
	
		move $a0, $t2
		jal height
		lw $t0, 8($sp)
		slt $t1, $t0, $v0
		bne $t1, $zero, fin
		move $v0, $t0
		
	fin:
	
		addi $v0, 1
		lw $ra, 4($sp)
		addi $sp, 12
		jr $ra
	
	base:
	
		li $v0, 1
		addi $sp, 12
		jr $ra
		
print:

	li $v0, 4
	syscall
	jr $ra