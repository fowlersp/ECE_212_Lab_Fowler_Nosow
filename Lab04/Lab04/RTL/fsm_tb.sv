`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Sam Fowler
// Create Date: 02/15/2022 09:35:57 AM
// Module Name: fsm_tb
// Description: Simple testbench for the FSM to make sure it will select the different states based on when the button is pressed.
//////////////////////////////////////////////////////////////////////////////////


module fsm_tb;

logic sw1, sw2, clk, rst; 
logic sel;

fsm DUV(.sw1, .sw2, .clk, .rst, .sel);

always begin
    clk = 0; #5;
    clk = 1; #5;
end

initial 
begin
rst = 1;
sw1 = 0;
sw2 = 0;
@(posedge clk) #1;
rst = 0;
sw1 = 0;
sw2 = 0;
@(posedge clk) #1;
rst = 0;
sw1 = 0;
sw2 = 1;
@(posedge clk) #1;
rst = 0;
sw1 = 1;
sw2 = 0;
repeat(10)@(posedge clk);
rst = 0;
sw1 = 1;
sw2 = 1;
repeat(40)@(posedge clk);
rst = 0;
sw1 = 0;
sw2 = 0;
repeat(10)@(posedge clk);
$stop;    

end
   
  
   
endmodule

