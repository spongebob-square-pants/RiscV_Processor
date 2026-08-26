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
- `*.v` — RTL 
- `self_check_tb.v` — self-checking testbench
- `Single_cycle_Top_TP.v` — minimal clock/reset test bench


## Known simulation caveat
The register file has no reset-to-zero loop 
