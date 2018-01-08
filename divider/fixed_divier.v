module fixed_divider #
  (
   parameter integer DIV = 32'hffffffff,
   parameter integer WIDTH = 24
   )
   (
    input clk_in,
    output clk_out
    );

   wire [WIDTH-1:0] load;

   assign load = DIV;

   variable_divider #(WIDTH) vdiv(.clk_in(clk_in), .clk_out(clk_out),
				    .load(load));
endmodule
