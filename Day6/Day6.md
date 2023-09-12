# GLS Synthesis Simulation Mismatch and Blocking/Non-Blocking Statements

Gate Level Simulation (GLS) involves the following key steps:

1. **Netlist Generation**: A netlist file is generated from the Register-Transfer Level (RTL) description of a digital design. This netlist represents the design using logic gates and interconnections.

2. **Test Bench Compatibility**: The netlist file can be tested using the same test bench that was originally used for simulating the RTL description. The test bench includes input vectors and expected output values.

3. **Output Verification**: Both the netlist simulation and RTL simulation with the test bench should produce identical outputs. If they match, it confirms that the synthesized netlist faithfully represents the RTL design.

4. **Design Validation**: GLS is a crucial step in the design validation process. It helps ensure that the logic synthesis process has correctly transformed the RTL design into gate-level components without introducing errors.

5. **Gate-Level Verilog Models**: Gate-level Verilog models are utilized to map the elements in the netlist to the corresponding physical cells or gates available in the target technology library.

**Synthesis Simulation Mismatch:**

A synthesis simulation mismatch can occur for various reasons, including the following factors:

1. **Missing Sensitivity List Elements**:
   - In Verilog, an always block has a sensitivity list that specifies the signals that trigger the block's execution.
   - If a variable that undergoes a change in the design is not included in the sensitivity list, the synthesis tool may not recognize its importance.
   - During simulation, only the variables mentioned in the sensitivity list are considered for changes, potentially leading to incomplete testing.
   - Synthesis, however, doesn't rely on the sensitivity list and may optimize the design differently.

2. **Blocking and Non-blocking Statements**:
   - Verilog uses two assignment operators: '=' for blocking and '<=' for non-blocking assignments.
   - Blocking Statement ('='):
     - In an always block with blocking assignments, each statement is executed sequentially.
     - The second statement is not executed until the first one has completed.
   - Non-blocking Statement ('<='):
     - In an always block with non-blocking assignments, all the right-hand side (RHS) statements are evaluated simultaneously.
     - The values computed on the RHS are then assigned to the left-hand side (LHS) variables concurrently.

In summary, synthesis simulation mismatches can arise due to differences in how Verilog constructs are interpreted during simulation versus synthesis, such as sensitivity list handling and the distinction between blocking and non-blocking assignments. These nuances highlight the importance of careful coding practices to ensure consistent behavior between simulation and synthesis.

Let's take a look at a few programs.

### Ternary Operator
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/8725f946-3790-4e8b-b946-92e4b2fdd7e9)

This is a simple 2:1 with a select line.
Analyzing this on GTKWave,
```
iverilog ternary_operator_mux.v tb_ternary_operator_mux.v    # Read design

./a.out      # generate vcd

gtkwave tb_ternary_operator_mux.vcd      # run GTKWave
```
<br><br>

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/34499bf5-8a95-405f-9e60-d906e59d83c6)

In the waveform, we can see that when ```sel == 1```, ```y = i1```, else ``` y = i0 ```.
Synthesizing this design yields the following outputs.
<br><br>
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/7f3dcfb2-537c-4b51-8c68-5d534a44cd90)

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/6aa89556-eae1-41c6-bc6c-9944449b5d04)

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/8ae682b7-37c7-4da2-82f5-6e76e5477888)

2:1 MUX is synthesized.
<br>
Now, to perform GLS,first generate the netlist file;
```
write_verilog -noattr ternary_operator_mux_net.v
```
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/74f4761a-cefb-4ac6-8ee0-5ceb3dc866ed)

To read the design and test bench, we must invoke the libraries with the respective cells and map the netlist commands to them. We can do this by running,
```
iverilog ../mylib/primitives.v ../mylib/sky130_fd_sc_hd.v ternary_operator_mux_net.v tb_ternary_operator_mux.v
```
Execute ```./a.out``` to generate the vcd file.
Now viewing the vcd file with GTKWave, <br><br>

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/aa799669-9dae-49d0-8a4c-a981ee1d6a2e)

This waveform validates that when ```sel == 1``` -> ```y = i1```, else ``` y = i0 ```.

### Simulation and Synthesis mismatch

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/f0f74db2-218d-464a-89fa-3069fe5c8fa5)

Consider a simple 2:1 MUX, that depends only on the select line. View its waveform usig GTKWave. <br><br>

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/639ec631-36bc-44ef-9bb7-ada5dc175831)

This waveform is reminescent of flop behavior. Now, synthesize the design. <br><br>
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/5704542a-f628-4e29-8d6b-a3daa0cca487)

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/6cdbc782-36d2-4092-b234-9dd8c3b17a3b)

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/6586dbab-f247-45b7-ad71-04b1ce68d3cb)

Remember to generate the netlist as well, for GLS,<br><br>
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/d5f1f4a1-609f-449f-a0f7-7b40cd8a89a5)

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/b514cebf-a10e-4293-a631-1aee1b8588ce)

Repeating the above steps to generate waveform using the netlist,
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/109813f9-c4ef-4561-b6bb-ca2c4a7beca8)

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/25972911-aef8-456b-945b-9836be477d28)

This is a normal 2:1 MUX. When ```sel == 1```, ``` y = i1 ```. Else it is ```i0```.
<br>There is a mismatch in simulation and synthesis.

### Simulation and Synthesis mismatch for Blocking statement













