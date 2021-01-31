//a metronome
module top(
	input sys_clk, //onboard clock
    input sys_rst_n, // reset input
	output reg speaker,
    output reg [2:0] led
);


//TODO a toggle between 100, 115

reg [23:0] counter;
reg [0:1] tick;

parameter FREQ = 24000000;
parameter BPM = 90;
parameter BPM_DELAY = FREQ/BPM*60;
parameter BEEP_LENGTH_MS = 60;
//TODO parametrize delay as well
//parameter BEEP_DELAY = FREQ / (1/(BEEP_LENGTH_MS/1000));
parameter BEEP_DELAY = 50_000;

always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) begin
        speaker <= 1'b1;
        counter <= 24'd0;
        tick <= 1'b0;
    end   
    else if(counter == BPM_DELAY) begin
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
