# Convert a positive integer to IEEE format {(-1)^s * (1+f)*(2^E)}

.data 
byte1: .byte 12 

.text
main:

li $a1 10
li $s2 0 #and for mantissa
li $s3 23 
li $t0 0 #counter to give E 
slt $s0 $a1 $0 #check negative
addi $a0 $s0 0 #a0 is IEEE 
sll $a0 $a0 31 
li $v0 1 syscall 
addi $t1 $a1 0 #temp 

loop:
    beq $t1 $0 equal 
    srl $t1 $t1 1 
    addi $t0 $t0 1 
    j loop 

equal:
    addi $t0 $t0 -1 #this gives E
    addi $t4 $t0 127
    sll $t4 $t4 23
    add $a0 $a0 $t4
    addi $t1 $t0 0

getMantissa:
    beq $t1 $0 done
    addi $t1 $t1 -1
    sll $s2 $s2 1
    addi $s2 1
    j getMantissa

done:
    addi $a3 $a1 0
    and $a3 $a3 $s2
    sub $s3 $s3 $t0
    sll $a3 $a3 $s3

    add $a0 $a0 $a3
    addi $a0 $a0 0

li $v0 1
syscall

li $v0 10
syscall
