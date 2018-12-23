module block_nonblock();

  reg in;
  reg o1,o2,o3,o4,o5,o6;
  reg o1_next, o2_next;

  int A,B;

  // Blocking assignments

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end

  initial begin
    #0 in=0;
    #20 in = 1;
    #20 in = 0;
    #20 in = 1;
    #5 in = 0;
    #5 in = 1;
    #20 in = 0;
    #20;
    $finish;
  end

  always @(in or o1) begin
    o1 = in ;
    o1_next = o1;
  end

  always @(in or o2) begin
    o2 <= in;
    o2_next <= o2 ;
  end

  always @(in)
    #10 o3 = in;

  always @(in)
    #10 o4 <= in;

  always @(in)
    o5 = #10 in;

  always @(in)
    o6 <= #10 in;

  initial begin
    #5 A <= 1;
    #5 A <= A + 1;
    B <= A + 1;
  end


endmodule
