//------------------------------------------------
// mipstest.sv
// David_Harris@hmc.edu 23 October 2005
// Updated to SystemVerilog dmh 12 November 2010
// Testbench for MIPS processor
// Revised for use with Lafayette Multi-cycle design
// John Nestor, March 2019
//------------------------------------------------

module testbench();

  logic        clk;
  logic        reset;

  logic [31:0] writedata, dataadr;
  logic        memwrite;

  // instantiate device to be tested
  mips_multi_top DUV(.clk, .reset, .writedata, .adr(dataadr), .memwrite);
  
  // initialize test
  initial
    begin
      reset <= 1; # 22; reset <= 0;
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
        if(dataadr === 84 & writedata === 7) begin
          $display("Simulation succeeded");
          $stop;
        end else if (dataadr !== 80) begin
          $display("Simulation failed");
          $stop;
        end
      end
    end

   localparam LIMIT = 100;  // don't let simulation go on forever
   
   integer cycle = 0;

   always @(posedge clk)
     begin
	   if (cycle>LIMIT) $stop;
	   else cycle <= cycle + 1;
     end 
   
endmodule



