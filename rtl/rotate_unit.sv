import alu_pkg::*;

module rotate_unit (
    input  logic [7:0] A,
    input  logic [7:0] B,
    input  logic       rotate_sel,
    output logic [7:0] result
);

    logic [2:0] rotamt;
    assign rotamt = B[2:0];

    always_comb begin
        if (rotamt == 3'd0) begin
            result = A;
        end
        else begin
            unique case (rotate_sel)
                ROTATE_LEFT : result = (A << rotamt) | (A >> (4'd8 - rotamt));
                ROTATE_RIGHT: result = (A >> rotamt) | (A << (4'd8 - rotamt));
                default     : result = 8'd0;
            endcase
        end
    end

endmodule
