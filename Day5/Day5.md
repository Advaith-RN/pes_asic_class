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
