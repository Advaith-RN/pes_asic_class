# Introduction to Optimizations

## Constant Propagation and Boolean Logic Optimization

- Constant propagation is a process where the value of 0 or 1 is transmitted through a circuit, resulting in a more efficient version of the circuit it traverses. 
- Boolean logic optimization, on the other hand, is performed by synthesis tools to create a highly optimized logic representation that can be efficiently and easily implemented.
  - As an example, the equation ```assign y = a?(b?c:(c?a:0)):(!c)``` can be simplified to the concise ```y = a&c```
- It's worth noting that constant propagation can also be applied in the context of sequential logic circuits, but only when the immediate output of the logic circuit is a constant value. In such cases, optimization becomes possible.

## Combinational Logic Optimizations
Taking a look at 5 different programs here:

### 1. opt_check.v
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/a1bf470d-c02e-4a8b-94b7-bbdf74edbff4)


We first import cells from the library, and then synthesize, 
```
read_liberty -lib ./sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog opt_check.v
synth -top opt_check
```
<br>

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/2996f59d-2942-4e71-8c63-635684429ec7)

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/2c3ae0f9-1300-45d7-9851-adb45625a7d6)

After this, we run
```
opt_clean -purge
```
This command removes all unused cells and optimizes the design.

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/d6d6cd54-c5d8-4bd6-9858-db743861f9ff)

Next, we link up the library files, and then view the design with ```show```
```
abc -liberty ./sky130_fd_sc_hd__tt_025C_1v80.lib
```
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/9faf7359-d13f-4a3a-a40e-75a67d56fd64)

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/0f96bf07-de8b-4196-adee-2bc6b8b9230f)

### 2. opt_check2.v
Our second program consists of a 2:1 MUX, where if ```a == 1, y = a``` else ```y=b```.
Essentially, ```y = a + a'.b```, which is ```y = a +b```
This is the **Absorption law**. 
<br><br>
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/ecfebe5e-0bb9-4deb-a3b4-27cb162f4a02)

Synthesizing the design using the same steps as shown above,
<br><br>
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/33263ff8-7449-4ff6-a00b-c4cca2b42ae1)

From the above stats, we can confirm an **OR** gate was generated. We execute an ```opt_clean -purge``` before linking the library files again.
```
abc -liberty ./sky130_fd_sc_hd__tt_025C_1v80.lib
```
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/a780a335-bb86-4349-9851-ce10b07bcd68)
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/9e795c1f-da0c-49f7-b5d7-916ef3db1854)

### 3. opt_check3.v

**opt_check3.v** consists of two 2:1 MUXes. The output of the first MUX connects as an input to the second MUX.
When ```a == 1```, the second MUX is chosen, else it ```y = 0```.
The second MUX chooses b if ```c == 1``` else it chooses 0.
The final equation boils down to ```y = a'.0 + a.(c'.0 + c.b) = a.b.c```
<br><br>
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/750dc27c-b99a-49ff-ae74-24f506717650)

Going through the entire synthesis flow again,
<br><br>
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/c0b3a3f0-f31a-4024-aafc-f8e1094531c6)

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/d3148b1a-3182-4e67-94e9-4e912b8b6484)

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/1e31017a-a498-4cd5-9a1a-19d0dff5e3f6)

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/f940119c-8475-4e38-9a1a-37b4dbd5aa95)

As we can see the design matches ```y = a.b.c```

### 4. opt_check4.v
The equation for the fourth program before simplification is ```y = a?(b?(a & c ):c):(!c)```.
- ```bac + b'c = y1```
- ```ay1 + a'c' = y2```
- ```a(bac + b'c) + a'c' = y2```
- ```abc + ab'c + a'c' = y2```
- ``` ac + a'c' = y2```

Essentially, the final equation is independant of b, and is an XNOR gate.

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/20f44c2a-4ced-46aa-9194-a3c53338675c)

Synthesizing this design,
<br><br>
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/f7f50ad2-0a3b-40b9-a4db-2b79c3776380)

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/937f9bb5-5b8b-4d4d-be17-f6a1cfba413a)

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/bb928df2-cc9f-4736-af7a-0a85a86a5966)

As we can see, the 2-input XNOR is generated, and the final equation is independent of b.

