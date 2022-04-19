module pr_d_e(input logic clk, reset, flush_e,
  input logic regwrite_d, memtoreg_d, memwrite_d,
  input logic [2:0] alucontrol_d,
  input logic alusrc_d, regdst_d,
  input logic [31:0] rd1_d, rd2_d,
  input logic [4:0] rs_d, rt_d, rd_d,
  input logic [31:0] signimm_d,
  output logic regwrite_e, memtoreg_e, memwrite_e,
  output logic [2:0] alucontrol_e,
  output logic alusrc_e, regdst_e,
  output logic [31:0] rd1_e, rd2_e,
  output logic [4:0] rs_e, rt_e, rd_e,
  output logic [31:0] signimm_e
  );

  always_ff @ (posedge clk)
  if (reset || flush_e) begin
    regwrite_e <= 0;
    memtoreg_e <= 0;
    memwrite_e <= 0;
    alucontrol_e <= '0;
    alusrc_e <= 0;
    regdst_e <= 0;
    rd1_e <= 0;
    rd2_e <= 0;
    rs_e = '0;
    rt_e <= '0;
    rd_e <= '0;
    signimm_e <= '0;
  end
  else begin
    regwrite_e <= regwrite_d;
    memtoreg_e <= memtoreg_d;
    memwrite_e <= memwrite_d;
    alucontrol_e <= alucontrol_d;
    alusrc_e <= alusrc_d;
    regdst_e <= regdst_d;
    rd1_e <= rd1_d;
    rd2_e <= rd2_d;
    rs_e = rs_d;
    rt_e <= rt_d;
    rd_e <= rd_d;
    signimm_e <= signimm_d;
  end
endmodule: pr_d_e
