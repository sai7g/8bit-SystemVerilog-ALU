`timescale 1ns/1ps

module control_unit_tb;

    logic [3:0] Opcode;
    logic [1:0] arith_sel;
    logic [1:0] logic_sel;
    logic [1:0] shift_sel;
    logic       rotate_sel;
    logic [1:0] compare_sel;
    logic [2:0] result_sel;

    control_unit dut (
        .Opcode(Opcode),
        .arith_sel(arith_sel), .logic_sel(logic_sel), .shift_sel(shift_sel),
        .rotate_sel(rotate_sel), .compare_sel(compare_sel), .result_sel(result_sel)
    );

    initial begin
        $dumpfile("control_unit_tb.vcd");
        $dumpvars(0, control_unit_tb);

        $monitor("t=%0t Opcode=%b | arith_sel=%b logic_sel=%b shift_sel=%b rotate_sel=%b compare_sel=%b result_sel=%b",
                  $time, Opcode, arith_sel, logic_sel, shift_sel, rotate_sel, compare_sel, result_sel);

        for (int i = 0; i < 16; i++) begin
            Opcode = i[3:0];
            #10;
        end

        $display("control_unit_tb: All 16 opcodes exercised.");
        $finish;
    end

endmodule 
