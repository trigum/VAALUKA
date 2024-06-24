

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
//

`ifndef SEQUENCE
`define SEQUENCE

/////////////////////
//                 //
//  base sequence  //
//                 //
/////////////////////

class sequences extends uvm_sequence #(yapp_packet);
  `uvm_object_utils(sequences)                                               // factory registration
 
  extern function new(string name = "sequences");
  
  extern task body();
  
endclass

  // constructor

  function sequences::new(string name = "sequences");
    super.new(name);     
  endfunction

  // body 
 
  task sequences::body();
    if(starting_phase==null)
      starting_phase.raise_objection(this);
    for(int i=0;i<15;i++)
    begin
      req=yapp_packet::type_id::create("req");                          // generating stimulus
      start_item(req);
      req.randomize();
      finish_item(req);
    end
    if(starting_phase==null)    
      starting_phase.drop_objection(this);
  endtask

`endif
