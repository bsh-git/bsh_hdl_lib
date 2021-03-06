`timescale 10ns / 1ns
module triangle_wave_sim ();
    reg clock = 0;

    wire [3:0] wave_out;

    reg [3:0]  high = 13;
    reg [3:0]  low  = 0;


    triangle_wave #(4) w0(.clk(clock), .low_in(low), .high_in(high), .mod_out(wave_out));


    always #10 begin
        clock <= !clock;
    end

    initial begin
        $display("simulation start");
        //#100 enable <= 1;
        #2000 low <= 5;
        #2000 high <= 10;
        #2000 high <= 13;
        #3000 $display("simulation end"); $finish;
    end
endmodule // triangle_wave_sim
