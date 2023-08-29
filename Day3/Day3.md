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


![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/2267a650-e0b9-45b6-aa48-4328befd5836)
clone the repo [sky130RTL](https://github.com/kunalg123/sky130RTLDesignAndSynthesisWorkshop.git). Go to the verilog files directory and run the good_mux.v along with its testbench.
Running a.out generates the dumpfile.

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/9d72246c-069e-4fb3-b55f-5da7c7a4d18a)
Running the vcd file on GTK wave

![image](https://github.com/Advaith-RN/pes_asic_class/assets/77977360/a009009e-82d4-4b12-88a8-8ce086de9897)
good_mux and testbench for good_mux
