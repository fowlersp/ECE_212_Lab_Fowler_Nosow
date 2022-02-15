module sec_cnt(
                input logic clk, rst, enb,
                output logic [3:0] sec_tens, sec_ones,
                output logic cy_s_t);
logic cy_s_o;
    
counter_rc_mod #(.MOD(10)) U_CNT_SEC_ONES (.clk, .rst, .enb, .q(sec_ones), .cy(cy_s_o));

counter_rc_mod #(.MOD(6)) U_CNT_SEC_TENS (.clk, .rst, .enb(cy_s_o), .q(sec_tens), .cy(cy_s_t));
    
endmodule

