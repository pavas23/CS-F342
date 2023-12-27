# .word : 32-bit quantities in successive memory words
# .half : 16-bit quantities in successive memory half-word
# .byte : 8-bit quantities in successive memory bytes
# .ascii str : store string in memory but do not null terminate it

# Strings are represented by in double quotes str

# Special characters like \n \t follow C convention.

# .asciiz str : store the string in memory and null terminate it 
# .float f1,...fn : store n floating point single precision numbers in successive memory 
# .double d1,...dn: store n floating point double precision number in successive memory locations. 
# .space n : reserves n successive bytes of space.

# Layout of code in QTSPIM

# .data -> variable declaration follows this line
# main: -> entry point of program

# When two registers are multiplied together, the overflow will be stored in the HI register and the actual value (without the overflow) is stored in the LO register.

# When two registers are divided the quotient is stored in the LO register and the remainder is stored in the HI register.

# Mult <reg> <reg> -> multiply Div <reg1> <reg2> -> divide reg1 by reg2.

# Mflo <reg> -> move from lo to reg.

# Mfhi <reg> -> move from hi to reg.

