# Introduction to Verilog RTL Design and Synthesis
### Verilog - a programming language used for designing and simulating digital systems.
It's employed in electronic engineering to model circuits and systems, describing how components like gates and flip-flops interact. 
Verilog code allows designers to test and verify digital designs through simulation, and it can also be synthesized into hardware configurations for chips or FPGAs. This language is a fundamental tool in the field, enabling engineers to develop and validate complex digital systems before actual implementation.

### Key Concepts
1. **Modules:** Modules are building blocks in Verilog that represent different parts of a digital circuit.

2. **Ports:** Ports are like doors to a module; they let data in and out.

3. **Signals:** Signals are wires that carry digital information, like on/off or 1/0 signals.

4. **Combinational Logic:** This is logic where outputs only depend on current inputs, like addition.

5. **Sequential Logic:** Here, outputs depend on inputs and past history, like remembering previous results.

6. **Clock and Edge:** The clock is a timer for a circuit. The edges (rising or falling) of the clock signal trigger actions.

## GTK Wave labs
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/2267a650-e0b9-45b6-aa48-4328befd5836)
<br>
Clone the repo [sky130RTL](https://github.com/kunalg123/sky130RTLDesignAndSynthesisWorkshop.git). Go to the verilog files directory and run the good_mux.v along with its testbench.
Running a.out generates the dumpfile.

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/9d72246c-069e-4fb3-b55f-5da7c7a4d18a)
**Running the vcd file on GTK wave**

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/a009009e-82d4-4b12-88a8-8ce086de9897)
**good_mux and testbench for good_mux**

## Intro to Yosys
### Yosys - an RTL Synthesis Framework for Digital Design
It is an essential tool in the realm of digital design, focusing on RTL (Register-Transfer Level) synthesis. This open-source framework takes high-level hardware descriptions, often penned in Verilog or SystemVerilog, and converts them into gate-level representations. This enables designers to optimize, analyze, and further implement these designs in actual digital circuits.

Invoke Yosys and read the library
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/196bb4a5-b0fd-42f3-bf34-976dcc93a0d1)
<br>
**Synthesize the design**
<br>
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/70ce6f9f-8e74-46c3-9944-0f04a76aabe3)
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/ddf0e587-c596-4032-afce-f4bac1dcfa1e)
<br>
**Generate the netlist**
<br>
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/a37baee7-b11a-4888-b9fc-f05c16e6f693)
<br>
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/903f447c-fae0-4491-afdf-4838fc452268)

**You can view the design by typing show.**<br>
![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/af099ecd-6683-412b-b281-5f179ae48200)




