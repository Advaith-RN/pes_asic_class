# Day 1
## Sum 1 to n program
Open your terminal and run the following command to create a  ```.c```  file. 

```shell 
vim lab1/sum1ton.c 
``` 

This [C program](https://github.com/Advaith-RN/pes_asic_class/blob/main/Day%201/sum1ton.c) sums up numbers from 1 to n:

```c
#include<stdio.h>

int main()
{
	int i, sum = 0;
	int n = 50;

	for(i = 0;i <= n; i++)
	{
		sum+=i;
	}
	printf("Sum from 1 to %d = %d\n", n, sum);
	return 0;
}
```
![ss1](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/e664b5cc-7f2c-4db7-aa06-837c28c15c7b)

- To run the above code use :

```bash 
gcc lab1/sum1ton.c
```

This runs it using gcc, on our machine.

```shell
cat lab1/sum1ton.c
```

Gives the output ```Sum from 1 to 50 = 1275```

### C to Disassembly 

- To generate a RISC-V object file we need to use the  ```riscv64-unknown-elf-gcc``` command

```bash
riscv64-unknown-elf-gcc -01 -mabi=lp64 -march=rv64i -o sum1ton.o sum1ton.c
ls -ltr sum1ton.o
```

>o1 - Level 1 optimization
>lp64 - l (long integer) p(pointer) 
>march -  risc v 64 bit arch

- To view the assembly code:

```bash
riscv64-unknown-elf-objdump -d  sum1ton.o 
```
![ss3](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/1f5d56c5-ad56-4600-9d15-c081d10385d9)

- Repeating the above but with ``` ofast ``` :

```bash
riscv64-unknown-elf-gcc -0fast -mabi=lp64 -march=rv64i -o sum1ton.o sum1ton.c
```

![ss2](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/9c6fcd96-e9d2-4960-9ffe-5b344ed5885c)
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/04e590c3-a2b4-48e7-83b4-dbd6f5bf5df5)

## Signed and Unsigned Integers

Put this code in a c file unsignedHighest.c to calculate the largest int.
```c
#include <stdio.h>
#include <math.h>

int main(){
	unsigned long long int max = (unsigned long long int) (pow(2,64) -1);
	printf("Largest unsigned long long int = %llu/n", max);
	return 0;
}
```
Compile the code and view output using:
```bash
riscv64-unknown-elf-gcc -0fast -mabi=lp64 -march=rv64i -o unsignedHighest.o unsignedHighest.c

spike pk -d unsignedHighest.o
```
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/adb88e61-6c96-41ec-a443-da9a089d41a2)


