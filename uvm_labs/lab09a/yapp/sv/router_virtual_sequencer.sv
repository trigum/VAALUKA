///////////////////////////////////////////////////////////////////////
//  File name     : router_virtual_sequencer                         //
//                                                                   //
//  Description   : this is a virtual sequence                       //
//                                                                   //
//  Version       : 2.0                                              //
///////////////////////////////////////////////////////////////////////


`ifndef VIRTUAL_SEQUENCER
`define VIRTUAL_SEQUENCER

class router_virtual_sequencer extends uvm_sequencer;
  `uvm_component_utils(router_virtual_sequencer)

  // Declaration of hbus_master_sequencer instance
  hbus_master_sequencer h_seqr;

  // Declaration of another sequencer instance
  sequencer seqr;

  // Constructor
  extern function new(string name="router_virtual_sequencer", uvm_component parent=null);
  
  // Build phase
  extern function void build_phase(uvm_phase phase);                                  
  
  // Connect phase
  extern function void connect_phase(uvm_phase phase);                                 

  // End of elaboration phase
  extern function void end_of_elaboration_phase(uvm_phase phase);                      
  
  // Start of simulation phase
  extern function void start_of_simulation_phase(uvm_phase phase);     
  
  // Run phase
  extern task run_phase(uvm_phase phase);                                                  
  
  // Extract phase
  extern function void extract_phase(uvm_phase phase);                                 
  
  // Check phase
  extern function void check_phase(uvm_phase phase);                                   
  
  // Report phase
  extern function void report_phase(uvm_phase phase);                                 
  
  // Final phase
  extern function void final_phase(uvm_phase phase);

endclass

// Implementation of the constructor
function router_virtual_sequencer::new(string name="router_virtual_sequencer", uvm_component parent=null);
  super.new(name, parent);
endfunction

// Implementation of the build phase
function void router_virtual_sequencer::build_phase(uvm_phase phase);
  `uvm_info(get_name(), "we are in build_phase", UVM_LOW)  
endfunction
  
// Implementation of the connect phase
function void router_virtual_sequencer::connect_phase(uvm_phase phase);  
  `uvm_info(get_name(), "we are in connect_phase", UVM_LOW)    
  super.connect_phase(phase);    
endfunction

// Implementation of the end of elaboration phase
function void router_virtual_sequencer::end_of_elaboration_phase(uvm_phase phase);                             
  `uvm_info(get_name(), "we are in EOE", UVM_LOW)
endfunction
  
// Implementation of the start of simulation phase
function void router_virtual_sequencer::start_of_simulation_phase(uvm_phase phase);                            
  `uvm_info(get_name(), "we are in SOS", UVM_LOW)
endfunction

// Implementation of the run phase
task router_virtual_sequencer::run_phase(uvm_phase phase);
  `uvm_info(get_name(), "we are in run_phase", UVM_LOW)                                              
endtask
 
// Implementation of the extract phase
function void router_virtual_sequencer::extract_phase(uvm_phase phase); 
  `uvm_info(get_name(), "we are in extract_phase", UVM_LOW)                                       
endfunction

// Implementation of the check phase
function void router_virtual_sequencer::check_phase(uvm_phase phase); 
  `uvm_info(get_name(), "we are in check_phase", UVM_LOW)                                         
endfunction

// Implementation of the report phase
function void router_virtual_sequencer::report_phase(uvm_phase phase); 
  `uvm_info(get_name(), "we are in report_phase", UVM_LOW)                                        
endfunction

// Implementation of the final phase
function void router_virtual_sequencer::final_phase(uvm_phase phase); 
  `uvm_info(get_name(), "we are in final_phase", UVM_LOW)                                         
endfunction

`endif

