


///////////////////////////////////////////////////////////////////////
//  File name     : yapp_tx_env.sv                                   //
//                                                                   //
//  Description   : This file contains the tx agent.                 //
//                                                                   //
//  Notes         : It has control over the agent.                   //
///////////////////////////////////////////////////////////////////////

`ifndef ENVIRONMENT
`define ENVIRONMENT

// Class definition for the environment
class environment extends uvm_env;

  // Factory registration for the environment
  `uvm_component_utils(environment)

  // Agent handle
  agent ag;

  // Extern constructor
  extern function new(string name = "environment", uvm_component parent = null);

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

// Constructor for the environment
function environment::new(string name = "environment", uvm_component parent = null);
  super.new(name, parent);
endfunction

// Build phase
function void environment::build_phase(uvm_phase phase);
  `uvm_info(get_name, "We are in build_phase", UVM_LOW)
  super.build_phase(phase);  
  ag = agent::type_id::create("ag", this);
endfunction

// Connect phase
function void environment::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  `uvm_info(get_name, "We are in connect_phase", UVM_LOW)
endfunction

// End of elaboration phase
function void environment::end_of_elaboration_phase(uvm_phase phase);
  `uvm_info(get_name, "We are in end_of_elaboration_phase", UVM_LOW)
endfunction

// Start of simulation phase
function void environment::start_of_simulation_phase(uvm_phase phase);
  `uvm_info(get_name, "We are in start_of_simulation_phase", UVM_LOW)
endfunction

// Run phase
task environment::run_phase(uvm_phase phase);
  `uvm_info(get_name, "We are in run_phase", UVM_LOW)
  print();  // Print topology
endtask

// Extract phase
function void environment::extract_phase(uvm_phase phase);
  `uvm_info(get_name, "We are in extract_phase", UVM_LOW)
endfunction

// Check phase
function void environment::check_phase(uvm_phase phase);
  `uvm_info(get_name, "We are in check_phase", UVM_LOW)
endfunction

// Report phase
function void environment::report_phase(uvm_phase phase);
  `uvm_info(get_name, "We are in report_phase", UVM_LOW)
endfunction

// Final phase
function void environment::final_phase(uvm_phase phase);
  `uvm_info(get_name, "We are in final_phase", UVM_LOW)
endfunction

