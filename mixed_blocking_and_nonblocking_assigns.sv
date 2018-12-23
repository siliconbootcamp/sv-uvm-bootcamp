// Code your testbench here
// or browse Examples
module mixed_blocking_and_nonblocking_assigns;

  reg clk = 0;
  always #5 clk = ~clk;

  integer A,B,C,D,E,F,G ;

  initial begin
    A=0;
    B=0;
    C=0;
    D=0;
    E=0;
    F=0;
    G=0;

    $dumpfile("dump.vcd");
    $dumpvars;

    A <= #15 2 ;
    A = #10 1 ;
    B = #10 (A + 1);
    C = #10 B + 6;
    #10 D = C + 5;
    E <= D + 5;
    #10 F <= E + 3;
    G = F + 5;

    //At time 0: All 0
    //At time 10: A = 1, B = 1, C = 0, D thru G = 0
    //At time 20: A = 1, B = 1, C = 0, D = 5, E = 10, F , G = 0
    //At time 30: A = 1, B = 1, C = 0, D = 5, E = 10, F = 13, G = 18

    #100;
    $finish;
  end


endmodule
