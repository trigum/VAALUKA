
////////////////////////////////////////////////////////////////////////////////////
// File name   : yapp_tx_sequencer.sv                                             //
//                                                                                //
// Description : Defines the sequencer component for managing sequences.          //
//                                                                                //
// Notes       : This file defines a sequencer that acts as an intermediary       //
//               between the driver and sequence components in a UVM environment. //
////////////////////////////////////////////////////////////////////////////////////

`ifndef SEQUENCER
`define SEQUENCER

class sequencer extends uvm_sequencer #(yapp_packet);
  
  `uvm_component_utils(sequencer);

  // Constructor declaration
  extern function new(string name="sequencer", uvm_component parent=null);
    
  // Build phase declaration
  extern function void build_phase(uvm_phase phase);                                  
 
  // Connect phase declaration
  extern function void connect_phase(uvm_phase phase);                                 

  // End of elaboration phase declaration
  extern function void end_of_elaboration_phase(uvm_phase phase);                      
  
  // Start of simulation phase declaration
  extern function void start_of_simulation_phase(uvm_phase phase);     
  
  // Run phase declaration
  extern task run_phase(uvm_phase phase);                                                  
  
  // Extract phase declaration
  extern function void extract_phase(uvm_phase phase);                                 
  
  // Check phase declaration
  extern function void check_phase(uvm_phase phase);                                   
  
  // Report phase declaration
  extern function void report_phase(uvm_phase phase);                                 
  
  // Final phase declaration
  extern function void final_phase(uvm_phase phase);

endclass

`endif

// Constructor definition
function sequencer::new(string name="sequencer", uvm_component parent=null);
  super.new(name, parent);   
endfunction

// Build phase definition
function void sequencer::build_phase(uvm_phase phase);
  `uvm_info(get_name,"we are in build_phase",UVM_LOW) 
endfunction
  
// Connect phase definition
function void sequencer::connect_phase(uvm_phase phase);  
  super.connect_phase(phase); 
  `uvm_info(get_name,"we are in connect_phase",UVM_LOW) 
endfunction

// End of elaboration phase definition
function void sequencer::end_of_elaboration_phase(uvm_phase phase);                             
  `uvm_info(get_name,"we are in EOE",UVM_LOW) 
endfunction
  
// Start of simulation phase definition
function void sequencer::start_of_simulation_phase(uvm_phase phase);                            
  `uvm_info(get_name,"we are in SOS",UVM_LOW) 
endfunction

// Run phase definition
task sequencer::run_phase(uvm_phase phase);
  `uvm_info(get_name,"we are in run_phase",UVM_LOW)
endtask
 
// Extract phase definition
function void sequencer::extract_phase(uvm_phase phase); 
  `uvm_info(get_name,"we are in extract_phase",UVM_LOW) 
endfunction

// Check phase definition
function void sequencer::check_phase(uvm_phase phase); 
  `uvm_info(get_name,"we are in check_phase",UVM_LOW) 
endfunction

// Report phase definition
function void sequencer::report_phase(uvm_phase phase); 
  `uvm_info(get_name,"we are in report_phase",UVM_LOW) 
endfunction

// Final phase definition
function void sequencer::final_phase(uvm_phase phase); 
  `uvm_info(get_name,"we are in final_phase",UVM_LOW) 
endfunction

