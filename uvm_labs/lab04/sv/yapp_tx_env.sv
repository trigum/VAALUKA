
//////////////////////////////////////////////////////////////////////////////////////
//  File name     : yapp_tx_env.sv                                                  //
//                                                                                  //
//                                                                                  //
//  Description   : This file defines the environment for the TX application.       //  
//                  It creates an instance of the agent for driving transactions.   //
//                                                                                  //
//  Notes         : This environment sets up the test environment for               //
//                  transmitting packets using the agent.                           //
//////////////////////////////////////////////////////////////////////////////////////

`ifndef ENVIRONMENT
`define ENVIRONMENT

class environment extends uvm_env;
  
  // Factory registration
  `uvm_component_utils(environment)
  
  // Agent handle
  agent ag;
  
  // Constructor
  extern function new(string name = "environment", uvm_component parent = null);
 
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
function environment::new(string name = "environment", uvm_component parent = null);
  super.new(name, parent);
endfunction
  
// build_phase
function void environment::build_phase(uvm_phase phase);
  `uvm_info(get_name, "Entered build_phase", UVM_LOW)      
  // Call superclass build phase
  super.build_phase(phase);
  // Create the agent instance
  ag = agent::type_id::create("ag", this);
endfunction
  
// connect phase
function void environment::connect_phase(uvm_phase phase);  
  `uvm_info(get_name, "Entered connect_phase", UVM_LOW)
  // Call superclass connect phase
  super.connect_phase(phase);    
endfunction

// end_of_elaboration_phase
function void environment::end_of_elaboration_phase(uvm_phase phase);                             
  `uvm_info(get_name, "Entered end_of_elaboration_phase", UVM_LOW)
endfunction
  
// start_of_simulation_phase
function void environment::start_of_simulation_phase(uvm_phase phase);                            
  `uvm_info(get_name, "Entered start_of_simulation_phase", UVM_LOW)
endfunction

// run_phase
task environment::run_phase(uvm_phase phase);
  `uvm_info(get_name, "Entered run_phase", UVM_LOW)                                             
endtask
 
// extract phase
function void environment::extract_phase(uvm_phase phase); 
  `uvm_info(get_name, "Entered extract_phase", UVM_LOW)                                       
endfunction

// check phase
function void environment::check_phase(uvm_phase phase); 
  `uvm_info(get_name, "Entered check_phase", UVM_LOW)                                         
endfunction

// report phase
function void environment::report_phase(uvm_phase phase); 
  `uvm_info(get_name, "Entered report_phase", UVM_LOW)                                        
endfunction

// final phase
function void environment::final_phase(uvm_phase phase); 
  `uvm_info(get_name, "Entered final_phase", UVM_LOW)                                         
endfunction

`endif

