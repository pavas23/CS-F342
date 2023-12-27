.data
queue: .space 400
space: .asciiz " " 
newLine: .asciiz "\n"
startNodePrompt: .asciiz "\nEnter the starting Node:\n"
noOfNodes: .asciiz "\nEnter Number of nodes:\n"

.text
main:

la $a0 noOfNodes
li $v0 4
syscall
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
            add $s2 $s2 $s1  #ni+j
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
    la $t3 queue    #has queue
    li $t4 -1   #has front
    li $t5 -1   #has back
    move $a0 $t1
    addi $sp $sp -4
    sw $ra 0($sp)
    jal pushQ   #push first element
    lw $ra 0($sp)
    addi $sp $sp 4

startBFS:
    beq $t5 $t4 exit
    addi $sp $sp -4
    sw $ra 0($sp)
    jal popQ
    lw $ra 0($sp)
    addi $sp $sp 4
    move $a0 $v0
    li $v0 1
    syscall
    move $s0 $a0
    la $a0 space
    li $v0 4
    syscall
    move $a0 $s0
    add $s0 $s0 $s0 
    add $s0 $s0 $s0 
    add $s0 $t2 $s0
    li $s1 1
    sw $s1 0($s0)   #vis[node] = 1
    mult $a1 $a0
    mflo $s0
    li $s1 1
    
    addNeighbour:
        bgt $s1 $a1 nextNode
        add $s2 $s1 $s0
        add $s2 $s2 $s2
        add $s2 $s2 $s2
        add $s2 $t0 $s2
        lw $s2 0($s2)
        beq $s2 $0 continue
        move $s4 $s1
        add $s4 $s4 $s4
        add $s4 $s4 $s4
        add $s4 $s4 $t2
        lw $s4 0($s4)
        bne $s4 $0 continue #check for visited
        move $a0 $s1
        addi $sp $sp -4
        sw $ra 0($sp)
        jal pushQ   #push neighbour
        lw $ra 0($sp)
        addi $sp $sp 4
        continue:
            addi $s1 $s1 1
            j addNeighbour
    nextNode: 
        j startBFS
exit:
    li $v0 10
    syscall

pushQ:
    li $s4 -1
    bne $t4 $s4 notemptyQPush
    li $t4 0
    li $t5 0
    notemptyQPush:
    add $s4 $t5 $t3
    sw $a0 0($s4)
    add $t5 $t5 4
    jr $ra

popQ:
    beq $t4 $t5 emptyQpop
    add $s4 $t3 $t4
    lw $v0 0($s4)
    addi $t4 $t4 4
    jr $ra
    emptyQpop:
    li $t4 -1
    li $t5 -1
    jr $ra
    