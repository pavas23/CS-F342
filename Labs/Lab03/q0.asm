# Branching:

# Conditional branch: beq -> branch if equal (==)(I-type) bne -> branch if not equal (!=)(I-type)

# Unconditional Branch: j -> jump (J-type)

# jr -> jump register (R-type) jal -> jump and link (J-type) Eg.

# beq $s0 $s1 target #if s1==s0 then go to label “target” #any code after the beq wont we executed as it directly jumps to target target:

# add $s1 $s1 $s0

# C-code to MIPS

# C:
# if(i==j) f = g+h;
# f=f-i;

# MIPS:
# #S0 = f, s1 =g, s2 = h, s3=i,s4=j
# bne $s3 $s4 L1
# add $s0 $s1 $s2
# L1:
#     sub $s0 $s0 $s3

# C:
# if(i==j) f = g+h;
# else f=f-i;

# MIPS:
# #S0 = f, s1 =g, s2 = h, s3=i,s4=j
# bne $s3 $s4 L1
# add $s0 $s1 $s2
# j done 
# L1: 
#     sub $s0 $s0 $s3
# done:

# C:
# int pow = 1;
# int x= 0;
# while(pow!=128){
#     pow = pow*2;
#     x = x+1;
# } 

# MIPS:
# S0 = pow s1 = x
# addi $s0 $0 1
# add $s1 $0 $0
# addi $t0 $0 128
# while: 
#     add $s0 $s0 $s0
#     addi $s1 $s1 1
#     bne $s0 $t0 while

    