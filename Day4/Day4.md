# Introduction to Timing libs

Let's take a look at our .lib file<br>
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
Lets also analyse the multiple_modules.v file<br><br>
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
<br><br>
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/90cc67b1-83d6-437e-9659-8c47a742f121)

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/01eaee35-0472-48b6-a7b8-463f4943fa2b)


```
show multiple_modules
```
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/a6e56bfc-d167-4fc5-9862-1f3a4921c472)
<br><br>
This design is known as Heirarchical design. Each module here is instantiated as a gate. The netlist can be viewed via:
```
write_verilog -noattr multiple_modules_hier.v
```
Viewing the multiple_modules_hier file,<br><br>
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/7317dd55-e2ca-4e6d-b288-c16cbeb2d57b)

If we execute the ```flatten``` command, the hierarchies won't be preserved and our code is more succinct.<br><br>
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/33f959a7-0a51-4c48-b6de-04a5ed18e296)
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/59a793f9-2507-4870-810f-e817b32cc386)

### Sub-level module synthesis
Invoking ```yosys``` in the same directory, we first execute ```read_verilog multiple_modules.v``` to read the file, followed by ```synth -top sub_module1``` to synthesize the AND gate.<br><br>
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/04b3f2c0-f7e9-4b89-a72f-23d00a006afc)

This step yields the following stats. This also confirms that there is **one** AND gate in the design.<br><br>
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/a5aba0ba-ff83-4c0f-87d8-165895a1a527)

An execution of the ```abc -liberty ../Day3/sky130_fd_sc_hd__tt_025C_1v80.lib``` command links our library. Next we execute ```show``` to display the sub module.
<br><br>
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/3ca8d19a-a174-410f-9af4-c8ae955c3978)

This approach, where we compartmentalize the synthesis of sub modules is essential when synthesizing large designs. Once the sub modules are synthesized, we can combine them into the larger design. The benefits of this are:
- Easier to debug.
- Multiple instances of the same module will not require to be synthensized each time.

# Flop Coding Styles and Optimization

