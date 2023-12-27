# print value of 22/7 in single and double precision

.data
msg1: .asciiz "The value of pi in single precision is: "
msg2: .asciiz "\nThe value of pi in double precision is: "

.text
main:

# put values in temp registers
li $t0, 22
li $t1, 7

# print msg1
la $a0, msg1
li $v0, 4
syscall

# move values to floating point registers before performing any operation on them
mtc1 $t0, $f14
mtc1 $t1, $f16

# convert values from int to single precision values
cvt.s.w $f14, $f14
cvt.s.w $f16, $f16

# div now
div.s $f12, $f14, $f16

# print the value
li $v0, 2
syscall

# print msg2
la $a0, msg2
li $v0, 4
syscall

cvt.d.s $f14, $f14
cvt.d.s $f16, $f16

# div now
div.d $f12, $f14, $f16

# print the value
li $v0, 3
syscall

# exit
li $v0, 10
syscall
