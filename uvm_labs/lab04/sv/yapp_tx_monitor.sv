
/////////////////////////////////////////////////////////////////////////
//  File name     : yapp_tx_monitor.sv                                 //
//                                                                     //  
//  Description   : This file defines the monitor component for        //
//                  observing signals from the interface.              //
//                                                                     //
//  version       : 02                                                 //
/////////////////////////////////////////////////////////////////////////

`ifndef MONITOR
`define MONITOR

class monitor extends uvm_monitor;
  
  // Factory registration
  `uvm_component_utils(monitor)
  
  // Constructor
  extern function new(string name = "monitor", uvm_component parent = null);
   
  // Phases
  extern function void build_phase(uvm_phase phase);                                  
  extern function void connect_phase(uvm_phase phase);                                 
  extern function void end_of_elaboration_phase(uvm_phase phase);                      
  extern function void start_of_simulation_phase(uvm_phase phase);     
  extern task run_phase(uvm_phase phase);                                            
  extern function void extract_phase(uvm_phase phase);                                 
  extern function void check_phase(uvm_phase phase);                                   
  extern function void report_phase(uvm_phase phase);                                 
  extern function void final_phase(uvm_phase phase);

endclass
  
// Constructor
function monitor::new(string name = "monitor", uvm_component parent = null);
  super.new(name, parent);
endfunction 

// build_phase
function void monitor::build_phase(uvm_phase phase);
  `uvm_info(get_name, "Entered build_phase", UVM_LOW)  
endfunction
  
// connect phase
function void monitor::connect_phase(uvm_phase phase);  
  `uvm_info(get_name, "Entered connect_phase", UVM_LOW)
  super.connect_phase(phase);    
endfunction

// end_of_elaboration_phase
function void monitor::end_of_elaboration_phase(uvm_phase phase);                             
  `uvm_info(get_name, "Entered end_of_elaboration_phase", UVM_LOW)
endfunction
  
// start_of_simulation_phase
function void monitor::start_of_simulation_phase(uvm_phase phase);                            
  `uvm_info(get_name, "Entered start_of_simulation_phase", UVM_LOW)
endfunction

// run_phase
task monitor::run_phase(uvm_phase phase);
  `uvm_info(get_name, "Entered run_phase", UVM_LOW)                                             
endtask
 
// extract phase
function void monitor::extract_phase(uvm_phase phase); 
  `uvm_info(get_name, "Entered extract_phase", UVM_LOW)                                       
endfunction

// check phase
function void monitor::check_phase(uvm_phase phase); 
  `uvm_info(get_name, "Entered check_phase", UVM_LOW)                                         
endfunction

// report phase
function void monitor::report_phase(uvm_phase phase); 
  `uvm_info(get_name, "Entered report_phase", UVM_LOW)                                        
endfunction

// final phase
function void monitor::final_phase(uvm_phase phase); 
  `uvm_info(get_name, "Entered final_phase", UVM_LOW)                                         
endfunction

`endif

