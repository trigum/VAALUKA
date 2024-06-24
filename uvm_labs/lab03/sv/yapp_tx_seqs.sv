

/*-----------------------------------------------------------------
File name     : yapp_tx_seqs.sv
Description   : this file is to generate stimulus 
Notes         : 
-------------------------------------------------------------------
-----------------------------------------------------------------*/

//------------------------------------------------------------------------------
//
// yapp_tx_seqs
//
//------------------------------------------------------------------------------

`ifndef SEQUENCES
`define SEQUENCES

class sequences extends uvm_sequence #(yapp_packet);
  
  `uvm_object_utils(sequences)                                                 // factory registration

  extern function new(string name = "sequences");
                                                                               // externs
  extern task body();
  
endclass

`endif

  // constructor

  function sequences::new(string name = "sequences");
    super.new(name);
  endfunction

  // body

  task sequences::body();
    $display("bala");
    if(starting_phase==null)
      starting_phase.raise_objection(this);
    for(int i=0;i<15;i++)
    begin
      req=yapp_packet::type_id::create("req");
      start_item(req);
      req.randomize();                                                           // normal randomization
      finish_item(req);
    end
    if(starting_phase==null)    
      starting_phase.drop_objection(this);
  endtask

