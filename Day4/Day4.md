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
To mitigate potential glitch-related issues stemming from gate propagation delays, we implement flip-flops at the conclusion of each combinational block. These flip-flops serve the dual purpose of preserving the initial value and preventing glitches from occurring.
<br>
### D Flip Flop with asynchronous set
Now synthesizing the asynchronous set D Flip Flop<br><br>
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/cf464353-9efc-49dc-9714-f93d2bf5c128)
```
read_verilog dff_async_set.v
synth -top dff_aync_set
```
As we are synthesizing a d flip flop, we are to use a keyword here, dfflibmap.
```
dfflibmap -liberty ../sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty ../sky130_fd_sc_hd__tt_025C_1v80.lib
```
<br>

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/0f6ca901-51ba-4a14-8a0a-cdb91eb65f3a)

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/b290e16f-8d07-47a4-8927-6502e368c909)

We can view the design by executing
```
show dff_async_set
```
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/ef3bb084-6cc5-4145-849c-11330f3d41b2)



### D Flip Flop with asynchronous reset
As we synthesized the above design, let us also do the same for the dff_asyncres.v file.<br><br>

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/d5e02080-ec75-4675-a7bb-3bae8bb7bc13)

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/9cefd819-a656-4182-94a2-a3e189164747)

Additionally, we can view the timing diagram of our design by running gtk wave.
<br><br>
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/784e7979-464a-4a78-8edb-cc0ee634f9c7)
<br>
As we can see on gtkwave, whenever the clk is high and the async_reset is high, it resets the output to 0 always. <br>

### D Flip Flop with synchronous reset
Synthesizing the D Flip Flop with synchronous reset,

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/87828af5-5f0a-4daa-a2ba-71605cbffad2)

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/3af7a040-bd26-4b9f-82f2-061595e356dd)


## Interesting Optimizations




