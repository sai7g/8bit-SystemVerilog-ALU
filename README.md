# 8-Bit Basic ALU — SystemVerilog Project

## Overview
Modular, synthesizable 8-bit ALU in SystemVerilog (.sv), functionally
identical to the Verilog-2001 version but using SV constructs:
- `logic` instead of `reg`/`wire`
- `always_comb` instead of `always @(*)` (compile-time checked, no latch risk)
- A shared `alu_pkg` package for all opcode/select-signal encodings, imported
  by every module instead of re-declaring localparams per file
- `unique case` for full-case linting
- SV testbench conveniences: `logic`, `int`/`foreach`-style loops, an
  `automatic` task with a `string` argument in `alu_top_tb`

Verified with Icarus Verilog (`iverilog -g2012`) — every module and the
full top-level integration compiled and simulated with correct results
against the same test vectors as the Verilog-2001 version.

## Hierarchy
```
alu_top
├── control_unit       (opcode decode)
├── arithmetic_unit    (ADD, SUB, INC, DEC)
├── logical_unit       (AND, OR, XOR, NOT)
├── shift_unit         (SHL, logical SHR, arithmetic SHR)
├── rotate_unit        (ROL, ROR)
├── comparator_unit    (EQ, GT, LT)
├── result_mux         (selects final result)
└── flag_unit          (Zero/Carry/Overflow/Negative/Parity)
```
All modules `import alu_pkg::*;` for shared constants.

## Opcode Map
| Opcode | Operation | Opcode | Operation |
|--------|-----------|--------|-----------|
| 0000 | ADD | 1000 | Shift Left |
| 0001 | SUB | 1001 | Shift Right (logical) |
| 0010 | INC A | 1010 | Shift Right (arithmetic) |
| 0011 | DEC A | 1011 | Rotate Left |
| 0100 | AND | 1100 | Rotate Right |
| 0101 | OR | 1101 | Compare Equal |
| 0110 | XOR | 1110 | Compare Greater-Than |
| 0111 | NOT A | 1111 | Compare Less-Than |

## Design Assumption
Shift/rotate amount is taken from `B[2:0]` (0–7 bit positions) since the
original spec did not define a shift-amount source — same assumption as
the Verilog-2001 version. One-line change in `shift_unit.sv`/`rotate_unit.sv`
if a fixed 1-bit shift is required instead.

## Flags
- **Zero**: final_result == 0
- **Carry**: valid only for arithmetic ops (0000–0011); gated to 0 otherwise. For SUB it represents borrow.
- **Overflow**: valid only for arithmetic ops; signed 2's-complement overflow. Gated to 0 otherwise.
- **Negative**: final_result[7]
- **Parity**: 1 = even number of 1-bits in final_result

## Running Simulations (Icarus Verilog, SV mode)
```bash
# Individual unit, e.g. arithmetic_unit (package must be compiled first)
iverilog -g2012 -o sim alu_pkg.sv arithmetic_unit.sv arithmetic_unit_tb.sv
vvp sim

# Full ALU
iverilog -g2012 -o sim alu_pkg.sv arithmetic_unit.sv logical_unit.sv \
  shift_unit.sv rotate_unit.sv comparator_unit.sv flag_unit.sv \
  control_unit.sv result_mux.sv alu_top.sv alu_top_tb.sv
vvp sim
```
Note: Icarus 12.0 prints harmless `sorry:` notices for `unique case`
(quality is ignored, functionality unaffected) — these are tool
limitations, not design errors. A commercial simulator (Questa,
VCS, Xcelium) will honor `unique case` fully and flag any
overlapping/incomplete case coverage at elaboration time.

## File List
alu_pkg.sv (shared package, compile first), then per module:
arithmetic_unit.sv / _tb.sv, logical_unit.sv / _tb.sv, shift_unit.sv / _tb.sv,
rotate_unit.sv / _tb.sv, comparator_unit.sv / _tb.sv, flag_unit.sv / _tb.sv,
control_unit.sv / _tb.sv, result_mux.sv / _tb.sv, alu_top.sv / _tb.sv
