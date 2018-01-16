module pwm_sim ();
    reg clock = 0;

    wire pwm_out [3:0], pwm_last [3:0];

    // high=2, low=7
    pwm #(4) pwm0(.clk(clock), .wave_length(8), .high_time(2), .out(pwm_out[0]), .last_cycle(pwm_last[0]));

    // always low,
    pwm #(4) pwm1(.clk(clock), .wave_length(8), .high_time(0), .out(pwm_out[1]), .last_cycle(pwm_last[1]));
    // always high,
    pwm #(4) pwm2(.clk(clock), .wave_length(8), .high_time(9), .out(pwm_out[2]), .last_cycle(pwm_last[2]));

    // high=1, low=3
    pwm #(2) pwm3(.clk(clock), .wave_length(2'b11), .high_time(1), .out(pwm_out[3]), .last_cycle(pwm_last[3]));

    always #10 begin
        clock <= !clock;
    end

    initial begin
        $display("simulation start");
        #1000000000 $finish;
    end
endmodule // pwm_sim
