// Code your testbench here
// or browse Examples
//Generate unique values
class data ;

  rand int a[$];

  int s;

  function new (int _size) ;
    s = _size;
  endfunction

  constraint size { a.size == s ; };

  //All array values must be unique
  constraint all_uniq { foreach( a[i] ) { foreach( a[j]) {
    if ( i != j ) a[i] != a[j]; } } };

  //Fix the range for each value
  constraint range { foreach( a[i]) { a[i] >= 1; a[i] <= s; }};

endclass

program test;

  data d  ;
  int size;

  int q2d[5][5];

   initial begin

     if (!$value$plusargs("s=%d",size))
  		size=10;

     d = new(size);

     d.randomize();

     foreach( d.a[i] ) begin
       $display("a[%d] = %d",i,d.a[i]);
     end

     foreach( q2d[i,j] ) begin
       $display("q2d[%d,%d] = %d",i,j,q2d[i][j]);
     end

   end

endprogram

  
