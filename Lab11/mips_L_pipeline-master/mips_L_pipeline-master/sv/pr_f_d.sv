module pr_f_d(input logic clk, reset, stall_d,
  input logic [31:0] instr_f, pcplus4_f,
  output logic [31:0] instr_d, pcplus4_d);

  always_ff @ (posedge clk)
  if (reset) begin
    instr_d <= '0;
    pcplus4_d <= '0;
  end
  else if (!stall_d) begin
    instr_d <= instr_f;
    pcplus4_d <= pcplus4_f;
  end
endmodule: pr_f_d
