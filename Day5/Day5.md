# Introduction to Optimizations

## Constant Propagation and Boolean Logic Optimization

- Constant propagation is a process where the value of 0 or 1 is transmitted through a circuit, resulting in a more efficient version of the circuit it traverses. 
- Boolean logic optimization, on the other hand, is performed by synthesis tools to create a highly optimized logic representation that can be efficiently and easily implemented.
  - As an example, the equation ```assign y = a?(b?c:(c?a:0)):(!c)``` can be simplified to the concise ```y = a&c```
- It's worth noting that constant propagation can also be applied in the context of sequential logic circuits, but only when the immediate output of the logic circuit is a constant value. In such cases, optimization becomes possible.

## Combinational Logic Optimizations

