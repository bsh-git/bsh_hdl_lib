////////////////////////////////////////////////////////////////
//
//

`define UP 0
`define DOWN 1

//`define ALTERNATIVE

`ifndef ALTERNATIVE
module triangle_wave #
    (
     parameter integer WIDTH = 8
     )
    (
     input              clk,
     input [WIDTH-1:0]  low_in,
     input [WIDTH-1:0]  high_in,
     output [WIDTH-1:0] mod_out
     );

    reg [WIDTH-1:0]     counter = 0;
    reg                 dir = `UP;

    assign mod_out = counter;

    always @(posedge clk) begin

        if (dir == `DOWN) begin
            if (counter > low_in)
                counter <= counter - 1;
            else begin
                dir <= `UP;
                counter <= counter + 1;
            end
        end else begin
            if (counter < high_in)
                counter <= counter + 1;
            else begin
                dir <= `DOWN;
                counter <= counter - 1;
            end
        end // else: !if(dir == `DOWN)
    end

endmodule // triangle_wave

`else

/*
 カウンターと low, high を比較する時、不等号比較よりも等号比較の方が回路が簡単ではあるが、
 波形の途中で low, high が変更された場合におかしくならないようにするために余分な工夫が必要ななる。
 合成後のセル数では、こちらの方が大きくなってしまった。
 */
module triangle_wave #
    (
     parameter integer WIDTH = 8
     )
    (
     input              clk,
     input [WIDTH-1:0]  low_in,
     input [WIDTH-1:0]  high_in,
     output [WIDTH-1:0] mod_out
     );


    reg [WIDTH-1:0]     high;
    reg [WIDTH-1:0]     low;
    reg [WIDTH-1:0]     counter = 0;
    reg                 dir = `UP;
    reg                 init = 0;

    assign mod_out = counter;

    always @(posedge clk) begin

        if (init) begin
            high= high_in;
            low = low_in;
            init = 1;
        end

        if (dir == `DOWN) begin
            if (counter != low)
                counter <= counter - 1;
            else begin
                dir <= `UP;
                high <= high_in;
                counter <= counter + 1;
            end
        end else begin
            if (counter != high)
                counter <= counter + 1;
            else begin
                dir <= `DOWN;
                low <= low_in;
                counter <= counter - 2;
            end
        end // else: !if(dir == `DOWN)
    end

endmodule

`endif
