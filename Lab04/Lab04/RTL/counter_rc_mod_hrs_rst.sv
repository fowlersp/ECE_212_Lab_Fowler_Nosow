module counter_rc_mod_hrs_rst (
    input logic clk, rst, enb,
    output logic [3:0] q,
    output logic cy
    );

    parameter MOD = 4'd10;

    assign cy = (q == MOD-1) && enb;

    always_ff @(posedge clk) 
begin
        if (rst) q <= 1;
        else if (cy) q <= 0;
        else if (enb) q <= q + 1;
end


endmodule
