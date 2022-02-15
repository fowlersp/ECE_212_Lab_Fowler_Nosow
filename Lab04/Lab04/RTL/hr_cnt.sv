module hr_cnt(
                input logic clk, rst, enb,
                output logic [3:0] hr_tens, hr_ones,
                output logic cy_h_t);

logic cy_h_o;

counter_modified_hrs  U_CNT_HR_ONES (.clk, .rst, .enb, .hr_tens, .q(hr_ones), .cy(cy_h_o));

counter_rc_mod_hrs_rst #(.MOD(2)) U_CNT_HR_TENS (.clk, .rst, .enb(cy_h_o), .q(hr_tens), .cy(cy_h_t));

endmodule
