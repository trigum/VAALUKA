
/*-----------------------------------------------------------------
File name     : router_virtual_seq.sv
Description   : this file is virtual sequence which going to start real sequence 
Notes         : 
-------------------------------------------------------------------
-----------------------------------------------------------------*/

//------------------------------------------------------------------------------
//
// virtual sequence
//
//------------------------------------------------------------------------------

`ifndef VIRTUAL_SEQUENCE
`define VIRTUAL_SEQUENCE


class router_simple_vseq extends uvm_sequence;
  `uvm_object_utils(router_simple_vseq)                                                 // factory registration
  
  `uvm_declare_p_sequencer(router_virtual_sequencer)                                    // psequencer  registration
  
  sequences seq;                                                                        // seq handle
  
  yapp_012_seq seq_012;                                                                 // 012 handle
  
  hbus_small_packet_seq small_pkt;                                                      // small packet handle
  
  hbus_get_yapp_regs_seq read_pkt;                                                      // read handle
  
  hbus_set_default_regs_seq max_pkt;  // max packet handle


  extern function new(string name="router_simple_vseq");
  
  extern task body();  
    
endclass

  //constructor

  function router_simple_vseq::new(string name="router_simple_vseq");
    super.new(name);
    seq=sequences::type_id::create("seq");
    seq_012=yapp_012_seq::type_id::create("seq_012");
    small_pkt=hbus_small_packet_seq::type_id::create("small_pkt");
    read_pkt=hbus_get_yapp_regs_seq::type_id::create("read_pkt");
    max_pkt=hbus_set_default_regs_seq::type_id::create("max_pkt");
  endfunction

  // task body

  task router_simple_vseq::body();
    if(starting_phase!=null)
      starting_phase.raise_objection(this);
    small_pkt.start(p_sequencer.h_seqr);
    read_pkt.start(p_sequencer.h_seqr);
    //repeat(2)
      seq_012.start(p_sequencer.seqr);
    max_pkt.start(p_sequencer.h_seqr); 
    read_pkt.start(p_sequencer.h_seqr);
    //repeat(6)
      seq.start(p_sequencer.seqr);
    if(starting_phase!=null)
      starting_phase.drop_objection(this);	   
  endtask

`endif
