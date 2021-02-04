module speed_generator(
    input wire [3:0] speed,
    output reg [25:0] bpm_ticks
);
parameter FREQ = 24000000;

// MHz / bpm * (60 seconds in minute) / 2 clocks per decrement
always @(*) begin
    case (speed)
        4'd0: bpm_ticks = FREQ / 40 * 60 ;
        4'd1: bpm_ticks = FREQ / 60 * 60 ;
        4'd2: bpm_ticks = FREQ / 72 * 60 ;
        4'd3: bpm_ticks = FREQ / 80 * 60 ;
        4'd4: bpm_ticks = FREQ / 88 * 60 ;
        4'd5: bpm_ticks = FREQ / 96 * 60 ;
        4'd6: bpm_ticks = FREQ / 104 * 60 ;
        4'd7: bpm_ticks = FREQ / 112 * 60 ;
        4'd8: bpm_ticks = FREQ / 120 * 60 ;
        4'd9: bpm_ticks = FREQ / 132 * 60 ;
        4'd10: bpm_ticks = FREQ / 144 * 60 ;
        4'd11: bpm_ticks = FREQ / 152 * 60 ;
        4'd12: bpm_ticks = FREQ / 160 * 60 ;
        4'd13: bpm_ticks = FREQ / 176 * 60 ;
        4'd14: bpm_ticks = FREQ / 192 * 60 ;
        4'd15: bpm_ticks = FREQ / 208 * 60 ;

    endcase
end

endmodule