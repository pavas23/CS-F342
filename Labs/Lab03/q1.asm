# sw and lw

.data
num1: .word 20
num2: .word 10
num3: .word 0

.text
main:

# will load the number from memory to the registers
lw $a0, num1
lw $a1, num2

add $a0, $a0, $a1

# will store the value in $a0 reg in memory location corresponding to num3
sw $a0, num3

lw $a0, num3
li $v0, 1
syscall

li $v0, 10
syscall
