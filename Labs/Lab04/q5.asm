.data
msg: .asciiz "Enter value for x: \n"
num1: .word 10
num2: .word 20

.text
main:

# loading word from memory to register
lw $t0, num1
lw $t1, num2

# putting values in a floating point register
mtc1 $t0, $f1
mtc1 $t1, $f2

# convert word to single precision
cvt.s.w $f1, $f1
cvt.s.w $f2, $f2

# print msg
la $a0, msg
li $v0, 4
syscall

# take float input
li $v0, 6
syscall

mul.s $f4, $f0, $f1
add.s $f4, $f4, $f2
mov.s $f12, $f4

# printing result
li $v0, 2
syscall

# exit
li $v0, 10
syscall