# given two linear equations find the values for x and y
# ax+by = c
# dx+ey = f
# y = (cd-ef)/(bd-ea)
# x = (ce-fb)/(ae-db)

.data
msg1: .asciiz "\nThe value of Y is: "
msg2: .asciiz "\nThe value of X is: "

.text
main:

# storing the values for a,b,c,d,e,f
li $t0, 3 # a
li $t1, 5 # b
li $t2, 31 # c
li $t3, 4 # d
li $t4, 3 # e
li $t5, 23 # f

# mult c*d
mult $t2, $t3
mflo $a1

# mult e*f
mult $t4, $t5
mflo $a2

# cd-ef
sub $t6, $a1, $a2

# mult b*d
mult $t1, $t3
mflo $a1

# mult e*a
mult $t4, $t0
mflo $a2

# bd-ea
sub $t7, $a1, $a2

# (cd-ef)/(bd-ea)
div $t6, $t7
mflo $a1 # quotient will be stored in $a1

# print msg1
la $a0, msg1
li $v0, 4
syscall

# printing value of y
addi $a0, $a1, 0
li $v0, 1
syscall

# mult c*e
mult $t2, $t4
mflo $a1

# mult f*b
mult $t5, $t1
mflo $a2

# ce-fb
sub $t8, $a1, $a2

# mult a*e
mult $t0, $t4
mflo $a1

# mult d*b
mult $t3, $t1
mflo $a2

# ae-db
sub $t9, $a1, $a2

# (ce-fb)/(ae-db)
div $t8, $t9
mflo $a1

# print msg2
la $a0, msg2
li $v0, 4
syscall

# printing value of x
move $a0, $a1
li $v0, 1
syscall

# exiting the program
li $v0, 10
syscall




