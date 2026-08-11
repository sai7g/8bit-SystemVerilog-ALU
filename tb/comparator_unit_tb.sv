`timescale 1ns/1ps

module comparator_unit_tb;

    logic [7:0] A, B;
    logic [1:0] compare_sel;
    logic [7:0] result;

    comparator_unit dut (
        .A(A), .B(B), .compare_sel(compare_sel), .result(result)
    );

    initial begin
        $dumpfile("comparator_unit_tb.vcd");
        $dumpvars(0, comparator_unit_tb);

        $monitor("t=%0t A=%h B=%h sel=%b | result=%b", $time, A, B, compare_sel, result);

        // Equal select
        A = 8'h55; B = 8'h55; compare_sel = 2'b00; #10; // -> 00000001
        A = 8'h55; B = 8'h44; compare_sel = 2'b00; #10; // -> 00000000

        // Greater-than select
        A = 8'h80; B = 8'h10; compare_sel = 2'b01; #10; // -> 00000010
        A = 8'h10; B = 8'h80; compare_sel = 2'b01; #10; // -> 00000000
        A = 8'h10; B = 8'h10; compare_sel = 2'b01; #10; // -> 00000000

        // Less-than select
        A = 8'h10; B = 8'h80; compare_sel = 2'b10; #10; // -> 00000100
        A = 8'h80; B = 8'h10; compare_sel = 2'b10; #10; // -> 00000000
        A = 8'h00; B = 8'hFF; compare_sel = 2'b10; #10; // -> 00000100

        $display("comparator_unit_tb: All test vectors applied.");
        $finish;
    end

endmodule