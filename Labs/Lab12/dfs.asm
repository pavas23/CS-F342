.data
space: .asciiz " " 
newLine: .asciiz "\n"
startNodePrompt : .asciiz "\nEnter the starting Node:\n"

.text
main:
li $v0 5
syscall
move $a0 $v0 
move $a1 $a0    #a1 = node count
addi $a0 $a0 1    
mult $a0 $a0
mflo $a0 
add $a0 $a0 $a0
add $a0 $a0 $a0
li $v0 9
syscall
move $t0 $v0    #base of adj matrix
addi $a0 $a1 1
li $s0 1
li $s1 1

matrixInput: 
    outer: 
        beq $s0 $a0 outerDone
        li $s1 1
        inner: 
            beq $s1 $a0  innerDone
            mult $s0 $a1
            mflo $s2
            add $s2 $s2 $s1 #ni+j
            add $s2 $s2 $s2 
            add $s2 $s2 $s2
            add $s2 $s2 $t0
            li $v0 5
            syscall
            sw $v0 0($s2)
            addi $s1 $s1 1
            j inner
        innerDone: 
        addi $s0 $s0 1
        j outer  
    outerDone:  
        li $s0 1
        li $s1 1
        addi $t1 $a1 1
        li $s0 1

matrixPrint: 
    outerP: 
        beq $s0 $t1 outerDoneP
        li $s1 1
        innerP: 
            beq $s1 $t1  innerDoneP
            mult $s0 $a1
            mflo $s2
            add $s2 $s2 $s1  #ni+j
            add $s2 $s2 $s2 
            add $s2 $s2 $s2
            add $s2 $s2 $t0
            lw $a0 0($s2)
            li $v0 1
            syscall
            la $a0 space
            li $v0 4
            syscall
            addi $s1 $s1 1
            j innerP
        innerDoneP: 
        la $a0 newLine
        li $v0 4
        syscall
        addi $s0 $s0 1
        j outerP  
    outerDoneP:
        la $a0 startNodePrompt
        li $v0 4
        syscall
        li $v0 5
        syscall
        move $t1 $v0    #t1 has starting node
        addi $a0 $a1 1
        li $s5 4
        mult $s5 $a0
        mflo $a0
        li $v0 9 
        syscall
        move $t2 $v0    #t2 has visited array
        li $s0 0

initZero:
    beq $s0 $a0 next
    add $s1 $s0 $t2
    sw $0 0($s1)
    addi $s0 $s0 4
    j initZero

next:
    move $a0 $t1
    addi $sp $sp -8
    sw $a0 0($sp)
    sw $ra 4($sp)
    jal DFS
    #lw $a0 0($sp)
    lw $ra 4($sp)
    addi $sp $sp 8

exit: 
    li $v0 10
    syscall

DFS: #a0 has starting node ,t2 has visited arr base , t0 has adj matrix base
    add $s0 $a0 $a0
    add $s0 $s0 $s0
    add $s0 $s0 $t2
    lw $s1 0($s0)
    li $s5 1
    beq $s1 $s5 return
    li $v0 1
    syscall
    move $s1 $a0
    la $a0 space
    li $v0 4
    syscall 
    move $a0 $s1
    li $s1 1
    sw $s1 0($s0)
    move $s1 $a0
    mult $a0 $a1
    mflo $s1  #ni
    li $s2 1

    loop:
        bgt $s2 $a1 return
        add $s3 $s2 $s1 #ni + j 
        add $s3 $s3 $s3
        add $s3 $s3 $s3
        add $s3 $s3 $t0
        lw $s3 0($s3) #adj[i][j]
        beq $s3 $0 continue
        move $a0 $s2
        addi $sp $sp -16
        sw $a0 0($sp)
        sw $ra 4($sp)
        sw $s2 8($sp)
        sw $s1 12($sp)
        jal DFS
        lw $a0 0($sp)
        lw $ra 4($sp)
        lw $s2 8($sp)
        lw $s1 12($sp)
        addi $sp $sp 16
        
        continue:
            addi $s2 $s2 1
            j loop

    return: jr $ra