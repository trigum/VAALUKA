

//////////////////////////////////////////////////////////////////////////////////////
//  File name     : yapp_tx_env.sv                                                  //
//                                                                                  //
//                                                                                  //
//  Description   : This file defines the environment for the TX application.       //  
//                  It creates an instance of the agent for driving transactions.   //
//                                                                                  //
//  version       : 02                                                              //
//////////////////////////////////////////////////////////////////////////////////////


`ifndef ENVIRONMENT
`define ENVIRONMENT

class environment extends uvm_env;

  // factory registration
  `uvm_component_utils(environment)  

  // agent handle declaration  
  agent ag;  
  
  // Constructor declaration
  extern function new(string name = "environment", uvm_component parent = null);
  
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
function environment::new(string name = "environment", uvm_component parent = null);
  super.new(name, parent);
endfunction

// Build phase definition
function void environment::build_phase(uvm_phase phase);
  `uvm_info(get_name, "Entering build_phase", UVM_LOW)    
  super.build_phase(phase);
  
  // Create an instance of the agent
  ag = agent::type_id::create("ag", this);
endfunction

// Connect phase definition
function void environment::connect_phase(uvm_phase phase);  
  `uvm_info(get_name, "Entering connect_phase", UVM_LOW)
  super.connect_phase(phase);    
  
  // Connect agent's sequencer to driver's sequence item export
  ag.dr.seq_item_port.connect(ag.seqr.seq_item_export);
endfunction

// End of elaboration phase definition
function void environment::end_of_elaboration_phase(uvm_phase phase);                             
  `uvm_info(get_name, "Entering end_of_elaboration_phase", UVM_LOW)
endfunction
  
// Start of simulation phase definition
function void environment::start_of_simulation_phase(uvm_phase phase);                            
  `uvm_info(get_name, "Entering start_of_simulation_phase", UVM_LOW)
endfunction

// Run phase definition
task environment::run_phase(uvm_phase phase);
  `uvm_info(get_name, "Entering run_phase", UVM_LOW)
  
  // Placeholder for run phase functionality (to be implemented)
endtask
 
// Extract phase definition
function void environment::extract_phase(uvm_phase phase); 
  `uvm_info(get_name, "Entering extract_phase", UVM_LOW)
endfunction

// Check phase definition
function void environment::check_phase(uvm_phase phase); 
  `uvm_info(get_name, "Entering check_phase", UVM_LOW)
endfunction

// Report phase definition
function void environment::report_phase(uvm_phase phase); 
  `uvm_info(get_name, "Entering report_phase", UVM_LOW)
endfunction

// Final phase definition
function void environment::final_phase(uvm_phase phase); 
  `uvm_info(get_name, "Entering final_phase", UVM_LOW)
endfunction

