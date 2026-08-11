import alu_pkg::*;

module flag_unit (
    input  logic [7:0] final_result,
    input  logic       arith_carry,
    input  logic       arith_overflow,
    input  logic [2:0] result_sel,
    output logic       zero_flag,
    output logic       carry_flag,
    output logic       overflow_flag,
    output logic       negative_flag,
    output logic       parity_flag
);

    assign zero_flag     = (final_result == 8'd0);
    assign carry_flag    = (result_sel == RESULT_ARITH) ? arith_carry    : 1'b0;
    assign overflow_flag = (result_sel == RESULT_ARITH) ? arith_overflow : 1'b0;
    assign negative_flag = final_result[7];
    assign parity_flag   = ~^final_result; // 1 = even parity (even number of 1s)

endmodule 
