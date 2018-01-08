`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/29/2017 11:32:38 AM
// Design Name: 
// Module Name: knight
// Project Name: knight rider pattern
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module knight # (
		 parameter integer WIDTH = 8
		 )
   (
    output reg [WIDTH-1:0] led,
    input 		   clk_src,
    input wire [23:0] 	   divider
    //	   input 	    reset
    );
   

   reg 			dir;
   wire 		clk;
   

   variable_divider #(24) div(.clk_in(clk_src), .load(divider), .clk_out(clk));

   always @(posedge clk) begin
      if (dir == 1) begin
	 if (led == 0)
	   led <= 1;
	 else if (led == 1)
	   led <= 2'b11;
	 else if (led[WIDTH-1:WIDTH-2] == 2'b10) begin
	    led <= 0;
	    dir <= 0;
	 end
	 else
	   led <= led << 1;
      end
      else begin
	 if (led == 0) begin
	    led[WIDTH-2:0] <= 0;
	    led[WIDTH-1] <= 1;
	 end
	 else if (led[WIDTH-1:WIDTH-2] == 2'b10)
	   led[WIDTH-1:WIDTH-2] <= 2'b11;
	 else if (led == 1) begin
	    led <= 0;
	    dir <= 1;
	 end
	 else
	   led <= led >> 1;
      end
   end

 			
endmodule
