module Elevator_controller(
input clk,
input reset,
input [3:0] req,
output reg up,
output reg down,
output reg door_open,
output reg [1:0] curr_floor
    );

parameter IDLE = 3'b000; // Elevator is stationary, waiting for request
parameter Check = 3'b001; // Check which direction to move (up/down)
parameter move_up = 3'b010;
parameter move_down = 3'b011;
parameter Door_open = 3'b100;

reg [2:0] curr_state, next_state;
reg [3:0] request_register;
integer i;
reg found;

// Request register logic
always @(posedge clk or posedge reset) begin
    if (reset)
        request_register <= 4'b0000;
    else begin
        request_register <= req;
        if (door_open)
            request_register[curr_floor] <= 0;
    end
end

// Current state logic
always @(posedge clk or posedge reset) begin
    if (reset)
        curr_state <= IDLE;
    else
        curr_state <= next_state;
end

// Floor tracking logic
always @(posedge clk or posedge reset) begin
    if (reset)
        curr_floor <= 0;
    else if (up && curr_floor < 3)
        curr_floor <= curr_floor + 1;
    else if (down && curr_floor > 0)
        curr_floor <= curr_floor - 1;
end

// Next state logic
always @(*) begin
    next_state = curr_state;
    found = 0;

    case(curr_state)
        IDLE: begin
            if(request_register[curr_floor])
                next_state = Door_open;
            else
                next_state = Check;
        end

        Check: begin
            for(i = 3; i > curr_floor; i = i - 1) begin
                if(!found && request_register[i]) begin
                    next_state = move_up;
                    found = 1;
                end
            end
            for(i = 0; i < curr_floor; i = i + 1) begin
                if(!found && request_register[i]) begin
                    next_state = move_down;
                    found = 1;
                end
            end
            if (!found)
                next_state = IDLE;
        end

        move_up: begin
            next_state = IDLE;
        end

        move_down: begin
            next_state = IDLE;
        end

        Door_open: begin
            next_state = IDLE;
        end

        default: next_state = IDLE;
    endcase
end

// Output logic
always @(*) begin
    up = 0;
    down = 0;
    door_open = 0;

    case(curr_state)
        move_up: up = 1;
        move_down: down = 1;
        Door_open: door_open = 1;
    endcase
end


endmodule
