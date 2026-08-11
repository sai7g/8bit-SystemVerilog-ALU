`timescale 1ns/1ps

module shift_unit_tb;

    logic [7:0] A, B;
    logic [1:0] shift_sel;
    logic [7:0] result;

    shift_unit dut (
        .A(A), .B(B), .shift_sel(shift_sel), .result(result)
    );

    initial begin
        $dumpfile("shift_unit_tb.vcd");
        $dumpvars(0, shift_unit_tb);

        $monitor("t=%0t A=%h shamt=%0d sel=%b | result=%h", $time, A, B[2:0], shift_sel, result);

        // Logical left shift
        A = 8'h01; B = 8'd1; shift_sel = 2'b00; #10; // -> 02
        A = 8'h01; B = 8'd7; shift_sel = 2'b00; #10; // -> 80
        A = 8'hFF; B = 8'd4; shift_sel = 2'b00; #10; // -> F0

        // Logical right shift
        A = 8'h80; B = 8'd1; shift_sel = 2'b01; #10; // -> 40
        A = 8'hFF; B = 8'd7; shift_sel = 2'b01; #10; // -> 01
        A = 8'h80; B = 8'd0; shift_sel = 2'b01; #10; // -> 80 (no shift)

        // Arithmetic right shift (sign-extend)
        A = 8'h80; B = 8'd1; shift_sel = 2'b10; #10; // -> C0 (negative, sign preserved)
        A = 8'h7F; B = 8'd1; shift_sel = 2'b10; #10; // -> 3F (positive)
        A = 8'hF0; B = 8'd4; shift_sel = 2'b10; #10; // -> FF (sign-extended)

        $display("shift_unit_tb: All test vectors applied.");
        $finish;
    end

endmodule