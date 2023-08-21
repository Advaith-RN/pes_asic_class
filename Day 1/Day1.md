
### Dependencies

- Follow the instruction in the ``` README ``` to install the relevant tools:
	- [RISC-V GNU Compiler Toolchain](https://github.com/riscv-collab/riscv-gnu-toolchain)
	- [RISC-V Proxy Kernel](https://github.com/riscv-software-src/riscv-pk)
	- [RISC-V  Spike](https://github.com/riscv-software-src/riscv-isa-sim)

Open your terminal and run the following command to create a  ```.c```  file. 

```bash 
vim lab1/sum1ton.c 
``` 

This C program sums up numbers from 1 to n:

```c
#include<stdio.h>

int main(){
	int sum = 0, n=50;

	for(int i= 0; i <= n; ++i){
		sum += i;
	}

	printf("Sum from 1 to %d is %d", n, sum);
	return 0;
}
```

- To run the above code use :

```shell 
gcc lab1/sum1ton.c
```

This runs it using gcc, on our machine.

```bash
cat lab1/sum1ton.c
```

Gives the output ```Sum from 1 to 50 is 1275```


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

```shell
riscv64-unknown-elf-objdump -d  sum1ton.o 
```

- Repeating the above but with ``` ofast ``` :

``` shell
riscv64-unknown-elf-gcc -0fast -mabi=lp64 -march=rv64i -o sum1ton.o sum1ton.c
```