import alu_pkg::*;

module shift_unit (
    input  logic [7:0] A,
    input  logic [7:0] B,
    input  logic [1:0] shift_sel,
    output logic [7:0] result
);

    logic [2:0] shamt;
    assign shamt = B[2:0];

    always_comb begin
        unique case (shift_sel)
            SHIFT_LEFT         : result = A << shamt;
            SHIFT_RIGHT_LOGICAL: result = A >> shamt;
            SHIFT_RIGHT_ARITH  : result = signed'(A) >>> shamt;
            default            : result = 8'd0;
        endcase
    end

endmodule 
