////////////////////////////////////////////////////////////////
//
// Pulse Width Modulator
//

module pwd #
  (
   parameter integer WIDTH = 16
   )
   (
    input clk,
    input [WIDTH-1:0] low_time,
    input [WIDTH-1:0] high_time,
    output reg out
    );


   reg [WIDTH-1:0] counter = 0;

   always @(posedge clk) begin
      if (high_time == 0)
	out = 0;
      else if (low_time == 0)
	out = 1;
      else if (out == 0) begin
	 if (counter != low_time)
	    counter = counter + 1;
	 else begin
	    counter = 0;
	    out = 1;
	 end
      end
      else begin
	 if (counter != high_time)
	    counter = counter + 1;
	 else begin
	    counter = 0;
	    out = 0;
	 end

      end
   end
   
endmodule
	     
