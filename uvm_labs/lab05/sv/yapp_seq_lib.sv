/////////////////////////////////////////////////////////////////////////
//                                                                     //
//   File name     : yapp_seq_lib.sv                                   //
//                                                                     //
//   Description   : this file have all the collection of our sequence //
//                                                                     //
//   version       : 02                                                //
//                                                                     //
/////////////////////////////////////////////////////////////////////////

`ifndef SEQ_LIB
`define SEQ_LIB

// Class declaration
class yapp_seq_lib extends uvm_sequence_library #(yapp_packet);

  `uvm_object_utils(yapp_seq_lib)
  // Factory registration
  `uvm_sequence_library_utils(yapp_seq_lib)

  // Extern constructor
  extern function new(string name = "yapp_seq_lib");
  
endclass

  // Constructor which includes all sequences inside a seq_lib
  function yapp_seq_lib::new(string name = "yapp_seq_lib");
    super.new(name);
    add_typewide_sequences({yapp_incr_payload_seq::get_type(),
                            yapp_1_seq::get_type(),
                            yapp_111_seq::get_type(),
                            yapp_repeat_addr_seq::get_type(),
                            yapp_incr_payload_seq::get_type()});
    init_sequence_library();
  endfunction

`endif

