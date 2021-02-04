module button_debouncer(
    input clk,
    input button, //active-high synchronized noisy button input
    output reg button_state,
    output reg button_event,
    output reg button_pressed, // pulse when pressed
    output reg button_released // pulse when released
);

// the output will change when the input will hold state for N clock cycles

// this seems like a good enough hold time
// 12 000 000 / 65 536 = ~ 5.4 ms
reg [24:0] counter;

reg button_debounced;
reg button_last;

initial begin
    counter = 0;
    button_state = 1'b0;
    button_last = 1'b0;
    button_pressed = 1'b0;
    button_released = 1'b0;
end

always @(posedge clk) begin
    button_event <= 0;
    button_pressed <= 0;
    button_released <= 0;
    //reset state on 
    if(button != button_last) begin
        counter <= 0;   
    end else begin
        if (counter == 65_535) begin
            button_event <= 1;
            button_pressed <= button_last;
            button_released <= ~button_last;
            button_state <= button_last;
            counter <= counter + 1;
        end else if(counter == 65_536) begin
            button_state <= button_last;
        end else begin
            counter <= counter + 1;
        end
    end
    button_last <= button;
end

endmodule