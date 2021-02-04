//a metronome
module top(
	input sys_clk, //onboard clock
    input button_b_n, 
    input button_a_n,
	output reg speaker,
    output reg [2:0] led
);


//TODO a toggle between 100, 115

reg [24:0] counter;
reg [0:1] tick;
reg [7:0] bpm;

parameter FREQ = 24000000;
parameter BPM = 90;
parameter BPM_DELAY = FREQ/BPM*60;
parameter BEEP_LENGTH_MS = 60;
//TODO parametrize delay as well
//parameter BEEP_DELAY = FREQ / (1/(BEEP_LENGTH_MS/1000));
parameter BEEP_DELAY = 60_000;

reg speed = 1'b0;

wire button_a_pressed;
wire button_b_pressed;

button_synchronizer synchronizer_a(
    .clk(sys_clk),
    .in(~button_a_n), 
    .out(button_sync)
);

button_debouncer debouncer_a(
    .clk(sys_clk),
    .button(button_sync), //active-high synchronized noisy button input
    .button_state(button_state),
    .button_event(button_event),
    .button_pressed(button_a_pressed),
    .button_released(button_released)
);

initial begin
    speaker <= 1'b1;
    counter <= 24'd0;
    tick <= 1'b0;
    bpm <= 90;
end

always @(posedge sys_clk) begin
    if(button_a_pressed) begin
        speed = ~speed;
    end
end

always @(posedge sys_clk) begin    
    if((~speed && counter == 20_000_000) || (speed && counter == 12_000_000)) begin
        speaker <= 1'b0;
        case(tick)
            2'b00: led <= 3'b011;
            2'b01: led <= 3'b110;
            2'b10: led <= 3'b101;
            2'b11: led <= 3'b000;
        endcase
        tick <= tick + 1;
        counter <= 0;
    end else if(counter == BEEP_DELAY) begin
        speaker <= 1'b1;
        counter <= counter + 1;
    end else
        counter <= counter + 1;
end

endmodule
