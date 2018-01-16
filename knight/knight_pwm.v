//
//
//
//
module knight_pwm #
  (
   parameter integer N_LEDS = 8
   )
   (
    (* mark_debug = "TRUE" *) input wire 				 pwm_clk,
	(* mark_debug = "TRUE" *) input wire 				 mod_clk,
    output wire [N_LEDS-1:0] led
    );


   parameter integer 		 PWM_WIDTH = 4;
   parameter integer 		 DELAY = 8;

   (* mark_debug = "TRUE" *) reg [PWM_WIDTH-1:0] 		 vol[N_LEDS-1:0];
   (* mark_debug = "TRUE" *) wire 					 last[N_LEDS-1:0];

   (* mark_debug = "TRUE" *) reg [7:0] 				 counter = 0;

   always @(posedge mod_clk) begin
	  if (counter == DELAY * (N_LEDS + 3))
		counter = 0;
	  else
		counter = counter + 1;
   end

   function [PWM_WIDTH-1:0] current_vol (input integer index, input integer count);
	  if (count <= index * DELAY)
		current_vol = 0;
	  else if (count - index * DELAY < (1 << PWM_WIDTH))
		current_vol = count - index * DELAY;
	  else if (2 * ((1 << PWM_WIDTH) - 1) <= (count - index * DELAY))
		current_vol = 0;
	  else
		current_vol = 2 * ((1 << PWM_WIDTH) - 1) - (count - index * DELAY) ;
   endfunction


   generate
	  genvar i;

	  for (i = 0; i < N_LEDS; i = i + 1) begin
		 pwm #(PWM_WIDTH) pwm0(.clk(pwm_clk), .wave_length(~0), .high_time(vol[i]), .out(led[i]), .last_cycle(last[i]));

		 always @(posedge last[i]) begin
			vol[i] <= current_vol(i, counter);
		 end
	  end
   endgenerate
endmodule // knight_pwm
