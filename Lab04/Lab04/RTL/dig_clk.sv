module dig_clk(input logic clk, rst, enb_hr, enb_min,
 output logic [6:0] h1, h0, m1, m0, s1, s0, am_pm); 
 
 
logic [3:0] sec_ones, sec_tens, min_ones, min_tens, hr_ones, hr_tens, ampm, unused;
logic enb_out, cy_s_t, cy_m_t, cy_h_o, cy_h_t, adv_min, adv_hr, pb_debounced_hr, pb_debounced_min, hr_out, min_out, cy_ampm;
 
debounce U_DB_HR (.clk, .pb(enb_hr), .rst, .pb_debounced(pb_debounced_hr));
 
single_pulser U_PULSE_HR (.clk, .din(pb_debounced_hr), .d_pulse(hr_out));

debounce U_DB_MIN (.clk, .pb(enb_min), .rst, .pb_debounced(pb_debounced_min));
 
single_pulser U_PULSE_MIN (.clk, .din(pb_debounced_min), .d_pulse(min_out));
 
//period_enb   #(.PERIOD_MS(1000)) U_ENB (.clk, .rst, .clr(1'b0), .enb_out);

sec_cnt  U_SEC (.clk, .rst, .enb(clk), .sec_tens, .sec_ones, .cy_s_t);

assign adv_min = min_out | cy_s_t;
 
min_cnt  U_MIN (.clk, .rst, .enb(adv_min), .min_tens, .min_ones, .cy_m_t);
  
assign adv_hr = hr_out | cy_m_t;  
  
hr_cnt  U_HR (.clk, .rst, .enb(adv_hr), .hr_tens, .hr_ones, .cy_h_t);

counter_rc_mod #(.MOD(2)) U_CNT_AMPM (.clk, .rst, .enb((hr_tens == 4'd1) && (hr_ones == 4'd1) && (adv_hr)), .q(ampm), .cy(cy_ampm));

assign s0 = sec_ones;
assign s1 = sec_tens;
assign m0 = {3'b010, min_ones};
assign m1 = min_tens;
assign h0 = {3'b010, hr_ones}; 



always_comb 
begin
if (hr_tens[3:0] == 4'd0) h1 = 7'b1000000;
else h1 = hr_tens;
end

assign am_pm = {6'b000101, ampm[0]} + 2'b10;


endmodule
