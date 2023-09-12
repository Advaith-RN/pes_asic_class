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



