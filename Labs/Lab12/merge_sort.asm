.data
arr: .word 17 5 92 8741 10 23 55 72 36
space: .asciiz " "

.text
main:

li $t0 9
li $a0 0
li $a1 8
addi $sp $sp -4
sw $ra 0($sp)
jal mergeSort
lw $ra 0($sp)
addi $sp $sp 4
move $s7 $t0
move $t0 $v0  
li $t2 0

print:
    lw $a0,($t0) #load current word in $a0
    li $v0,1
    syscall #print the current word
    la $a0,space
    li $v0,4
    syscall #print space in b/w words
    addi $t0,$t0,4 #point to next word
    addi $t2,$t2,1 #counter++
    blt $t2,$s7,print

exit:
    li $v0 10
    syscall

mergeSort:
    bge $a0 $a1 baseCase
    addi $sp $sp -16
    sw $a0 0($sp)
    sw $a1 4($sp)
    sw $ra 8($sp)
    add $a1 $a1 $a0
    srl $a1 $a1 1
    jal mergeSort
    lw $a1 4($sp)
    sw $v0 12($sp)
    lw $a0 0($sp)
    add $a0 $a1 $a0
    srl $a0 $a0 1
    addi $a0 $a0 1
    jal mergeSort
    lw $a0 0($sp)
    lw $a1 4($sp)
    lw $ra 8($sp)
    lw $v1 12($sp)
    move $s4 $v1
    move $v1 $v0
    move $v0 $s4
    addi $sp $sp 16
    move $t2 $a0
    move $t3 $a1

    add $a0 $t2 $t3
    srl $a0 $a0 1
    sub $a1 $t3 $a0
    sub $a0 $a0 $t2
    addi $a0 $a0 1
    #merge arrays from $v0 $v1

#$a0 has length of arr in $v0 and $a1 for $v1
li $t2 0
li $t3 0
move $t4 $a0
add $a0 $a0 $a1
add $a0 $a0 $a0
add $a0 $a0 $a0
move $t5 $v0
li $v0 9
syscall
move $s3 $v0 #s3 has new allocated array
move $v0 $t5
move $a0 $t4
move $s4 $s3

merge: 
    beq $t2 $a0 nextV1
    beq $t3 $a1 nextV0
    add $s0 $t2 $t2
    add $s0 $s0 $s0
    add $s0 $s0 $v0
    add $s1 $t3 $t3
    add $s1 $s1 $s1
    add $s1 $s1 $v1
    lw $s0 0($s0)
    lw $s1 0($s1)
    ble $s0 $s1 addV0
    sw $s1 0($s3)
    addi $s3 $s3 4
    addi $t3 $t3 1
    j merge

addV0:
    sw $s0 0($s3)
    addi $s3 $s3 4
    addi $t2 $t2 1

j merge

nextV0:
    beq $t2 $a0 over
    add $s0 $t2 $t2
    add $s0 $s0 $s0
    add $s0 $s0 $v0
    lw $s0 0($s0)
    sw $s0 0($s3)
    addi $s3 $s3 4
    addi $t2 $t2 1
    j nextV0

nextV1:
    beq $t3 $a1 over
    add $s1 $t3 $t3
    add $s1 $s1 $s1
    add $s1 $s1 $v1
    lw $s1 0($s1)
    sw $s1 0($s3)
    addi $s3 $s3 4
    addi $t3 $t3 1
    j nextV1

over: 
    move $v0 $s4
    jr $ra

baseCase:
    la $t1 arr
    add $a0 $a0 $a0
    add $a0 $a0 $a0
    add $a0 $t1 $a0
    lw $t1 0($a0)
    li $a0 4
    li $v0 9
    syscall
    sw $t1 0($v0)
    jr $ra
    
