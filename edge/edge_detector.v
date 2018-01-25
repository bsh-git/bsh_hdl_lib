////////////////////////////////////////////////////////////////
//
// Edge detector
//
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


////////////////////////////////////////////////////////////////
// Simpler version with only one filpflop.
//
// drawbacks are:
//
// While output from the above circuit  always has 1 T_{clk} wide,
// this circuit generates a shorter pulse.
// Also, this circuit outputs edge output when reset_n is negated.
//
module edge_detector_s
    (
     input wire  sig_in,
     input wire  clk,
     input wire  reset_n,
     output wire rising,
     output wire falling);

    reg         delay = 0;

    always @(posedge clk) begin
        if (!reset_n)
            delay <= 0;
        else
            delay <= sig_in;

    end

    assign rising = sig_in & !delay;
    assign falling = !sig_in & delay;
endmodule // edge_detector_s
