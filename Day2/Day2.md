# Day 2

## ASM calls in C

Create a C file, 1to9.c.
```c
#include<stdio.h>

extern int load(int x, int y);

int main(){
  int result = 0;
  int count = 9;
  result = load(0x0, count+1);   //passed to asm program via function call
  //result returned in a0 register
  printf("Sum of numbers from 1 to %d = %d/n", count, result);
}
```
In the same directory, we have our load function, load.S in assembly.
```asm
.section .text
.global load
.type load, @function
; function takes in 10, which is stored in a1
load:
        add  a4, a0, zero    ; a4 initialized with 0x0
        add  a2, a0, a1      ; store 10 in a2, which is stored in a1
        add  a3, a0, zero    ; a3 will store intermediate sum, initializing it with 0
loop:   add  a4, a3, a4      ; a4 stores final sum which is added at each point in the loop
        addi a3, a3, 1       ; increments a3, which is the value that has to be added at each stage
        blt  a3, a2, loop    ; loop if a3 is less than 10
        add  a0, a4, zero    ; a0 stores final result
        ret
```

Compile the above C code with the Ofast optimization. Remember to include the assembly file as well, and then view the output using spike.
```bash
riscv64-unknown-elf-gcc -01 -mabi=lp64 -march=rv64i -o 1to9.o 1to9.c load.S
spike pk -o 1to9.o 
```
## Basic Verification flow with iVerilog
Clone the repo to get started.
```
git clone https://github.com/kunalg123/riscv_workshop_collaterals.git
```


