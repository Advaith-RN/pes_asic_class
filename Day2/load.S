.section .text
.global load
.type load, @function
# function takes in 10, which is stored in a1
load:
        add  a4, a0, zero    # a4 initialized with 0x0
        add  a2, a0, a1      # store 10 in a2, which is stored in a1
        add  a3, a0, zero    # a3 will store intermediate sum, initializing it with 0
loop:   add  a4, a3, a4      # a4 stores final sum which is added at each point in the loop
        addi a3, a3, 1       # increments a3, which is the value that has to be added at each stage
        blt  a3, a2, loop    # loop if a3 is less than 10
        add  a0, a4, zero    # a0 stores final result
        ret
