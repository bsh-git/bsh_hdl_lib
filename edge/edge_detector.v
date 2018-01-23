module edge_detector
    (
     input wire  sig_in,
     input wire  clk,
     input wire  reset_n,
     output wire sig_out);

    reg         delay0 = 0;
    reg         delay1 = 0;

    always @(posedge clk) begin
        if (!reset_n) begin
            delay0 <= 0;
            delay1 <= 0;
        end
        else begin
            delay0 <= sig_in;
            delay1 <= delay0;
        end
    end

    assign sig_out = delay0 & !delay1;
endmodule; // edge_detector
