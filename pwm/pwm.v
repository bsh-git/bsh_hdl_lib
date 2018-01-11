////////////////////////////////////////////////////////////////
//
// Pulse Width Modulator
//
//  |~~~~~~~~~~~~~~~~|_____|~~~~~~~~~~~~~~~~|_____|~~  out
//  _____________________|~|____________________|~|__  last_cycle
//  | <- wave_length+1   ->|
//  | <- high_time ->|
//

module pwm #
  (
   parameter integer WIDTH = 16
   )
   (
    input clk,
    input [WIDTH-1:0] wave_length,
    input [WIDTH-1:0] high_time,
    output reg out,
    output last_cycle
    );


   (* mark_debug = "TRUE" *) reg [WIDTH-1:0] counter = -1;
   reg 	   last = 0;

   assign counter_out = counter;
   assign last_cycle = last;
   
   always @(posedge clk) begin
      counter = counter + 1;
      
      if (counter == 0) begin
	 last <= 0;
	 if (high_time != 0)
	   out <= 1;
      end
      
      if (counter == high_time)
	out <= 0;
      if (counter == wave_length) begin
	 counter <= -1;
	 last <= 1;
      end
      
   end

endmodule
	     
