// sequence library for yapp router

`ifndef SEQ_LIB
`define SEQ_LIB

class yapp_seq_lib extends uvm_sequence_library #(yapp_packet);
  `uvm_object_utils(yapp_seq_lib)
  
  `uvm_sequence_library_utils(yapp_seq_lib)

  extern function new(string name="yapp_seq_lib");
  
endclass

  // constructor which include all sequence inside a seq_lib

  function yapp_seq_lib::new(string name="yapp_seq_lib");
    super.new(name);
    add_typewide_sequences({yapp_incr_payload_seq::get_type(),
                            yapp_1_seq::get_type(),
		            yapp_111_seq::get_type(),
		            yapp_repeat_addr_seq::get_type(),
		            yapp_incr_payload_seq::get_type()});
    init_sequence_library();
  endfunction

`endif
