import alu_pkg::*;

module control_unit (
    input  logic [3:0] Opcode,
    output logic [1:0] arith_sel,
    output logic [1:0] logic_sel,
    output logic [1:0] shift_sel,
    output logic       rotate_sel,
    output logic [1:0] compare_sel,
    output logic [2:0] result_sel
);

    always_comb begin
        // Safe defaults - avoid inferred latches
        arith_sel   = 2'b00;
        logic_sel   = 2'b00;
        shift_sel   = 2'b00;
        rotate_sel  = 1'b0;
        compare_sel = 2'b00;
        result_sel  = RESULT_ARITH;

        unique case (Opcode)
            OP_ADD: begin arith_sel = ARITH_ADD; result_sel = RESULT_ARITH; end
            OP_SUB: begin arith_sel = ARITH_SUB; result_sel = RESULT_ARITH; end
            OP_INC: begin arith_sel = ARITH_INC; result_sel = RESULT_ARITH; end
            OP_DEC: begin arith_sel = ARITH_DEC; result_sel = RESULT_ARITH; end

            OP_AND: begin logic_sel = LOGIC_AND; result_sel = RESULT_LOGIC; end
            OP_OR : begin logic_sel = LOGIC_OR;  result_sel = RESULT_LOGIC; end
            OP_XOR: begin logic_sel = LOGIC_XOR; result_sel = RESULT_LOGIC; end
            OP_NOT: begin logic_sel = LOGIC_NOT; result_sel = RESULT_LOGIC; end

            OP_SHL: begin shift_sel = SHIFT_LEFT;          result_sel = RESULT_SHIFT; end
            OP_SHR: begin shift_sel = SHIFT_RIGHT_LOGICAL; result_sel = RESULT_SHIFT; end
            OP_SRA: begin shift_sel = SHIFT_RIGHT_ARITH;   result_sel = RESULT_SHIFT; end

            OP_ROL: begin rotate_sel = ROTATE_LEFT;  result_sel = RESULT_ROTATE; end
            OP_ROR: begin rotate_sel = ROTATE_RIGHT; result_sel = RESULT_ROTATE; end

            OP_EQ : begin compare_sel = COMPARE_EQ; result_sel = RESULT_COMPARE; end
            OP_GT : begin compare_sel = COMPARE_GT; result_sel = RESULT_COMPARE; end
            OP_LT : begin compare_sel = COMPARE_LT; result_sel = RESULT_COMPARE; end

            default: begin
                arith_sel  = ARITH_ADD;
                result_sel = RESULT_ARITH;
            end
        endcase
    end

endmodule : control_unit
