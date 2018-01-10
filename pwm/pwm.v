////////////////////////////////////////////////////////////////
//
// Pulse Width Modulator
//
//  |~~~~~~~~~~~~~~~~|_____|~~~~~~~~~~~~~~~~|_____
//  | <- wave_length     ->|
//  | <- high_time ->|
//

module pwd #
  (
   parameter integer WIDTH = 16
   )
   (
    input clk,
    input [WIDTH-1:0] wave_length,
    input [WIDTH-1:0] high_time,
    output reg out
    );


   reg [WIDTH-1:0] counter = ~0;

   always @(posedge clk) begin
      counter = counter + 1;
      if (counter == high_time)
	out = 0;
      if (counter == wave_length) begin
	 counter = 0;
	 if (high_time != 0)
	   out = 1;
      end	 
   end
   
endmodule
	     
