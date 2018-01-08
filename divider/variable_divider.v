module variable_divider #
  (
   parameter integer WIDTH = 24
   )
   (
    input 	      clk_in,
    input [WIDTH-1:0] load, 
    output reg 	      clk_out 
    );

   reg [WIDTH-1:0] 	    counter;

   always @(posedge clk_in) begin
      
      if (counter != 0)
	counter <= counter -1;
      else begin
	 counter <= load;
	 clk_out <= ~clk_out;

      end
   end

   
endmodule
   
				  