### 5. multiple_module_opt.v

Taking a look at multiple_module_opt.v, we can check the equation to be:
- ```n1 = a.1```
- ```n2 = n1 ^ 0```
- ```n3 = b^d```
- ```y = c + b.a```
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/48107241-ddd5-4083-92e8-e0d9133e8421)

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/4995eee0-e517-4ea2-a23a-702da0bd3800)

Before running ```opt_clean -purge```, we run ```flatten```. This ensures constant propogation and removes hierarchies when we display the final design.
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/5b10578a-65b1-4f24-a2c1-ece59336385c)

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/a30f2bc2-a143-43a9-a7e3-665f47586b37)

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/ba1ee154-b59c-43a1-847b-a5fb1edbbe62)

As we can see, the final output is independent of d and is represented by the equation ```y = c + b.a```.

### 6. multiple_module_opt2.v
Deriving the equation for this design,
- ```n1 = a.0 = 0```
- ```n2 = b.c```
- ```n3 = b.c.d```
- ```y = b.c.d.0 = 0```
<br><br>
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/8a783a1d-691e-4601-89a0-b4fc3336665a)

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/3f69c9e3-0b6f-47d9-8f31-b66c94927f2c)

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/c53fa5c1-8a01-4cea-a7ee-5d5a49a6c20d)

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/cb0aafcc-e121-4575-a47f-9a6419cabedb)

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/6b49a293-d5ec-483f-8769-aaa726cb9e87)

The design for program 6 shows the result ```y = b.c.d.0 = 0``` clearly.
```y``` is independent of all other inputs. 

## Sequential Logic optimizations

### 1. dff_const1.v
This program is for a D Flip Flop with a reset.
- D = 1 always
- If Reset is active, output is 0
- If Reset is inactive, output is 1 on the **positive edge of the clock.**

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/8bf2fe52-7bc6-4a3b-b0b2-75946dc32fd0)

First, let us view the waveform simulation, using iverilog and GTKWave.
```
iverilog dff_const1.v tb_dff_const1.v
```
To generate vcd file, execute ```./a.out```. Open the vcd file on GTKWave.
```
gtkwave tb_dff_const1.vcd
```
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/d2222cca-6d63-4562-a1e4-b1f50572e7b4)

As we can see, the results are verified in the diagram.
Its time to synthesize the design.
<br>
As per the usual flow, we open yosys.
```
read_liberty -lib ../sky130_fd_sc_hd__tt_025C_1v80.lib   # Read lib

read_verilog dff_const1.v    # Read the file and then synthesize
sythn -top dff_const1
  
dfflibmap -liberty ../sky130_fd_sc_hd__tt_025C_1v80.lib     # As we are working with flip flops

abc -liberty  ../sky130_fd_sc_hd__tt_025C_1v80.lib    # Link library files 

show dff_const1    # view design
```
<br><br>
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/a573d8ed-6817-4cce-a8f8-02b123d510b5)

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/5c64f990-4ba6-4e63-a520-6841b54fb410)

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/bccfa26d-abf9-48b2-8d23-3810e412db99)

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/8a3c083d-50e2-460c-9eed-dddd9cbc89f1)

An inverter is used to implement the active high reset.

### 2. dff_const2.v
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/4ea30fe5-a84f-47df-b5b5-3019d802b7e9)

This is also a D Flip Flop with a reset. It is set to 1.
- If Reset is 1, output is 1.
- If Reset if 0, output remains 1.
- Essentially, output is always 1.

Looking at the waveform simulation,
<br><br>
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/fb5e5f0a-0d18-475e-8c7a-bc6cb42be904)

Output is always 1.
<br>
Now to synthesize the design.
<br><br>
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/8c884718-7c2d-4182-8b0c-89699f18306e)

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/17e7c366-9fed-4d85-bbfd-6afe89baf66a)

Again, executing ```dfflibmap -liberty ../sky130_fd_sc_hd__tt_025C_1v80.lib```, <br><br>
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/ec48dc6b-5102-44ca-a30f-4076268815a3)

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/742b4280-dd70-41bf-9409-bd7e60d8cf16)

Here, we notice that the libraries don't get linked, as no cells are generated.

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/6b6a28cc-e7de-44f1-802b-71684c377c46)

