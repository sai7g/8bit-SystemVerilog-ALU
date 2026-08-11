`timescale 1ns/1ps

module result_mux_tb;

    logic [7:0] arith_result, logic_result, shift_result, rotate_result, compare_result;
    logic [2:0] result_sel;
    logic [7:0] final_result;

    result_mux dut (
        .arith_result(arith_result), .logic_result(logic_result),
        .shift_result(shift_result), .rotate_result(rotate_result),
        .compare_result(compare_result), .result_sel(result_sel),
        .final_result(final_result)
    );

    initial begin
        $dumpfile("result_mux_tb.vcd");
        $dumpvars(0, result_mux_tb);

        $monitor("t=%0t sel=%b | final_result=%h", $time, result_sel, final_result);

        arith_result   = 8'h11;
        logic_result   = 8'h22;
        shift_result   = 8'h33;
        rotate_result  = 8'h44;
        compare_result = 8'h55;

        result_sel = 3'b000; #10; // expect 11
        result_sel = 3'b001; #10; // expect 22
        result_sel = 3'b010; #10; // expect 33
        result_sel = 3'b011; #10; // expect 44
        result_sel = 3'b100; #10; // expect 55
        result_sel = 3'b111; #10; // undefined/default -> expect 00

        $display("result_mux_tb: All select values exercised.");
        $finish;
    end

endmodule 
