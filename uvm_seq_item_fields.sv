`include "uvm_macros.svh"

module tb ;

  import uvm_pkg::*;

  class dest_field extends uvm_sequence_item;
    rand bit [4:0] dest ;

    `uvm_object_utils_begin(dest_field)
    	`uvm_field_int(dest,UVM_ALL_ON)
    `uvm_object_utils_end

    constraint dest_range { dest == 8 ; }

    function new(string name = "dest_field");
      super.new(name);
    endfunction

  endclass

  class my_pkt extends uvm_sequence_item;

    typedef enum { GOOD_CHECKSUM, BAD_CHECKSUM } checksum_t;

    rand bit [3:0] id;
    rand bit [7:0] len ;
    rand checksum_t checksum;
    event  interrupt ;

    bit [3:0] opcode[string];

    dest_field   dest ;

    `uvm_object_utils_begin(my_pkt)
  	  `uvm_field_int(id,UVM_ALL_ON)
      `uvm_field_int(len,UVM_ALL_ON + UVM_BIN)
      `uvm_field_object(dest,UVM_ALL_ON)
      `uvm_field_enum(checksum_t, checksum, UVM_ALL_ON)
      `uvm_field_event(interrupt,UVM_ALL_ON + UVM_NOPRINT)
      `uvm_field_aa_int_string(opcode,UVM_ALL_ON)
    `uvm_object_utils_end

    constraint length { len > 5 ; len < 10; }

    function new(string name="my_pkt");
      super.new(name);
      dest = dest_field::type_id::create("dest");
      opcode["ADD"] = 1;
      opcode["SUB"] = 2;
    endfunction

    function void pre_randomize();
	  this.dest.randomize();
    endfunction

  endclass

  class my_test extends uvm_test ;

    string msg;
    my_pkt pkt;

    `uvm_component_utils(my_test)

    function new (string name, uvm_component parent);
      super.new(name,parent);
    endfunction

    task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      #100;
      `uvm_info("DEMO", get_name(), UVM_NONE)
      `uvm_info("DEMO", get_full_name(), UVM_NONE)
      `uvm_info("DEMO", get_type_name(), UVM_NONE)

      //pkt = new("test_pkt_from_new");
      pkt = my_pkt::type_id::create("test_pkt_from_create");
      -> pkt.interrupt;
      pkt.randomize();
      pkt.print();
      pkt.print(uvm_default_table_printer);
      pkt.print(uvm_default_line_printer);
      pkt.print(uvm_default_tree_printer);

      $display("Hello World");
      phase.drop_objection(this);
    endtask

  endclass

  initial
    run_test("my_test");

endmodule
