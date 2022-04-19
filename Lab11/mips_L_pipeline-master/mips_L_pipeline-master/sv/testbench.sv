//------------------------------------------------
// testbench.sv
// David_Harris@hmc.edu 23 October 2005
// Updated to SystemVerilog dmh 12 November 2010
// Testbench for MIPS processor
//------------------------------------------------
//--------------------------------------------------------------
// Extended version (Lab08 Solution March 2022)
// includes extensions for:
//    ori instruction (including controlled sign extension)
//    bne (modified controller)
//--------------------------------------------------------------

module testbench();

    logic        clk;
    logic        reset;

    logic [31:0] writedata, dataadr;
    logic        memwrite;

    // instantiate device to be tested
    top DUV(.clk, .reset, .writedata, .dataadr, .memwrite);

    // initialize test
    initial
    begin
        reset <= 1; # 12; reset <= 0;
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
                @(posedge clk);
                $stop;
            end else if (dataadr !== 80) begin
                $display("Simulation failed - expected to write m[84]=7, actual value %d",writedata);
                @(posedge clk);
                $stop;
            end
        end
    end

    localparam LIMIT = 42;  // don't let simulation go on forever

    integer cycle = 0;

    always @(posedge clk)
    begin
        if (cycle>LIMIT) $stop;
        else cycle <= cycle + 1;
    end

endmodule
