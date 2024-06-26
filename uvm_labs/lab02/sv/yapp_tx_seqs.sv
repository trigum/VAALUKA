
///////////////////////////////////////////////////////////////////////
//  File name     : yapp_tx_seqs.sv                                   //
//                                                                    //
//  Description   : This file defines a sequence to generate stimulus //
//                  packets for the yapp_tx system.                   //
//                                                                    //
//  version       : 02                                                //
///////////////////////////////////////////////////////////////////////

`ifndef SEQUENCES
`define SEQUENCES

// Class definition for sequences
class sequences extends uvm_sequence #(yapp_packet);
  
  // Factory registration for sequences
  `uvm_object_utils(sequences)
  
  // Extern constructor
  extern function new(string name = "sequences");

  // Extern body task
  extern task body();                     
  
endclass
`endif

// Constructor for sequences
function sequences::new(string name = "sequences");
  super.new(name);             
endfunction
  
// Body task
task sequences::body();
  // Raise objection to synchronize with other components
  if (starting_phase != null)
    starting_phase.raise_objection(this);  
    
  // Generate 15 randomized packets
  for (int i = 0; i < 15; i++)
  begin
    req = yapp_packet::type_id::create("req");
    start_item(req);
    req.randomize();                    
    finish_item(req);
  end
  
  // Drop objection after generating packets
  if (starting_phase != null)
    starting_phase.drop_objection(this);  
endtask
  
