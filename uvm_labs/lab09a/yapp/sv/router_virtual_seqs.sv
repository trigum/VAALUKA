///////////////////////////////////////////////////////////////////////
//  File name     : router_virtual_seq.sv                            //
//                                                                   //
//  Description   : this is a virtual sequence                       //
//                                                                   //
//  Version       : 2.0                                              //
///////////////////////////////////////////////////////////////////////


`ifndef VIRTUAL_SEQUENCE
`define VIRTUAL_SEQUENCE

class router_simple_vseq extends uvm_sequence;
  `uvm_object_utils(router_simple_vseq)
  
  `uvm_declare_p_sequencer(router_virtual_sequencer)
  
  // Declare sequences instance variable
  sequences seq;
  
  // Declare sequence for yapp_012
  yapp_012_seq seq_012;
  
  // Declare sequence for small packet
  hbus_small_packet_seq small_pkt;
  
  // Declare sequence for reading registers
  hbus_get_yapp_regs_seq read_pkt;
  
  // Declare sequence for setting default registers
  hbus_set_default_regs_seq max_pkt;

  // Constructor to initialize the sequences
  extern function new(string name="router_simple_vseq");
  
  // Main task to execute the sequence actions
  extern task body();  
    
endclass

// Implementation of the constructor
function router_simple_vseq::new(string name="router_simple_vseq");
  super.new(name);
  
  // Create an instance of sequences
  seq = sequences::type_id::create("seq");
  
  // Create an instance of yapp_012 sequence
  seq_012 = yapp_012_seq::type_id::create("seq_012");
  
  // Create an instance of small packet sequence
  small_pkt = hbus_small_packet_seq::type_id::create("small_pkt");
  
  // Create an instance of read packet sequence
  read_pkt = hbus_get_yapp_regs_seq::type_id::create("read_pkt");
  
  // Create an instance of max packet sequence
  max_pkt = hbus_set_default_regs_seq::type_id::create("max_pkt");
endfunction

// Implementation of the main task
task router_simple_vseq::body();
  if (starting_phase != null)
    starting_phase.raise_objection(this);
    
  // Start the small packet sequence
  small_pkt.start(p_sequencer.h_seqr);
  
  // Start the read packet sequence
  read_pkt.start(p_sequencer.h_seqr);
  
  // Start the yapp_012 sequence
  // repeat(2) 
  seq_012.start(p_sequencer.seqr);
  
  // Start the max packet sequence
  max_pkt.start(p_sequencer.h_seqr);
  
  // Start the read packet sequence again
  read_pkt.start(p_sequencer.h_seqr);
  
  // Start the general sequences
  // repeat(6)
  seq.start(p_sequencer.seqr);
  
  if (starting_phase != null)
    starting_phase.drop_objection(this);	   
endtask

`endif

