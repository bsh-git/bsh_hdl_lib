////////////////////////////////////////////////////////////////
//
// f_{out} = f_{in}/2(N+1)
//
module divider #(  parameter integer WIDTH = 24)
    (
     input             clk_in,
     input [WIDTH-1:0] load,
     output            clk_out
     );

    reg [WIDTH-1:0]    counter = 0;
    reg                val = 0;

    assign clk_out = val;

    always @(posedge clk_in) begin
        if (counter != 0)
            counter <= counter -1;
        else begin
            counter <= load;
            val <= ~val;
        end

    end

endmodule // divider
