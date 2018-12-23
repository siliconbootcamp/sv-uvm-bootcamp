module block_nonblock();

  logic in ;
  reg o1,o2,o3,o4,o5,o6;
  reg o1_next, o2_next;


  // Blocking assignments

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end

  initial begin
    in=0;
    #20 in = 1;
    #20 in = 0;
    #20 in = 1;
    #5 in = 0;
    #5 in = 1;
    #20 in = 0;
    #20;
    $finish;
  end

  always @(in) begin
    o1 = in ;
  end

  always @(in) begin
    o2 <= in;
  end

  initial begin
    $display("initial:display : %t:: in = %d, o1 = %d, o2 = %d",$time,in,o1,o2);
    $monitor("initial:monitor : %t:: in = %d, o1 = %d, o2 = %d",$time,in,o1,o2);
    $strobe ("initial:strobe  : %t:: in = %d, o1 = %d, o2 = %d",$time,in,o1,o2);
  end


  always @(in)
    $display("always:display  : %t:: in = %d, o1 = %d, o2 = %d",$time,in,o1,o2);

  always @(in)
    $strobe("always:strobe   : %t:: in = %d, o1 = %d, o2 = %d",$time,in,o1,o2);


endmodule
