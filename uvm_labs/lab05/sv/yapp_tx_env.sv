
/////////////////////////////////////////////////////
//                                                 //
//  File name     : yapp_tx_env.sv                 //
//                                                 //
//  Description   : this file is to create agent   //
//                                                 //
//  version       : 02                             //
//                                                 //
/////////////////////////////////////////////////////

`ifndef ENVIRONMENT
`define ENVIRONMENT

class environment extends uvm_env;
  
  // Factory registration
  `uvm_component_utils(environment)
  
  // Declare agent instance
  agent ag;

  // Constructor declaration
  extern function new(string name = "environment", uvm_component parent = null);
 
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
function environment::new(string name = "environment", uvm_component parent = null);
  super.new(name, parent);
endfunction

// build_phase
function void environment::build_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in build_phase", UVM_LOW)
  super.build_phase(phase);
  // Create agent instance
  ag = agent::type_id::create("ag", this);
endfunction
  
// connect_phase
function void environment::connect_phase(uvm_phase phase);  
  super.connect_phase(phase);
  `uvm_info(get_name, "we are in connect_phase", UVM_LOW)
endfunction

// end_of_elaboration_phase
function void environment::end_of_elaboration_phase(uvm_phase phase);                             
  `uvm_info(get_name, "we are in EOE", UVM_LOW)
endfunction
  
// start_of_simulation_phase
function void environment::start_of_simulation_phase(uvm_phase phase);                            
  `uvm_info(get_name, "we are in SOS", UVM_LOW)
endfunction

// run_phase
task environment::run_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in run_phase", UVM_LOW)
endtask
 
// extract_phase
function void environment::extract_phase(uvm_phase phase); 
  `uvm_info(get_name, "we are in extract_phase", UVM_LOW)
endfunction

// check_phase
function void environment::check_phase(uvm_phase phase); 
  `uvm_info(get_name, "we are in check_phase", UVM_LOW)
endfunction

// report_phase
function void environment::report_phase(uvm_phase phase); 
  `uvm_info(get_name, "we are in report_phase", UVM_LOW)
endfunction

// final_phase
function void environment::final_phase(uvm_phase phase); 
  `uvm_info(get_name, "we are in final_phase", UVM_LOW)
endfunction

`endif

