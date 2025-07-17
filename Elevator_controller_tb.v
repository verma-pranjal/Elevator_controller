`timescale 1ns/1ps

module Elevator_controller_tb;

  // Inputs
  reg clk;
  reg reset;
  reg [3:0] req;

  // Outputs
  wire up;
  wire down;
  wire door_open;
  wire [1:0] curr_floor;

  // Instantiate the Elevator Controller
  Elevator_controller uut (
    .clk(clk),
    .reset(reset),
    .req(req),
    .up(up),
    .down(down),
    .door_open(door_open),
    .curr_floor(curr_floor)
  );

  // Clock generation
  always #5 clk = ~clk;  // 10 ns clock period

  initial begin
    // Initialize
    clk = 0;
    reset = 1;
    req = 4'b0000;

    #10;
    reset = 0;

    // Request at floor 2
    #10;
    req = 4'b0100;

    // Wait a few cycles to simulate movement
    #100;
    
    // Request at floor 0
    req = 4'b0101;

    #100;

    // Reset in middle
    reset = 1;
    #10;
    reset = 0;

    // Another request at floor 3
    req = 4'b1000;
    #100;

    // Finish simulation
    $finish;
  end

endmodule
