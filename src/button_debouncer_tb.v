
`timescale 1ps / 1ps
module button_debouncer_tb  ; 
 
  wire  button_released   ; 
  wire  button_state   ; 
  reg    button   ; 
  wire  button_pressed   ; 
  wire  button_event   ; 
  reg    clk   ; 
  button_debouncer  
   DUT  ( 
       .button_released (button_released ) ,
      .button_state (button_state ) ,
      .button (button ) ,
      .button_pressed (button_pressed ) ,
      .button_event (button_event ) ,
      .clk (clk ) ); 



// "Clock Pattern" : dutyCycle = 50
// Start Time = 0 ps, End Time = 1 ns, Period = 100 ps
  initial
  begin
   repeat(100)
   begin
	   clk  = 1'b1  ;
	  #5  clk  = 1'b0  ;
	  #5 ;
// 1 ns, repeat pattern in loop.
   end
  end

initial begin

		
        // Add stimulus here
      	button = 1;
      	#2
      	button = 0;
      	#1
      	button = 1;
      	#3
      	button = 0;
      	#2
      	button = 1;
	#9
	button = 0;
	#7
      	button = 1;
      	#2
      	button = 0;
      	#1
      	button = 1;
      	#3
      	button = 0;
      	#2
      	button = 1;
	#20
	button = 0;
	#35

	button = 1;
      	#200;

	button = 0;
	#170;
		
		
	#160;
	end

  initial
	#2000 $stop;
endmodule
