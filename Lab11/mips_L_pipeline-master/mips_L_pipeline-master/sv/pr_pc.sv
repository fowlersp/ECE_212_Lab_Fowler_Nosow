module pr_pc(
  input logic clk, reset, stall_f,
  input logic [31:0] pcnext_f,
  output logic [31:0] pc_f
  );

  always_ff @(posedge clk)
    if (reset) pc_f <= '0;
    else if (!stall_f) pc_f <= pcnext_f;

endmodule: pr_pc    
