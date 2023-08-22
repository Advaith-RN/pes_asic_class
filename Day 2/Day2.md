# Day 2

## ASM Instructions

Create a C file, 1to9_custom.c.
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
// function takes in 10, which is stored in a0
load:
        add  a4, a0, zero     
        add  a2, a0, a1
        add  a3, a0, zero
loop:   add  a4, a3, a4
        addi a3, a3, 1
        blt  a3, a2, loop
        add  a0, a4, zero
        ret
```
