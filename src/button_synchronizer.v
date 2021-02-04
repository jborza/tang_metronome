module button_synchronizer(
    input clk,
    input in, 
    output wire out
);

reg [2:0] sync_buffer;

// push state through flip flops to synchronize the input to the clock
always @(posedge clk) begin
    sync_buffer <= {sync_buffer[1:0], in};
end

assign out = sync_buffer[2];

endmodule