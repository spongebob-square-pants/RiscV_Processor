# Single-Cycle RISC-V (RV32I subset)

Classic Harris & Harris single-cycle datapath, fixed and extended.

## ISA supported
| Category | Instructions |
|---|---|
| R-type | `add`, `sub`, `and`, `or`, `slt` |
| I-type (ALU) | `addi`, `andi`, `ori`, `slti` |
| Load/Store | `lw`, `sw` |
| Branch | `beq` |
| Jump | `jal` |

Not yet implemented: `slli/srli/srai` (needs a barrel shifter), `jalr`,
`lui`/`auipc`, `bne/blt/bge/bltu/bgeu` (ALU only computes subtract/Zero,
not less-than for branches), byte/halfword load-store variants.

## Files
- `*.v` — RTL (see inline comments for what was fixed vs. added)
- `self_check_tb.v` — self-checking testbench; asserts register/memory
  state against hand-computed expected values after running `tools/prog.hex`
- `tools/asm.py` — tiny Python assembler used to hand-encode the test
  program (no external toolchain dependency)
- `tools/prog.hex` — assembled test program (regenerate with `asm.py`)
- `Single_cycle_Top_TP.v` — original minimal clock/reset smoke-test bench

## Running the self-checking testbench
```
iverilog -o self_check self_check_tb.v
vvp self_check
```
Expect `ALL CHECKS PASSED`.

## Known simulation caveat
The register file has no reset-to-zero loop (matches how real register
files are usually built — resetting 32 flops costs area for no
architectural benefit). Any register never written in a given run reads
back as `X` in simulation. The testbench accounts for this explicitly
(see the `x11` check).

## Next steps toward a resume-ready project
1. Run/adapt the official `riscv-tests` compliance suite for stronger
   verification coverage than this hand-written program.
2. Pipeline it (5-stage IF/ID/EX/MEM/WB) with hazard forwarding and
   branch-flush logic.
3. Synthesize for a real FPGA target and report Fmax / utilization /
   timing closure.
4. Add a UART or GPIO peripheral and run real compiled C on it.
