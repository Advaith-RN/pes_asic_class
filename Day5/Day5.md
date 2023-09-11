# Introduction to Optimizations

## Constant Propagation and Boolean Logic Optimization

- Constant propagation is a process where the value of 0 or 1 is transmitted through a circuit, resulting in a more efficient version of the circuit it traverses. 
- Boolean logic optimization, on the other hand, is performed by synthesis tools to create a highly optimized logic representation that can be efficiently and easily implemented.
  - As an example, the equation ```assign y = a?(b?c:(c?a:0)):(!c)``` can be simplified to the concise ```y = a&c```
- It's worth noting that constant propagation can also be applied in the context of sequential logic circuits, but only when the immediate output of the logic circuit is a constant value. In such cases, optimization becomes possible.

## Combinational Logic Optimizations
Taking a look at 5 different programs here:

### opt_check.v
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

### opt_check2.v
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

### opt_check3.v

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

### opt_check4.v
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

As we can see, the 2-input XNOR is generated, and the final equation is independant of b.
