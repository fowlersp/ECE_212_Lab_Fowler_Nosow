`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/03/2022 07:56:45 AM
// Design Name: 
// Module Name: ADDTEST_TB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ADDTEST_TB();

    logic        clk;
    logic        reset;

    logic [31:0] writedata, dataadr;
    logic        memwrite;

    // instantiate device to be tested
    top2 DUV(.clk, .reset, .writedata, .dataadr, .memwrite);

    // initialize test
    initial
    begin
        reset <= 1; # 12; reset <= 0;
    end

    // generate clock to sequence tests
    always
    begin
        clk <= 1; # 5; clk <= 0; # 5;
    end

    // check that 7 gets written to address 84
    always@(negedge clk)
    begin
        if(memwrite) begin
            if(dataadr === 84 & writedata === 50) begin
                $display("ADDTEST Simulation Succeeded");
                @(posedge clk);
                $stop;
            end else if (dataadr !== 50) begin
                $display("Simulation failed - expected to write m[84]=50, actual value %d",writedata);
                @(posedge clk);
                $stop;
            end
        end
    end

    localparam LIMIT = 42;  // don't let simulation go on forever

    integer cycle = 0;

    always @(posedge clk)
    begin
        if (cycle>LIMIT) $stop;
        else cycle <= cycle + 1;
    end
endmodule
