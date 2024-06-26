
/////////////////////////////////////////////////////////////////////////
//  File name     : yapp_tx_seqs.sv                                    //
//                                                                     //
//  Description   : This file defines the sequences class responsible  //
//                  for generating stimulus.                           //
//                                                                     //
//  version       : 02                                                 //
/////////////////////////////////////////////////////////////////////////


`ifndef SEQUENCES
`define SEQUENCES

class sequences extends uvm_sequence #(yapp_packet);

  // factory registration
  `uvm_object_utils(sequences)  

  // constructor declaration
  extern function new(string name = "sequences");
  
  // Task declarations
  extern task body();
  
endclass

`endif

// Constructor definition
function sequences::new(string name = "sequences");
  super.new(name);
endfunction

// Task body definition
task sequences::body();
  `uvm_info(get_name(), "Starting body() method", UVM_LOW);
  
  // raising objection
  if (starting_phase == null)
    starting_phase.raise_objection(this);
  
  // randomizing 15 packets
  for (int i = 0; i < 15; i++) begin
    req = yapp_packet::type_id::create("req");
    start_item(req);
    req.randomize();  
    finish_item(req);
  end
  
  // drop objection
  if (starting_phase == null)
    starting_phase.drop_objection(this);
  
  `uvm_info(get_name(), "Finished body() method", UVM_LOW);
endtask

