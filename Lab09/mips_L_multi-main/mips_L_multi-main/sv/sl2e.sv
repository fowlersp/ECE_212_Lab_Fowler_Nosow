//--------------------------------------------------------------
// sl2e.sv - 2-bit left shifter that returns new sized output
//--------------------------------------------------------------


module sl2e #(parameter WIDTH = 32) (
    input  logic [WIDTH-1:0] a,
    output logic [WIDTH+1:0] y
    );

    assign y = {a[WIDTH-1:0], 2'b00};

endmodule // sl2
