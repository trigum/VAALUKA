
///////////////////////////////////////////////////////////////////////
//                                                                   //
// File name     : yapp_seq_lib.sv                                   //
//                                                                   //
// Description   : This file contains a collection of sequences for  //
//                 yapp_packet.                                      //
//                                                                   //
// Version       : 2.0                                               //
//                                                                   //
///////////////////////////////////////////////////////////////////////

`ifndef SEQ_LIB
`define SEQ_LIB

// Sequence library class for yapp_packet
class yapp_seq_lib extends uvm_sequence_library #(yapp_packet);

  `uvm_object_utils(yapp_seq_lib)
  
  `uvm_sequence_library_utils(yapp_seq_lib)

  // Constructor for the sequence library
  extern function new(string name = "yapp_seq_lib");

endclass

// Constructor implementation for yapp_seq_lib
function yapp_seq_lib::new(string name = "yapp_seq_lib");

  // Call to the parent constructor
  super.new(name);

  // Add all sequences to the sequence library
  add_typewide_sequences({
    yapp_incr_payload_seq::get_type(),
    yapp_1_seq::get_type(),
    yapp_111_seq::get_type(),
    yapp_repeat_addr_seq::get_type(),
    yapp_incr_payload_seq::get_type()
  });

  // Initialize the sequence library
  init_sequence_library();

endfunction

`endif

