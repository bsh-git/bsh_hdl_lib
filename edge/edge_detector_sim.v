`timescale 1ns / 1ps
/* verilator lint_off STMTDLY */

module edge_detector_sim ();

    reg clk = 0;
    reg sig = 0;
    reg rst_n = 0;

    wire r, f;
    wire r2, f2;

    always #2 begin
        clk  <= !clk;
    end


    edge_detector detector(sig, clk, rst_n, r, f);
    edge_detector_s detector_s(sig, clk, rst_n, r2, f2);

    initial begin
        $display("simulation start");

        #10 rst_n = 1;
        #10 sig = 1;
        #11 sig = 0;
        #10 sig = 1;
        #20 sig = 0;
        #10 sig = 1;
        #13 sig = 1;
        #10 rst_n = 0;
        #10 sig = 0;
        #10 sig = 1;
        #10 rst_n = 1;
        #10 sig = 0;
        #10 sig = 1;
        #10 rst_n = 0;
        #10 sig = 0;
        #10 rst_n = 1;
        #10 sig = 1;
        #10 sig = 0;
        $display("simulation end");
        $finish;

    end // initial begin

endmodule // edge_detector_sim
