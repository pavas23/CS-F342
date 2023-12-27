.data

.text
main:

li $a0, 4
srl $v0, $a0, 31
move $a1, $v0

li $v0, 10
syscall

