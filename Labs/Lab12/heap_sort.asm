.data
arr: .word 17 5 92 8741 10 23 55 72 36
space: .asciiz " "

.text
main:

li $t0 9
la $a0 arr
la $s0 arr
li $a1 9

addi $sp $sp -4
sw $ra 0($sp)

jal heapSort

lw $ra 0($sp)
addi $sp $sp 4
move $s7 $t0

la $t0 arr
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

heapSort:
    srl $t1 $a1 1
    makeHeap: blt $t1 $0 sort
        move $a0 $t1  #a0 = i
        addi $sp $sp -12
        sw $a0 0($sp)
        sw $a1 4($sp)
        sw $ra 8($sp)

        # $a0 = i and $a1 = N
        jal heapify

        lw $a0 0($sp)
        lw $a1 4($sp)
        lw $ra 8($sp)
        addi $sp $sp 12
        addi $t1 $t1 -1
        j makeHeap

    sort:
        addi $a0 $a1 -1
        sortLoop:
            blt $a0 $0 done
            lw $s3 0($s0) #arr[0]
            add $s4 $a0 $a0
            add $s4 $s4 $s4
            add $s4 $s4 $s0
            lw $t4 0($s4) #arr[i]
            sw $s3 0($s4)
            sw $t4 0($s0)  #swap arr[i] arr[0]

            addi $sp $sp -12
            sw $a0 0($sp)
            sw $a1 4($sp)
            sw $ra 8($sp)

            move $a1 $a0
            li $a0 0

            jal heapify

            lw $a0 0($sp)
            lw $a1 4($sp)
            lw $ra 8($sp)
            addi $sp $sp 12
            addi $a0 $a0 -1
            j sortLoop
            done: 
                jr $ra

heapify:
        move $t4 $a0
        add $t2 $a0 $a0
        addi $t2 $t2 1 #t2 = 2i + 1 -> left  
        addi $t3 $t2 1 #t3 = 2i +2  -> right
        bge $t2 $a1 notLeft
        add $s2 $t2 $t2
        add $s2 $s2 $s2
        add $s2 $s2 $s0
        lw $s2 0($s2)  #arr[left]
        add $s4 $a0 $a0
        add $s4 $s4 $s4
        add $s4 $s4 $s0
        lw $s4 0($s4) #arr[largest]
        ble $s2 $s4 notLeft
        move $a0 $t2

    notLeft:
        bge $t3 $a1 notRight
        add $s3 $t3 $t3
        add $s3 $s3 $s3
        add $s3 $s3 $s0
        lw $s3 0($s3)  #arr[right]
        add $s4 $a0 $a0
        add $s4 $s4 $s4
        add $s4 $s4 $s0
        lw $s4 0($s4) #arr[largest]
        ble $s3 $s4 notRight
        move $a0 $t3
        
    notRight:
        beq $t4 $a0 returnHeapify
        add $s3 $t4 $t4
        add $s3 $s3 $s3
        add $s3 $s3 $s0
        lw $t5 0($s3)  #arr[i]
        add $s4 $a0 $a0
        add $s4 $s4 $s4
        add $s4 $s4 $s0
        lw $t6 0($s4) #arr[largest]
        sw $t6 0($s3)
        sw $t5 0($s4)

        addi $sp $sp -12
        sw $a0 0($sp)
        sw $a1 4($sp)
        sw $ra 8($sp)

        jal heapify

        lw $a0 0($sp)
        lw $a1 4($sp)
        lw $ra 8($sp)
        addi $sp $sp 12

    returnHeapify: jr $ra



    