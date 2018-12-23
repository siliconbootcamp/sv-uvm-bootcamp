/*
UVM bare bones data object exercise
Follow TODO instructions
*/

`include "uvm_macros.svh"

//TODO : Run code as is, are the values of id and len printed ?
//Answer:
//
module tb ;

  import uvm_pkg::*;

  class my_pkt extends uvm_sequence_item;

    rand bit [3:0] id;
    rand bit [7:0] len ;

    //TODO : Comment out the macro in the line below
    //       Do you expect the code to compile ?
    //       What is the behavior ?
    //Answer:
    //
    `uvm_object_utils(my_pkt)

    //TODO : Uncomment the macro in the line above
    //       Remove the default argument "any_name" in
    //       the function new() below.
    //       What is the output ?
    //Answer :
    //
    function new(string name="any_name");
      super.new(name);
    endfunction

  endclass

  class my_test extends uvm_test ;

    my_pkt pkt;

    `uvm_component_utils(my_test)

    function new (string name, uvm_component parent);
      super.new(name,parent);
    endfunction

    task run_phase(uvm_phase phase);
      pkt = new("test_pkt_from_new");
      pkt.randomize();
      pkt.print();
      //TODO : Make sure the code compiles by ensuring the new()
      //       function in the my_pkt class has a default value.
      //       Then add display statements to show the values of id
      //       and len
      //** Write code between this line


      //** and this
    endtask

  endclass

  initial
    run_test("my_test");

endmodule
