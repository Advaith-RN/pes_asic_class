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
Lets take a look at mul2.v<br><br>
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/58a3b74a-05ce-42d0-9539-1b6c6d51c4b9)
<br>
This takes in a 3 bit input and gives a 4 bit output. 
- Taking an example of input 3 -> 3b'011
- 3 * 2 = 6, which is 4'b0110
- Essentially, it has a 0 appended to it.
Let us synthesize this design.
<br><br>
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/8bfd4686-0773-46b5-a5af-f38c624f9d94)

After executing ```abc -liberty ./sky130_fd_sc_hd__tt_025C_1v80.lib ```<br><br>
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/c16358ef-01c2-453a-bc60-300fd83f525c)

- We can see there is no hardware generated.
- Additionally, there is nothing to link to.
<br><br>
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/e2fbadde-ec9c-4df9-be73-baae26214a1b)

To generate the netlist file,
```
write_verilog -noattr mul2_net.v
```

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/b0b48285-e73d-40b0-add8-e40646ab14dd)

We can see that a 0 is appended to a.


Now lets take a look at mult_8.v<br><br>

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/12a00962-8c07-404b-ab46-1058c145f2b4)
<br>
This takes in a 3 bit input and gives a 6 bit output. 
- The relationship between a and y is -> ```a*9 = y```.
- This can be interpreted as ```(a8) + (a1) = y```.
- Essentially, y is a concatenation of 'aa'.
Let us synthesize this design as well.
<br>

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/48177019-f015-486c-a230-8a4944fcdfe4)

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/0579d0ea-4e3d-4e32-bbf9-3a8dbec238d4)

The netlist file yields: <br><br>
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/1c91b9ff-5e1f-4fbb-b898-fec3dfd01e3b)

As we can see y is a concatenation of 'aa'.



