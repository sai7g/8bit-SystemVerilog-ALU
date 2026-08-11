`timescale 1ns/1ps

module arithmetic_unit_tb;

    logic [7:0] A, B;
    logic [1:0] arith_sel;
    logic [7:0] result;
    logic       carry, overflow;

    arithmetic_unit dut (
        .A(A), .B(B), .arith_sel(arith_sel),
        .result(result), .carry(carry), .overflow(overflow)
    );

    initial begin
        $dumpfile("arithmetic_unit_tb.vcd");
        $dumpvars(0, arithmetic_unit_tb);

        $monitor("t=%0t A=%h B=%h sel=%b | result=%h carry=%b overflow=%b",
                  $time, A, B, arith_sel, result, carry, overflow);

        // ADD normal
        A = 8'h10; B = 8'h20; arith_sel = 2'b00; #10;
        // ADD with carry out
        A = 8'hFF; B = 8'h01; arith_sel = 2'b00; #10;
        // ADD signed overflow (127 + 1)
        A = 8'h7F; B = 8'h01; arith_sel = 2'b00; #10;

        // SUB normal
        A = 8'h30; B = 8'h10; arith_sel = 2'b01; #10;
        // SUB with borrow (A<B)
        A = 8'h10; B = 8'h20; arith_sel = 2'b01; #10;
        // SUB signed overflow (0x80 - 0x01)
        A = 8'h80; B = 8'h01; arith_sel = 2'b01; #10;

        // INC normal
        A = 8'h05; B = 8'h00; arith_sel = 2'b10; #10;
        // INC overflow edge (0x7F -> 0x80)
        A = 8'h7F; B = 8'h00; arith_sel = 2'b10; #10;
        // INC wrap (0xFF -> 0x00, carry)
        A = 8'hFF; B = 8'h00; arith_sel = 2'b10; #10;

        // DEC normal
        A = 8'h05; B = 8'h00; arith_sel = 2'b11; #10;
        // DEC overflow edge (0x80 -> 0x7F)
        A = 8'h80; B = 8'h00; arith_sel = 2'b11; #10;
        // DEC wrap (0x00 -> 0xFF, borrow)
        A = 8'h00; B = 8'h00; arith_sel = 2'b11; #10;

        $display("arithmetic_unit_tb: All test vectors applied.");
        $finish;
    end

endmodule : arithmetic_unit_tb
