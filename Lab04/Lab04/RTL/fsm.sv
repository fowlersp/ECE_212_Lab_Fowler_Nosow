`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/15/2022 08:29:56 AM
// Design Name: 
// Module Name: fsm
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


module fsm(input logic sw1, sw2, clk, rst, 
           output logic sel);

    typedef enum logic [3:0] {S0=4'b0000, S1=4'b0001, S2a = 4'b0010, S2b = 4'b0011, S2c = 4'b0100, S2d = 4'b0101, S3a=4'b0110, S3b=4'b0111, S3c=4'b1000, S3d=4'b1001, 
                              S3e= 4'b1010, S3f=4'b1011, S3g=4'b1100, S3h=4'b1101} states_t;
    
    states_t state, next;
    
    always_ff @(posedge clk)
    if (rst) state <= S0;
    else state <= next;
    
    always_comb 
        begin
            next = S0;
            sel = 1'b0;
            case(state)
                S0:
                    if(~sw1 && ~sw2)
                        begin 
                            sel = 1'b0;
                            next = S0;
                        end
                    else if (~sw1 && sw2) next = S1;
                    else if (sw1 && ~sw2) next = S2a;
                    else if (sw1 && sw2) next = S3a;
                S1:
                    if(~sw1 && sw2)
                        begin 
                            sel = 1'b1;
                            next = S1;
                        end
                    else if (~sw1 && ~sw2) next = S0;
                    else if (sw1 && ~sw2) next = S2a;
                    else if (sw1 && sw2) next = S3a;
                S2a:
                    
                    if(sw1 && ~sw2)
                        begin
                            sel = 1'b1;
                            next = S2b;
                        end
                    else if (~sw1 && ~sw2) next = S0;
                    else if (~sw1 && sw2) next = S1;
                    else if (sw1 && sw2) next = S3a;
                  
                S2b:
                    if(sw1 && ~sw2)
                        begin
                            sel = 1'b1;
                            next = S2c;
                        end
                    else if (~sw1 && ~sw2) next = S0;
                    else if (~sw1 && sw2) next = S1;
                    else if (sw1 && sw2) next = S3a;            
                S2c:
                    if(sw1 && ~sw2)
                        begin
                            sel = 1'b0;
                            next = S2d;
                        end
                    else if (~sw1 && ~sw2) next = S0;
                    else if (~sw1 && sw2) next = S1;
                    else if (sw1 && sw2) next = S3a;
                S2d: 
                    if(sw1 && ~sw2)
                        begin
                            sel = 1'b0;
                            next = S2a;
                        end
                    else if (~sw1 && ~sw2) next = S0;
                    else if (~sw1 && sw2) next = S1;
                    else if (sw1 && sw2) next = S3a;            
                S3a:
                    if(sw1 && sw2)
                        begin
                            sel = 1'b1;
                            next = S3b;
                        end
                    else if (~sw1 && ~sw2) next = S0;
                    else if (~sw1 && sw2) next = S1;
                    else if (sw1 && ~sw2) next = S2a;
               S3b:
                    if(sw1 && sw2)
                        begin
                            sel = 1'b1;
                            next = S3c;
                        end
                    else if (~sw1 && ~sw2) next = S0;
                    else if (~sw1 && sw2) next = S1;
                    else if (sw1 && ~sw2) next = S2a;
               S3c:
                    if(sw1 && sw2)
                        begin
                            sel = 1'b1;
                            next = S3d;
                        end
                    else if (~sw1 && ~sw2) next = S0;
                    else if (~sw1 && sw2) next = S1;
                    else if (sw1 && ~sw2) next = S2a;
               S3d:
                    if(sw1 && sw2)
                        begin
                            sel = 1'b1;
                            next = S3e;
                        end
                    else if (~sw1 && ~sw2) next = S0;
                    else if (~sw1 && sw2) next = S1;
                    else if (sw1 && ~sw2) next = S2a;
              S3e:
                    if(sw1 && sw2)
                        begin
                            sel = 1'b0;
                            next = S3f;
                        end
                    else if (~sw1 && ~sw2) next = S0;
                    else if (~sw1 && sw2) next = S1;
                    else if (sw1 && ~sw2) next = S2a;
              S3f:
                    if(sw1 && sw2)
                        begin
                            sel = 1'b0;
                            next = S3g;
                        end
                    else if (~sw1 && ~sw2) next = S0;
                    else if (~sw1 && sw2) next = S1;
                    else if (sw1 && ~sw2) next = S2a;
              S3g:
                    if(sw1 && sw2)
                        begin
                            sel = 1'b0;
                            next = S3h;
                        end
                    else if (~sw1 && ~sw2) next = S0;
                    else if (~sw1 && sw2) next = S1;
                    else if (sw1 && ~sw2) next = S2a;
              S3h:
                    if(sw1 && sw2)
                        begin
                            sel = 1'b0;
                            next = S3a;
                        end
                    else if (~sw1 && ~sw2) next = S0;
                    else if (~sw1 && sw2) next = S1;
                    else if (sw1 && ~sw2) next = S2a;
              default:
                    sel = 1'b0;
        endcase                  
    end
endmodule
