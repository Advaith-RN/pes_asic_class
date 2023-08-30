# Introduction to Timing libs

Let's take a look at our .lib file
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/24075bbc-a75e-452d-a1b1-04c9b0beaf76)

- sky130 is the 130nm library
- tt => typical libraries ; Can range from slow, to fast, to typical.
- 025C is Operating temp
- 1v8 is voltage
- PVT => Process, Voltage, Temperature
- PVT defines the 3 parameters that determine the conditions a circuit must operate under
- CMOS Technology is used
- The cell keyword is used frequently
- Logic gates are defined.

## Herarchial vs Flat Synthesis
Lets also analyse the multiple_modules.v file
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/83cd165b-8618-4cc5-add2-58f4ba62240f)

- Submodule 1 is an AND gate
- Submodule 2 is an OR gate

Taking initial inputs of A, B and C:
A,B -> submodule_1 -> Y1
Y1 = A&B
Y1,C -> submodule_2 -> Output Y

Finally, Y = Y1|C

Synthesizing this design on yosys,
```
synth -top multiple_modules
```
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/90cc67b1-83d6-437e-9659-8c47a742f121)

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/01eaee35-0472-48b6-a7b8-463f4943fa2b)


```
show multiple_modules
```
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/a6e56bfc-d167-4fc5-9862-1f3a4921c472)
