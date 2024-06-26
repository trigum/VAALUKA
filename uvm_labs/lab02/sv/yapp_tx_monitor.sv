///////////////////////////////////////////////////////////////////////
//  File name     : yapp_tx_monitor.sv                                //
//                                                                    //
//  Description   : This file defines the monitor for monitoring      //
//                  signals from the interface in the yapp_tx system. //
//                                                                    //
//   version      : 02                                                //
///////////////////////////////////////////////////////////////////////

`ifndef MONITOR
`define MONITOR

// Class definition for the monitor
class monitor extends uvm_monitor;
   
  // Factory registration for the monitor
  `uvm_component_utils(monitor)

  // Extern constructor
  extern function new(string name = "monitor", uvm_component parent = null);
   
  // Extern build phase function
  extern function void build_phase(uvm_phase phase);                                  
 
  // Extern connect phase function
  extern function void connect_phase(uvm_phase phase);                                 

  // Extern end of elaboration phase function
  extern function void end_of_elaboration_phase(uvm_phase phase);                      
  
  // Extern start of simulation phase function
  extern function void start_of_simulation_phase(uvm_phase phase);     
  
  // Extern run phase task
  extern task run_phase(uvm_phase phase);                                       
  
  // Extern extract phase function
  extern function void extract_phase(uvm_phase phase);                                 
  
  // Extern check phase function
  extern function void check_phase(uvm_phase phase);                                   
  
  // Extern report phase function
  extern function void report_phase(uvm_phase phase);                                 
  
  // Extern final phase function
  extern function void final_phase(uvm_phase phase);

endclass

`endif

// Constructor for the monitor
function monitor::new(string name = "monitor", uvm_component parent = null);
  super.new(name, parent);             
endfunction 

// Build phase
function void monitor::build_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in build_phase: Setting up monitor components", UVM_LOW);  
endfunction

// Connect phase
function void monitor::connect_phase(uvm_phase phase);  
  super.connect_phase(phase);    
  `uvm_info(get_name, "we are in connect_phase: Connecting to design hierarchy", UVM_LOW);
endfunction

// End of elaboration phase
function void monitor::end_of_elaboration_phase(uvm_phase phase);                             
  `uvm_info(get_name, "we are in end_of_elaboration_phase: Finalizing monitor setup", UVM_LOW);
endfunction

// Start of simulation phase
function void monitor::start_of_simulation_phase(uvm_phase phase);                            
  `uvm_info(get_name, "we are in start_of_simulation_phase: Starting simulation", UVM_LOW);
endfunction

// Run phase
task monitor::run_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in run_phase: Monitoring signals", UVM_LOW);                                                       
endtask
 
// Extract phase
function void monitor::extract_phase(uvm_phase phase); 
  `uvm_info(get_name, "we are in extract_phase: Extracting results", UVM_LOW);                                       
endfunction

// Check phase
function void monitor::check_phase(uvm_phase phase); 
  `uvm_info(get_name, "we are in check_phase: Checking for errors", UVM_LOW);                                         
endfunction

// Report phase
function void monitor::report_phase(uvm_phase phase); 
  `uvm_info(get_name, "we are in report_phase: Generating reports", UVM_LOW);                                        
endfunction

// Final phase
function void monitor::final_phase(uvm_phase phase); 
  `uvm_info(get_name, "we are in final_phase: Finalizing simulation", UVM_LOW);                                         
endfunction

