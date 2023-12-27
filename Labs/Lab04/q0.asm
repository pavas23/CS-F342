# Floating point numbers and instructions: Floating point numbers are used to describe real numbers to some degree of precision. 32-bits (single precision/4-bytes) or 64-bits (double precision/8-bytes) are used to represent floats.

# Floating-point numbers are represented as a*(10^b) Floating point registers and the instructions that operate on them are on a separate chip referred to as coprocessor 1.

# Uses special registers $f0-$f31 Each reg is used for single precision and 2 reg together are used for double precision.

# For double precision: $f0 $f1 are used together. Therefore 32 single precision and 16 double precision are available.

# Load and store float from memory:

# (use lwc1 type instr for QTSpim) #single precision lwc1 $f0, 0($t0) l.s $f0, 0($t0) ( 0($t0) -> t0 has base addr and the number after that is shift from t0)

# swc1 $f0 , 0($t0) s.s $f0, 0($t0)

# #double precision ldc1 $f0, 0($t0) l.d $f0, 0($t0)

# sdc1 $f0 , 0($t0) s.d $f0 , 0($t0)

# Usually .s after instructions for single precision and .d for double precision.

# Load immediate (pseudo instruction):

# li.s $f0, 0.5 li.d $f0 , 0.5 To use any floating point operation on 2 non floating point numbers we need to shift the numbers to floating point registers.

# FLOPS: Floating point operations per second (rate) FLOPs: Floating point operations (number)

# Print floating point:

# li $vo ,2(single) /3 (double) li.s/d $f12 , 0.5 syscall

# Read floating point:

# li $v0, 6(single)/7(double) syscall (read will be stored in $f0)

# mov.s and mov.d is only between 2 floating point registers mfc1 $t0, $f0 is from floating point to normal register mtc1 $t0 , $f0 is from normal register to floating point register.

# cvt.s.w $f0,$f1 -> convert 32 bits in f1 to float and store in f0 cvt .w.s $f0 $f1 -> convert float in f1 to integer and store in f0

