package alu_pkg;

    // Top-level Opcode map (4 bits)
    localparam logic [3:0] OP_ADD = 4'b0000;
    localparam logic [3:0] OP_SUB = 4'b0001;
    localparam logic [3:0] OP_INC = 4'b0010;
    localparam logic [3:0] OP_DEC = 4'b0011;
    localparam logic [3:0] OP_AND = 4'b0100;
    localparam logic [3:0] OP_OR  = 4'b0101;
    localparam logic [3:0] OP_XOR = 4'b0110;
    localparam logic [3:0] OP_NOT = 4'b0111;
    localparam logic [3:0] OP_SHL = 4'b1000;
    localparam logic [3:0] OP_SHR = 4'b1001;
    localparam logic [3:0] OP_SRA = 4'b1010;
    localparam logic [3:0] OP_ROL = 4'b1011;
    localparam logic [3:0] OP_ROR = 4'b1100;
    localparam logic [3:0] OP_EQ  = 4'b1101;
    localparam logic [3:0] OP_GT  = 4'b1110;
    localparam logic [3:0] OP_LT  = 4'b1111;

    // Arithmetic Unit select (arith_sel)
    localparam logic [1:0] ARITH_ADD = 2'b00;
    localparam logic [1:0] ARITH_SUB = 2'b01;
    localparam logic [1:0] ARITH_INC = 2'b10;
    localparam logic [1:0] ARITH_DEC = 2'b11;

    // Logical Unit select (logic_sel)
    localparam logic [1:0] LOGIC_AND = 2'b00;
    localparam logic [1:0] LOGIC_OR  = 2'b01;
    localparam logic [1:0] LOGIC_XOR = 2'b10;
    localparam logic [1:0] LOGIC_NOT = 2'b11;

    // Shift Unit select (shift_sel)
    localparam logic [1:0] SHIFT_LEFT          = 2'b00;
    localparam logic [1:0] SHIFT_RIGHT_LOGICAL = 2'b01;
    localparam logic [1:0] SHIFT_RIGHT_ARITH   = 2'b10;

    // Rotate Unit select (rotate_sel)
    localparam logic ROTATE_LEFT  = 1'b0;
    localparam logic ROTATE_RIGHT = 1'b1;

    // Comparator Unit select (compare_sel)
    localparam logic [1:0] COMPARE_EQ = 2'b00;
    localparam logic [1:0] COMPARE_GT = 2'b01;
    localparam logic [1:0] COMPARE_LT = 2'b10;

    localparam logic [7:0] CMP_EQUAL   = 8'b0000_0001;
    localparam logic [7:0] CMP_GREATER = 8'b0000_0010;
    localparam logic [7:0] CMP_LESS    = 8'b0000_0100;

    // Result Mux select (result_sel) - chooses active result bus
    localparam logic [2:0] RESULT_ARITH   = 3'b000;
    localparam logic [2:0] RESULT_LOGIC   = 3'b001;
    localparam logic [2:0] RESULT_SHIFT   = 3'b010;
    localparam logic [2:0] RESULT_ROTATE  = 3'b011;
    localparam logic [2:0] RESULT_COMPARE = 3'b100;

endpackage : alu_pkg
