# $a0,$a1,$a2 used for passing parameters to functions
# $v0 $v1 for return values
# $sp -> stack pointer
# Stack grows reverse ie top is at lower address

# For each call of function:
#     Decrement stack pointer by 4*(no of registers you want to store) {this is like storing a frame of a function call}
#     Save the $ra value in stack
#     Save any variables/parameters that maybe needed by function call ends in stack
#     Use a0 a1 a2 to pass parameters
#     FUNCTION CALL (using jal) (return from function using jr)

# Retrieve all old parameters and variables using sw/sb
# Increment sp to old value
# Now use v0 and v1 return value from function

