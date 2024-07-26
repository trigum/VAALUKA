

///////////////////////////////////////////////////////////////////////
//  File name     : yapp_tx_env.sv                                   //
//                                                                   //
//  Description   : This file defines the environment for the YAPP    //
//                  router testbench.                                 //
//                                                                   //
//  Version       : 2.0                                              //
///////////////////////////////////////////////////////////////////////

`ifndef ENVIRONMENT
`define ENVIRONMENT

class environment extends uvm_env;
  
  // Factory registration
  `uvm_component_utils(environment)
  
  // Agent handle
  agent ag;

  // Constructor
  extern function new(string name="environment", uvm_component parent=null);
  
  // Phase functions
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

// Implementation of the constructor
function environment::new(string name="environment", uvm_component parent=null);
  super.new(name, parent);
endfunction

// Implementation of the build_phase function
function void environment::build_phase(uvm_phase phase);
  `uvm_info(get_name(), "Entering build_phase", UVM_LOW)
  super.build_phase(phase);
  ag = agent::type_id::create("ag", this);
endfunction

// Implementation of the connect_phase function
function void environment::connect_phase(uvm_phase phase);  
  super.connect_phase(phase);    
  `uvm_info(get_name(), "Entering connect_phase", UVM_LOW)
endfunction

// Implementation of the end_of_elaboration_phase function
function void environment::end_of_elaboration_phase(uvm_phase phase);                             
  `uvm_info(get_name(), "Entering end_of_elaboration_phase", UVM_LOW)
endfunction
  
// Implementation of the start_of_simulation_phase function
function void environment::start_of_simulation_phase(uvm_phase phase);                            
  `uvm_info(get_name(), "Entering start_of_simulation_phase", UVM_LOW)
endfunction

// Implementation of the run_phase task
task environment::run_phase(uvm_phase phase);
  `uvm_info(get_name(), "Entering run_phase", UVM_LOW)                                              
endtask

// Implementation of the extract_phase function
function void environment::extract_phase(uvm_phase phase); 
  `uvm_info(get_name(), "Entering extract_phase", UVM_LOW)                                       
endfunction

// Implementation of the check_phase function
function void environment::check_phase(uvm_phase phase); 
  `uvm_info(get_name(), "Entering check_phase", UVM_LOW)                                         
endfunction

// Implementation of the report_phase function
function void environment::report_phase(uvm_phase phase); 
  `uvm_info(get_name(), "Entering report_phase", UVM_LOW)                                        
endfunction

// Implementation of the final_phase function
function void environment::final_phase(uvm_phase phase); 
  `uvm_info(get_name(), "Entering final_phase", UVM_LOW)                                         
endfunction

`endif

