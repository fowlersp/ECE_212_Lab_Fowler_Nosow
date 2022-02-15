module counter_modified_hrs(
  input logic clk, rst, enb,
  input logic [3:0] hr_tens,
    output logic [3:0] q, 
    output logic cy
    );

 
always_comb 
begin
    if (hr_tens == 4'b0000) cy = (q == 9) && enb;
    else cy = (q == 2) && enb;
end

    always_ff @(posedge clk) begin
        if ((cy && hr_tens) ) q <= 1;
        else if (rst) q <= 2;
        else if (cy && !hr_tens) q <= 0;
        else if (enb) q <= q + 1;
    end



endmodule
