# CS-F342

3-1, Computer Architecture course at BITS Pilani, Hyderabad Campus

## Topics Covered
  - Computer Abstractions and Technology
  - MIPS Architecture & Instruction Set
  - Arithmetic for computers - floating point arithmetic
  - Role of Performance, pipelining – design issues
  - Pipelined data path and control
  - Various types of hazards
  - Branch prediction techniques
  - Exploiting memory hierarchy
  - Cache Memory Organization
  - Measuring and improving cache performance, cache optimization
  - Main Memory and Interleaving
  - Virtual Memory and Virtual Machines
  - I/O performance measures, Redundant Array of Independent Disks

## MIPS Assembly Language

  - Using ```QtSpim```, this course studied ```MIPS assembly language```. Topics included initialising variables, accepting user input, addition, and a rudimentary understanding of binary analysis of MIPS architecture instructions. Logic and shift operations, branch and jump instructions, and ```floating point instructions``` were also discussed.
  
  - Additionally, we discussed loops, arrays, load/store instructions, and string manipulation. We looked into functions and recursion in MIPS further. We also comprehended ```memory allocation using system calls``` and the mapping of structures.
  
  - Then, we used MIPS to implement several ```sorting algorithms```, including bubble sort, merge sort, heap sort, etc. Additionally, we wrote MIPS Assembly language code for ```graph algorithms``` like bfs and dfs.

## Important Notes

#### Functions
```c
$a0,$a1,$a2 // are used for passing parameters to functions
$v0 $v1 // are used to return values
$sp // is stack pointer
```

#### Structure in MIPS

```c
typedef struct node{
  int val; //value of this node
  struct node * left; //pointer to left child
  struct node* right; //pointer to right child
} nodeType;
```

#### C equivalent

```c
// a, b, c, ptr are analogous to values of $s0, $s1, $s2, $v0 respectively.

node* ptr = (node*)malloc(sizeof(node));

ptr->val = a; // $s0 has the value
ptr->left = b; // $s1 has left pointer
ptr->right = c; // $s2 has right pointer

a = ptr->val;
b= ptr->left;
c = ptr->right;
```

#### MIPS assembly
```c
// After syscall, $v0 points to 12 bytes of free memory (newly allocated)

li $a0,12 //bytes to be allocated
li $v0,9 //sbrk code is 9
syscall //now $v0 holds the address of first byte of 12 bytes of free memory

sw $s0, 0($v0)
sw $s1, 4($v0)
sw $s2, 8($v0)

lw $s0, 0($v0)
lw $s1, 4($v0)
lw $s2, 8($v0)
```


### Lab Summary

| Lab | Topic | Lab Sheet | Date |
| ------------- | ------------- | --- | -- |
| 1  | Installation and execution of QTSPIM software for MIPS | [Lab 1](https://github.com/pavas23/CS-F342/blob/main/Labs/Lab01/LabSheet1.pdf) | 31 Jan 2023 |
| 2  | The basic program in MIPS (initializing variable, take input from user, addition) | [Lab 2](https://github.com/pavas23/CS-F342/blob/main/Labs/Lab02/LabSheet2.pdf) | 07 Feb 2023 |
| 3  | Storing and loading to and from memory, Use of mfhi and mflo registers, and arithmetic instructions | [Lab 3](https://github.com/pavas23/CS-F342/blob/main/Labs/Lab03/LabSheet3.pdf) | 14 Feb 2023 |
| 4  | Explore floating point instructions | [Lab 4](https://github.com/pavas23/CS-F342/blob/main/Labs/Lab04/LabSheet4.pdf) | 21 Feb 2023 |
| 5  | Branch instructions, jump instructions and logical and shift operations | [Lab 5](https://github.com/pavas23/CS-F342/tree/main/Labs/Lab05) | 28 Feb 2023 |
| 6  | Loops, arrays and string manipulations | [Lab 6](https://github.com/pavas23/CS-F342/blob/main/Labs/Lab06/LabSheet6.pdf) | 07 Mar 2023 |
| 7  | Explore basics of functions and recursion | [Lab 7](https://github.com/pavas23/CS-F342/blob/main/Labs/Lab07/LabSheet7.pdf) | 28 Mar 2023 |
| 8  | Exception mechanism in MIPS | [Lab 8](https://github.com/pavas23/CS-F342/blob/main/Labs/Lab08/LabSheet8.pdf) | 11 Apr 2023 |
| 9  | Understanding the pipelining in MIPS | [Lab 9](https://github.com/pavas23/CS-F342/blob/main/Labs/Lab09/LabSheet9.pdf) | 18 Apr 2023 |
| 10  | Memory allocation using system calls | [Lab 10](https://github.com/pavas23/CS-F342/tree/main/Labs/Lab10) | 25 Apr 2023 |
| 11  | Exploring sorting techniques using MIPS | [Lab 11](https://github.com/pavas23/CS-F342/blob/main/Labs/Lab11/LabSheet11.pdf) | 25 Apr 2023 |
| 12  | Graph Algorithms using MIPS | [Lab 12](https://github.com/pavas23/CS-F342/blob/main/Labs/Lab12/LabSheet12.pdf) | 25 Apr 2023 |
