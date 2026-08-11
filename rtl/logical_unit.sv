import alu_pkg::*;

module logical_unit (
    input  logic [7:0] A,
    input  logic [7:0] B,
    input  logic [1:0] logic_sel,
    output logic [7:0] result
);

    always_comb begin
        unique case (logic_sel)
            LOGIC_AND: result = A & B;
            LOGIC_OR : result = A | B;
            LOGIC_XOR: result = A ^ B;
            LOGIC_NOT: result = ~A;
            default  : result = 8'd0;
        endcase
    end

endmodule :
