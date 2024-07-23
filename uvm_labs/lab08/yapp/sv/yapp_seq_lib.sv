
///////////////////////////////////////////////////////////////////////
//  File name     : seq_lib.sv                                       //
//                                                                   //
//  Description   : This file defines a sequence library class for   //
//                  yapp_packet sequences.                           //
//                                                                   //
//  version       : 1.0                                              //
///////////////////////////////////////////////////////////////////////

`ifndef SEQ_LIB
`define SEQ_LIB

/////////////////////////////
//                         //
//  YAPP SEQUENCE LIBRARY  //
//                         //
/////////////////////////////

// Define a class for the sequence library extending from uvm_sequence_library
class yapp_seq_lib extends uvm_sequence_library #(yapp_packet);

  // Register the class with the UVM factory
  `uvm_object_utils(yapp_seq_lib)
  
  // Declare the sequence library utilities
  `uvm_sequence_library_utils(yapp_seq_lib)

  // Declare the constructor
  extern function new(string name="yapp_seq_lib");
  
endclass

  // Constructor implementation to include all sequences inside the sequence library
  function yapp_seq_lib::new(string name="yapp_seq_lib");

    // Call the super class constructor
    super.new(name);

    // Add various sequence types to the library
    add_typewide_sequences({yapp_incr_payload_seq::get_type(),
                            yapp_1_seq::get_type(),
		            yapp_111_seq::get_type(),
		            yapp_repeat_addr_seq::get_type(),
		            yapp_incr_payload_seq::get_type()});
    
    // Initialize the sequence library
    init_sequence_library();
  endfunction

`endif

