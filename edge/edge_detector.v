module edge_detector
    (
     input wire  sig_in,
     input wire  clk,
     input wire  reset_n,
     output wire rising,
     output wire falling);

    reg         delay0 = 0;
    reg         delay1 = 0;

    always @(posedge clk) begin
        if (!reset_n) begin
            delay0 <= sig_in;
            delay1 <= sig_in;
        end
        else begin
            delay0 <= sig_in;
            delay1 <= delay0;
        end
    end

    assign rising = delay0 & !delay1;
    assign falling = !delay0 & delay1;
endmodule // edge_detector
