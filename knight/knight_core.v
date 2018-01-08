`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/29/2017 11:32:38 AM
// Design Name: 
// Module Name: led
// Project Name: 
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


module knight_core # (
		 parameter integer WIDTH = 8
		 )
   (
    output reg [WIDTH-1:0]  led,
    input 	      clk_src,
    input wire [23:0] divider,
    //	   input 	    reset
    );
   

   reg 			dir;

   wire 		clk;
   

//   fixed_divider #(24, 24'h7fffff) div(.clk_in(clk_src), .clk_out(clk));
   variable_divider #(24) div(.clk_in(clk_src), .load(divider), .clk_out(clk));

   always @(posedge clk or posedge reset) begin
      if (reset) begin
	 led <= 8'h5a;
	 dir <= 1;
      end
      else begin
	 if (dir == 1) begin
	    if (led == 0)
	      led <= 1;
	    else if (led == 8'b00000001)
	      led <= 8'b00000011;
	    else if (led == 8'b10000000) begin
	       led <= 0;
	       dir <= 0;
	    end
	    else
	      led <= led << 1;
	 end
	 else begin
	    if (led == 0)
	      led <= 8'b10000000;
	    else if (led == 8'b10000000)
	      led <= 8'b11000000;
	    else if (led == 8'b00000001) begin
	       led <= 0;
	       dir <= 1;
	    end
	    else
	      led <= led >> 1;
	 end
      end

   end
 			
endmodule