Output is always 1, and we can see the design maps it accordingly.

### 3. dff_const3.v
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/b362a1b5-812e-493e-8f7a-b1c79072498d)

This design has 2 D Flip Flops
- The output of the first is connected to the input of the second.
- Their reset and clock is the same.

Our waveform simulation shows this result,
<br><br>
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/540c1f49-ee72-4368-bf1c-4b045da7c41c)
<br>
- Q only becomes low for one cycle due to Clock to Q delay.
- Q1 becomes high after a slight delay when the clock has a postive edge
- Q remains 0 during the delay, changing at the next positive edge of the clock.

Now, to synthesize the design,
<br><br>
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/6f8e6ebd-b3a6-411c-bdbb-90666f0d90d6)

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/56ff5ec4-882a-4074-886c-098b33bd1cc3)

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/cb40da51-cea3-4163-b377-27e569f8a332)

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/259ca815-243b-4062-b3aa-f6340104a3fb)

### 4. dff_const4.v
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/7bc9a669-b763-4b9a-be05-373656bd9c57)
This design has also has 2 D Flip Flops.
Lets analyze the waveform simulation. <br><br>
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/3ade7d09-b88c-4ab7-a999-e64cdbf39579)

The output of q is always 1, regardless of clock and reset.
Our synthesized design in yosys should yield outputs connected to 1.
<br><br>
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/44bf01f4-7e60-4e33-99b7-86a61805fe5c)

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/3b89ed7e-7454-40ea-a5f8-0c54f446eb3e)

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/179b6b4f-f8ac-496e-9b4e-0a7bc45f9fdb)

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/0710322c-b224-4e30-a2ae-32eea785c487)

Both Q and Q1 map to 1 directly.

### 5. dff_const5.v
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/c5316825-afbe-490e-a211-bc6e34fa02cf)

Analyzing on gtkwave, <br><br>
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/3c3dd6e9-b805-4ace-99ef-3e1a67ada27b)

- When the reset is high, both Q1 and Q are low.
- When the reset is low, Q1 becomes high on the positive edge of the clock.
- Q1 essentially remains at 0 during the positive edge of the clock.
- Q remains 0 for that cycle.
- Q's value goes high one cycle late compared to Q1.

Synthesizing the design with yosys we get,
<br><br>
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/3167650a-5ec7-40d9-b14b-2704c03647bb)

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/8e05e871-b009-4841-9c39-4b96b31d4a1b)

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/89602f23-e2e0-4eae-91a8-cc98e4ff80a0)

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/75f16327-9ed2-4af3-ae12-ed3df6f6b62d)

The output consists of 2 flops. They both have the same clock and reset, and the output of the first is fed into the input of the second.
An inverter is present as synthesis expects an **active low reset**, but we have an **active high reset.**

## Sequential Optimizations for Unused Output

### 1. counter_opt.v
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/320a082c-b23b-42d3-a36e-8f29a4131b75)

This is the design for a 3 bit up counter. The output prioritizes only 1 bit.
Let us synthesize the design.
<br><br>
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/8e13ee5d-1a58-4e7c-b6c4-3dc1bfce3719)

Remember to execute ```dfflibmap -liberty ../sky130_fd_sc_hd__tt_025C_1v80.lib``` as our design contains flip flops.
<br><br>

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/6ba4a3c6-764d-4785-b6b4-917c21fb64f3)

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/6fd31c66-6fa0-4e2c-8e97-2d023d5674f6)

There is only one Flop present in the design.
-  Q is connected to bit 0, which is the count.
-  Q is also connected to an inverter that is fed back into out input.
-  The unused bits are optimized.

### 2. counter_opt2.v
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/7f7eaf6e-f51d-4803-b846-bc874ddae4db)

This program is a modified version of the previous one. All three bits are mapped, so we can expect three flops on synthesis.

<br><br>

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/640a6014-ca7b-4bd3-98e7-713b7fa1540d)

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/b7c5c592-6872-4bb0-b472-df88fda30594)

There are 3 flops synthesized. 
- Each flop has a bit connected to it.
- Each bit is coming to the adder logic present in the middle of the design.
- The NOR gate from which Q exits has connections from all three input bits.
- The output is ```Q = count[2].count[1]'.count[0]'```
