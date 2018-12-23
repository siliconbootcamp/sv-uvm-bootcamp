// Code your testbench here
// or browse Examples
module hello_world ;

  //Add SV constructs here
  logic [31:0] count = 0;
  logic clk = 0;

  always #5 clk = ~clk ;

  always_ff @(posedge clk)
    count <= count + 1;

  initial begin
    //Need these 2 lines for waveform display
    $dumpfile("dump.vcd");
    $dumpvars;

    $display("hello world!");

    #400;
    $finish;
  end

endmodule
