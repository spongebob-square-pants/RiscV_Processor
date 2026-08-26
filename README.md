# Single-Cycle RISC-V

Classic Harris & Harris single-cycle architecture.

## ISA supported
| Category | Instructions |
|---|---|
| R-type | `add`, `sub`, `and`, `or`, `slt` |
| I-type (ALU) | `addi`, `andi`, `ori`, `slti` |
| Load/Store | `lw`, `sw` |
| Branch | `beq` |
| Jump | `jal` |


## Files
- `*.v` — RTL (see inline comments for what was fixed vs. added)
- `self_check_tb.v` — self-checking testbench; asserts register/memory
  state against hand-computed expected values after running `tools/prog.hex`
- `Single_cycle_Top_TP.v` — original minimal clock/reset smoke-test bench


## Known simulation caveat
The register file has no reset-to-zero loop 


2. Pipeline it (5-stage IF/ID/EX/MEM/WB) with hazard forwarding and
   branch-flush logic.
3. Synthesize for a real FPGA target and report Fmax / utilization /
   timing closure.
4. Add a UART or GPIO peripheral and run real compiled C on it.
