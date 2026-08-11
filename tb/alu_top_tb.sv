`timescale 1ns/1ps

module alu_top_tb;

    logic [7:0] A, B;
    logic [3:0] Opcode;
    logic [7:0] Result;
    logic       Zero_Flag, Carry_Flag, Overflow_Flag, Negative_Flag, Parity_Flag;

    alu_top dut (
        .A(A), .B(B), .Opcode(Opcode),
        .Result(Result),
        .Zero_Flag(Zero_Flag), .Carry_Flag(Carry_Flag),
        .Overflow_Flag(Overflow_Flag), .Negative_Flag(Negative_Flag),
        .Parity_Flag(Parity_Flag)
    );

    task automatic apply_test(input logic [7:0] tA, input logic [7:0] tB,
                               input logic [3:0] tOp, input string tName);
        begin
            A = tA; B = tB; Opcode = tOp;
            #10;
            $display("%-10s A=%h B=%h Op=%b | Result=%h  Z=%b C=%b V=%b N=%b P=%b",
                       tName, A, B, Opcode, Result,
                       Zero_Flag, Carry_Flag, Overflow_Flag, Negative_Flag, Parity_Flag);
        end
    endtask

    initial begin
        $dumpfile("alu_top_tb.vcd");
        $dumpvars(0, alu_top_tb);

        $monitor("t=%0t Op=%b A=%h B=%h | Result=%h Z=%b C=%b V=%b N=%b P=%b",
                  $time, Opcode, A, B, Result,
                  Zero_Flag, Carry_Flag, Overflow_Flag, Negative_Flag, Parity_Flag);

        // Arithmetic
        apply_test(8'h10, 8'h20, 4'b0000, "ADD");
        apply_test(8'hFF, 8'h01, 4'b0000, "ADD_CARRY");
        apply_test(8'h7F, 8'h01, 4'b0000, "ADD_OVF");
        apply_test(8'h30, 8'h10, 4'b0001, "SUB");
        apply_test(8'h10, 8'h20, 4'b0001, "SUB_BORROW");
        apply_test(8'h7F, 8'h00, 4'b0010, "INC_OVF");
        apply_test(8'h00, 8'h00, 4'b0011, "DEC_WRAP");

        // Logical
        apply_test(8'hF0, 8'h0F, 4'b0100, "AND");
        apply_test(8'hF0, 8'h0F, 4'b0101, "OR");
        apply_test(8'hAA, 8'h55, 4'b0110, "XOR");
        apply_test(8'hA5, 8'h00, 4'b0111, "NOT");

        // Shift
        apply_test(8'h01, 8'd7, 4'b1000, "SHL");
        apply_test(8'hFF, 8'd7, 4'b1001, "SHR_LOG");
        apply_test(8'h80, 8'd1, 4'b1010, "SHR_ARITH");

        // Rotate
        apply_test(8'h81, 8'd1, 4'b1011, "ROL");
        apply_test(8'h81, 8'd1, 4'b1100, "ROR");

        // Comparator
        apply_test(8'h55, 8'h55, 4'b1101, "CMP_EQ");
        apply_test(8'h80, 8'h10, 4'b1110, "CMP_GT");
        apply_test(8'h10, 8'h80, 4'b1111, "CMP_LT");

        // Zero-result edge case via AND
        apply_test(8'hF0, 8'h0F, 4'b0100, "AND_ZERO");

        $display("alu_top_tb: All opcode test vectors applied successfully.");
        $finish;
    end

endmodule : alu_top_tb
