
///////////////////////////////////////////////////////////////////////
//                                                                   //
//  File name     : yapp_tx_monitor.sv                               //
//                                                                   //
//  Description   : this file have to monitor signals from interface //
//                                                                   //
//  version       :  02                                              //
//                                                                   //
///////////////////////////////////////////////////////////////////////

`ifndef MONITOR
`define MONITOR

class monitor extends uvm_monitor;
  
  // Factory registration
  `uvm_component_utils(monitor)
  
  // Constructor declaration
  extern function new(string name = "monitor", uvm_component parent = null);
 
  // Phase declarations
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
  
// Constructor definition
function monitor::new(string name = "monitor", uvm_component parent = null);
  super.new(name, parent);
endfunction 

// build_phase
function void monitor::build_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in build_phase", UVM_LOW)
endfunction
  
// connect_phase
function void monitor::connect_phase(uvm_phase phase);  
  super.connect_phase(phase);    
  `uvm_info(get_name, "we are in connect_phase", UVM_LOW)
endfunction

// end_of_elaboration_phase
function void monitor::end_of_elaboration_phase(uvm_phase phase);                             
  `uvm_info(get_name, "we are in EOE", UVM_LOW)
endfunction
  
// start_of_simulation_phase
function void monitor::start_of_simulation_phase(uvm_phase phase);                            
  `uvm_info(get_name, "we are in SOS", UVM_LOW)
endfunction

// run_phase
task monitor::run_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in run_phase", UVM_LOW)
endtask
 
// extract_phase
function void monitor::extract_phase(uvm_phase phase); 
  `uvm_info(get_name, "we are in extract_phase", UVM_LOW)
endfunction

// check_phase
function void monitor::check_phase(uvm_phase phase); 
  `uvm_info(get_name, "we are in check_phase", UVM_LOW)
endfunction

// report_phase
function void monitor::report_phase(uvm_phase phase); 
  `uvm_info(get_name, "we are in report_phase", UVM_LOW)
endfunction

// final_phase
function void monitor::final_phase(uvm_phase phase); 
  `uvm_info(get_name, "we are in final_phase", UVM_LOW)
endfunction
  
`endif

