import alu_pkg::*;

module result_mux (
    input  logic [7:0] arith_result,
    input  logic [7:0] logic_result,
    input  logic [7:0] shift_result,
    input  logic [7:0] rotate_result,
    input  logic [7:0] compare_result,
    input  logic [2:0] result_sel,
    output logic [7:0] final_result
);

    always_comb begin
        unique case (result_sel)
            RESULT_ARITH  : final_result = arith_result;
            RESULT_LOGIC  : final_result = logic_result;
            RESULT_SHIFT  : final_result = shift_result;
            RESULT_ROTATE : final_result = rotate_result;
            RESULT_COMPARE: final_result = compare_result;
            default       : final_result = 8'd0;
        endcase
    end

endmodule
