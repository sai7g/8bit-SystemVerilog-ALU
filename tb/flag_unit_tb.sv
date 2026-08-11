`timescale 1ns/1ps

module flag_unit_tb;

    logic [7:0] final_result;
    logic       arith_carry, arith_overflow;
    logic [2:0] result_sel;
    logic       zero_flag, carry_flag, overflow_flag, negative_flag, parity_flag;

    flag_unit dut (
        .final_result(final_result),
        .arith_carry(arith_carry), .arith_overflow(arith_overflow),
        .result_sel(result_sel),
        .zero_flag(zero_flag), .carry_flag(carry_flag),
        .overflow_flag(overflow_flag), .negative_flag(negative_flag),
        .parity_flag(parity_flag)
    );

    initial begin
        $dumpfile("flag_unit_tb.vcd");
        $dumpvars(0, flag_unit_tb);

        $monitor("t=%0t result=%h sel=%b arith_c=%b arith_v=%b | Z=%b C=%b V=%b N=%b P=%b",
                  $time, final_result, result_sel, arith_carry, arith_overflow,
                  zero_flag, carry_flag, overflow_flag, negative_flag, parity_flag);

        // Arithmetic result, zero, with carry present
        final_result = 8'h00; arith_carry = 1'b1; arith_overflow = 1'b0; result_sel = 3'b000; #10;

        // Arithmetic result, negative (MSB set), overflow present
        final_result = 8'h81; arith_carry = 1'b0; arith_overflow = 1'b1; result_sel = 3'b000; #10;

        // Arithmetic result, positive, even parity (0x03 = 2 ones)
        final_result = 8'h03; arith_carry = 1'b0; arith_overflow = 1'b0; result_sel = 3'b000; #10;

        // Non-arithmetic result (logic op) - carry/overflow must be gated low
        final_result = 8'hFF; arith_carry = 1'b1; arith_overflow = 1'b1; result_sel = 3'b001; #10;

        // Non-arithmetic result (compare op), zero result
        final_result = 8'h00; arith_carry = 1'b1; arith_overflow = 1'b1; result_sel = 3'b100; #10;

        $display("flag_unit_tb: All test vectors applied.");
        $finish;
    end

endmodule : flag_unit_tb
