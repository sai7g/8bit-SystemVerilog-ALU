import alu_pkg::*;

module comparator_unit (
    input  logic [7:0] A,
    input  logic [7:0] B,
    input  logic [1:0] compare_sel,
    output logic [7:0] result
);

    always_comb begin
        unique case (compare_sel)
            COMPARE_EQ: result = (A == B) ? CMP_EQUAL   : 8'b0;
            COMPARE_GT: result = (A >  B) ? CMP_GREATER : 8'b0;
            COMPARE_LT: result = (A <  B) ? CMP_LESS    : 8'b0;
            default   : result = 8'b0;
        endcase
    end

endmodule 
