`timescale 1ns/1ps

module logical_unit_tb;

    logic [7:0] A, B;
    logic [1:0] logic_sel;
    logic [7:0] result;

    logical_unit dut (
        .A(A), .B(B), .logic_sel(logic_sel), .result(result)
    );

    initial begin
        $dumpfile("logical_unit_tb.vcd");
        $dumpvars(0, logical_unit_tb);

        $monitor("t=%0t A=%h B=%h sel=%b | result=%h", $time, A, B, logic_sel, result);

        A = 8'hF0; B = 8'h0F; logic_sel = 2'b00; #10; // AND -> 00
        A = 8'hAA; B = 8'h55; logic_sel = 2'b00; #10; // AND -> 00
        A = 8'hFF; B = 8'hFF; logic_sel = 2'b00; #10; // AND -> FF

        A = 8'hF0; B = 8'h0F; logic_sel = 2'b01; #10; // OR -> FF
        A = 8'h00; B = 8'h00; logic_sel = 2'b01; #10; // OR -> 00

        A = 8'hAA; B = 8'h55; logic_sel = 2'b10; #10; // XOR -> FF
        A = 8'hFF; B = 8'hFF; logic_sel = 2'b10; #10; // XOR -> 00

        A = 8'h00; B = 8'h00; logic_sel = 2'b11; #10; // NOT A -> FF
        A = 8'hFF; B = 8'h00; logic_sel = 2'b11; #10; // NOT A -> 00
        A = 8'hA5; B = 8'h00; logic_sel = 2'b11; #10; // NOT A -> 5A

        $display("logical_unit_tb: All test vectors applied.");
        $finish;
    end

endmodule : logical_unit_