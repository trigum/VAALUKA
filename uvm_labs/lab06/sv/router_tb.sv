

//////////////////////////////////////////////////////////////
//                                                          //
//  File name     : router_tb.sv                            //
//                                                          //
//  Description   : this file is a junction for tx and rx   //
//                                                          //
//  version       :  02                                     //
//                                                          //
//////////////////////////////////////////////////////////////


`ifndef ROUTER_TB
`define ROUTER_TB

// Class declaration extending uvm_component
class router_tb extends uvm_component;
  // Factory registration macro
  `uvm_component_utils(router_tb)
  
  // Environment handle
  environment env;
  
  // Constructor declaration
  extern function new(string name="router_tb", uvm_component parent=null);
  
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
function router_tb::new(string name="router_tb", uvm_component parent=null);
  // Call the base class constructor
  super.new(name, parent);
endfunction

// Build phase definition
function void router_tb::build_phase(uvm_phase phase);
  // Print a message indicating the build phase has started
  `uvm_info(get_name, "we are in build_phase", UVM_LOW)      
  // Call the base class build_phase method
  super.build_phase(phase);
  // Set configuration for recording details
  set_config_int("*", "recording_details", 1);
  // Create the environment
  env = environment::type_id::create("env", this);
endfunction

// Connect phase definition
function void router_tb::connect_phase(uvm_phase phase);
  // Call the base class connect_phase method  
  super.connect_phase(phase);    
  // Print a message indicating the connect phase has started
  `uvm_info(get_name, "we are in connect_phase", UVM_LOW)
endfunction

// End of elaboration phase definition
function void router_tb::end_of_elaboration_phase(uvm_phase phase);
  // Print a message indicating the end of elaboration phase has started                             
  `uvm_info(get_name, "we are in EOE", UVM_LOW)
endfunction

// Start of simulation phase definition
function void router_tb::start_of_simulation_phase(uvm_phase phase);
  // Print a message indicating the start of simulation phase has started                            
  `uvm_info(get_name, "we are in SOS", UVM_LOW)
endfunction

// Run phase definition
task router_tb::run_phase(uvm_phase phase);
  // Print a message indicating the run phase has started
  `uvm_info(get_name, "we are in run_phase", UVM_LOW)                                              
endtask

// Extract phase definition
function void router_tb::extract_phase(uvm_phase phase);
  // Print a message indicating the extract phase has started 
  `uvm_info(get_name, "we are in extract_phase", UVM_LOW)                                       
endfunction

// Check phase definition
function void router_tb::check_phase(uvm_phase phase);
  // Print a message indicating the check phase has started 
  `uvm_info(get_name, "we are in check_phase", UVM_LOW)                                         
endfunction

// Report phase definition
function void router_tb::report_phase(uvm_phase phase);
  // Print a message indicating the report phase has started 
  `uvm_info(get_name, "we are in report_phase", UVM_LOW)                                        
endfunction

// Final phase definition
function void router_tb::final_phase(uvm_phase phase);
  // Print a message indicating the final phase has started 
  `uvm_info(get_name, "we are in final_phase", UVM_LOW)                                         
endfunction

`endif

