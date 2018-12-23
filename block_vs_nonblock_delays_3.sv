module block_nonblock();
reg a, b, c ;

  /*


a=0,b=0,c=1; #1 a = c, #1 b = a
a<=0, b<=0,c<=1; #1 a<=c, #1 b<= a
a=0, b=0, c=1, a=#1 c , b = #1 a
a<=0, b<=0,c<=1, a <= #1 c, b <= #1 a

*/

logic clk ;
initial clk = 0;
always #5 clk <= ~clk ;

// Blocking assignments
initial begin
  $dumpfile("dump.vcd");
  $dumpvars;

  a=0;
  b=0;
  c=1;
  #10;
  a = c;
  #10;
  b = a ;


  repeat (10) @(posedge clk);

  a <= 0;
  b <= 0;
  c <= 1;
  #10;
  a <= c ;
  #10;
  b <= a ;

  repeat (10) @(posedge clk);

  a=0;
  c=1;
  a <= #10 c;
  c = 0;

  repeat (10) @(posedge clk);

  a=0; b=0; c=1;
  a = #10 c ;
  c = 0;
  b = #10 a ;

  repeat (10) @(posedge clk);

  a<=0; b<=0; c<=1;

  repeat (10) @(posedge clk);

  #10;
  a <=  c ;

  b <= #10 a ;

  repeat (10) @(posedge clk);


  $finish;
end

endmodule
