//------------------------------------------------
// mipstest.sv
// John Nestor, Lafayette College
// Redesigned benchmark for single cycle mips
// Testbench for MIPS processor
// Note that in this version the tesbench is a program
// block that is instantiated in the top level file
//------------------------------------------------

module mipsbench(
  input logic        clk,
  output logic        reset,
  input logic [31:0] pc, writedata, dataadr,
  input logic        memwrite
                  );
                  
   task do_reset;
      reset = 1;
      @(posedge clk) #1;
      reset = 0;
   endtask // load_imem

   task load_imem( input string fname );
      $readmemh(fname, $root.mipstop.IM.ram_array);
   endtask //

   task test_addi;
      load_imem("test_addi.dat");
      do_reset();
      @(negedge clk) if (pc != 32'h00000000) $error("Expected PC=0 after reset, got %h", pc);
      repeat (3) @(negedge clk);  // wait until middle of third instruction
      if (memwrite != 1'b1) $error("Expected memwrite=1 after 3rd instruction, got %b", memwrite);
      if (dataadr != 32'h00000008) $error("Expected dataadr=0x8 after 3rd instruciton, got %h", dataadr);
      if (writedata != 32'd188) $error("expected writedata=32'd88 after 3rd instruction got %d", writedata);
      repeat (2) @(negedge clk); // wait until middle of final (5th) instruction
      @(posedge clk) #1;
      $stop;
   endtask //
   

 

 // initialize and apply tests
  initial
    begin
      $display("Starting simulation...");
      do_reset;
      test_addi;
    end
    

endmodule