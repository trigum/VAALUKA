
///////////////////////////////////////////////////////////
//                                                       //
// File name     : router_tb.sv                          // 
//                                                       //
// Description   : this file is junction for tx and rx   //
//                                                       //
// version       : 2.0                                   //
//                                                       //
///////////////////////////////////////////////////////////


`ifndef ROUTER_TB
`define ROUTER_TB

class router_tb extends uvm_component;

  // Utility macro to register the component with UVM factory
  `uvm_component_utils(router_tb)

  // Environment instance
  environment env;

  // Channel environment instances
  channel_env ch0_env;
  channel_env ch1_env;
  channel_env ch2_env;

  // HBus environment instance
  hbus_env h_env;


  // Constructor
  extern function new(string name = "router_tb", uvm_component parent = null);

  // Build phase method declaration
  extern function void build_phase(uvm_phase phase);

  // Connect phase method declaration
  extern function void connect_phase(uvm_phase phase);

  // End of elaboration phase method declaration
  extern function void end_of_elaboration_phase(uvm_phase phase);

  // Start of simulation phase method declaration
  extern function void start_of_simulation_phase(uvm_phase phase);

  // Run phase task declaration
  extern task run_phase(uvm_phase phase);

  // Extract phase method declaration
  extern function void extract_phase(uvm_phase phase);

  // Check phase method declaration
  extern function void check_phase(uvm_phase phase);

  // Report phase method declaration
  extern function void report_phase(uvm_phase phase);

  // Final phase method declaration
  extern function void final_phase(uvm_phase phase);

endclass


// Constructor

function router_tb::new(string name = "router_tb", uvm_component parent = null);
  // Call parent constructor
  super.new(name, parent);
endfunction


// Build phase 

function void router_tb::build_phase(uvm_phase phase);

  // Print build phase message
  `uvm_info(get_name, "we are in build_phase", UVM_LOW)

  // Call parent build phase
  super.build_phase(phase);

  // Set configuration parameters
  set_config_int("*", "recording_details", 1);
  set_config_int("*", "has_tx", 0);
  set_config_int("*", "num_masters", 1);
  set_config_int("*", "num_slaves", 0);
    
  // Create environment and channel environment instances
  env = environment::type_id::create("env", this);
  ch0_env = channel_env::type_id::create("ch0_env", this);
  ch1_env = channel_env::type_id::create("ch1_env", this);
  ch2_env = channel_env::type_id::create("ch2_env", this);
  h_env = hbus_env::type_id::create("h_env", this);

endfunction


// Connect phase

function void router_tb::connect_phase(uvm_phase phase);

  // Call parent connect phase
  super.connect_phase(phase);

  // Print connect phase message    
  `uvm_info(get_name, "we are in connect_phase", UVM_LOW)

endfunction


// End of elaboration phase

function void router_tb::end_of_elaboration_phase(uvm_phase phase);

  // Print end of elaboration phase message
  `uvm_info(get_name, "we are in EOE", UVM_LOW)

endfunction


// Start of simulation phase

function void router_tb::start_of_simulation_phase(uvm_phase phase);

  // Print start of simulation phase message
  `uvm_info(get_name, "we are in SOS", UVM_LOW)

endfunction


// Run phase

task router_tb::run_phase(uvm_phase phase);

  // Print run phase message
  `uvm_info(get_name, "we are in run_phase", UVM_LOW)

endtask


// Extract phase

function void router_tb::extract_phase(uvm_phase phase);

  // Print extract phase message
  `uvm_info(get_name, "we are in extract_phase", UVM_LOW)

endfunction


// Check phase

function void router_tb::check_phase(uvm_phase phase);

  // Print check phase message
  `uvm_info(get_name, "we are in check_phase", UVM_LOW)

endfunction


// Report phase

function void router_tb::report_phase(uvm_phase phase);

  // Print report phase message
  `uvm_info(get_name, "we are in report_phase", UVM_LOW)

endfunction


// Final phase

function void router_tb::final_phase(uvm_phase phase);

  // Print final phase message
  `uvm_info(get_name, "we are in final_phase", UVM_LOW)

endfunction

`endif

