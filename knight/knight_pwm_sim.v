`timescale 10ns / 1ns
module knight_pwm_sim ();

   parameter integer N_LEDS = 8;
   reg 			 clock = 0;
   (* mark_debug = "TRUE" *) wire [N_LEDS-1:0] led;

   (* mark_debug = "TRUE" *) wire  pwmclk, dbgclk, waveclk;

//   divider #(16) divdbg(.clk_in(clock), .load(2000-1), .clk_out(dbgclk));
   divider #(16) div0(.clk_in(clock), .load(8000-1), .clk_out(pwmclk));
   divider #(8) div1(.clk_in(pwmclk), .load(40-1), .clk_out(waveclk));

   knight_pwm #(N_LEDS) knight(.pwm_clk(pwmclk), .mod_clk(waveclk), .led(led));

   always #10 begin
      clock <= !clock;
   end

   initial begin
      $display("simulation start");
   end

endmodule // knight_pwm_sim
