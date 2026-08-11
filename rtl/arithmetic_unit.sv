import alu_pkg::*;

module arithmetic_unit (
    input  logic [7:0] A,
    input  logic [7:0] B,
    input  logic [1:0] arith_sel,
    output logic [7:0] result,
    output logic       carry,
    output logic       overflow
);

    logic [8:0] temp; 

    always_comb begin
        temp     = 9'd0;
        result   = 8'd0;
        carry    = 1'b0;
        overflow = 1'b0;

        unique case (arith_sel)
            ARITH_ADD: begin
                temp     = {1'b0, A} + {1'b0, B};
                result   = temp[7:0];
                carry    = temp[8];
                overflow = (A[7] == B[7]) && (result[7] != A[7]);
            end

            ARITH_SUB: begin
                temp     = {1'b0, A} - {1'b0, B};
                result   = temp[7:0];
                carry    = temp[8]; // borrow flag: 1 => A < B
                overflow = (A[7] != B[7]) && (result[7] != A[7]);
            end

            ARITH_INC: begin
                temp     = {1'b0, A} + 9'd1;
                result   = temp[7:0];
                carry    = temp[8];
                overflow = (A == 8'h7F);
            end

            ARITH_DEC: begin
                temp     = {1'b0, A} - 9'd1;
                result   = temp[7:0];
                carry    = temp[8];
                overflow = (A == 8'h80);
            end

            default: begin
                result   = 8'd0;
                carry    = 1'b0;
                overflow = 1'b0;
            end
        endcase
    end

endmodule 
