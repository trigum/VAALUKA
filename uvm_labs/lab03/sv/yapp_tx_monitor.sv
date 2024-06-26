

/////////////////////////////////////////////////////////////////////////
//  File name     : yapp_tx_monitor.sv                                 //
//                                                                     //  
//  Description   : This file defines the monitor component for        //
//                  observing signals from the interface.              //
//                                                                     //
//  Notes         : This monitor class is responsible for monitoring   //
//                  signals from the interface and providing relevant  //
//                  information during simulation phases.              //
/////////////////////////////////////////////////////////////////////////


`ifndef MONITOR
`define MONITOR

class monitor extends uvm_monitor;
  
  `uvm_component_utils(monitor)  
  
  // Constructor declaration
  extern function new(string name = "monitor", uvm_component parent = null);
  
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
function monitor::new(string name = "monitor", uvm_component parent = null);
  super.new(name, parent);
endfunction 

// Build phase definition
function void monitor::build_phase(uvm_phase phase);
  `uvm_info(get_name, "Entering build_phase", UVM_LOW)  
endfunction
  
// Connect phase definition
function void monitor::connect_phase(uvm_phase phase);  
  `uvm_info(get_name, "Entering connect_phase", UVM_LOW)
  super.connect_phase(phase);    
endfunction

// End of elaboration phase definition
function void monitor::end_of_elaboration_phase(uvm_phase phase);                             
  `uvm_info(get_name, "Entering end_of_elaboration_phase", UVM_LOW)
endfunction
  
// Start of simulation phase definition
function void monitor::start_of_simulation_phase(uvm_phase phase);                            
  `uvm_info(get_name, "Entering start_of_simulation_phase", UVM_LOW)
endfunction

// Run phase definition
task monitor::run_phase(uvm_phase phase);
  `uvm_info(get_name, "Entering run_phase", UVM_LOW)                                              
endtask
 
// Extract phase definition
function void monitor::extract_phase(uvm_phase phase); 
  `uvm_info(get_name, "Entering extract_phase", UVM_LOW)                                       
endfunction

// Check phase definition
function void monitor::check_phase(uvm_phase phase); 
  `uvm_info(get_name, "Entering check_phase", UVM_LOW)                                         
endfunction

// Report phase definition
function void monitor::report_phase(uvm_phase phase); 
  `uvm_info(get_name, "Entering report_phase", UVM_LOW)                                        
endfunction

// Final phase definition
function void monitor::final_phase(uvm_phase phase); 
  `uvm_info(get_name, "Entering final_phase", UVM_LOW)                                         
endfunction

