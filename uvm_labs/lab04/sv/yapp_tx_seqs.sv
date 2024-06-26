/////////////////////////////////////////////////////////////////////////
//  File name     : yapp_tx_seqs.sv                                    //
//                                                                     //
//  Description   : This file defines the sequences class responsible  //
//                  for generating stimulus.                           //
//                                                                     //
//  version       : 02                                                 //
/////////////////////////////////////////////////////////////////////////

`ifndef SEQUENCE
`define SEQUENCE

//-------------------------------------------------
// yapp_tx_seqs
//-------------------------------------------------
class sequences extends uvm_sequence #(yapp_packet);
`uvm_object_utils(sequences) 

extern function new(string name = "sequences"); 

extern task body(); 

endclass

// Constructor definition
function sequences::new(string name = "sequences");
  super.new(name);
endfunction

// Task body definition
task sequences::body();
  // Raise objection to starting phase if it's not null
  if (starting_phase == null)
    starting_phase.raise_objection(this);

  // Loop to generate 15 request items
  for (int i = 0; i < 15; i++) begin

    // Create a new request item
    req = yapp_packet::type_id::create("req");

    // Start the sequence item
    start_item(req);

    // Randomize the request item
    req.randomize();

    // Finish the sequence item
    finish_item(req);
  end

  // Drop objection to starting phase if it was raised
  if (starting_phase == null)    
    starting_phase.drop_objection(this);
endtask

`endif

