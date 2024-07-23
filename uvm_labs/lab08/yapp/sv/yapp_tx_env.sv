
///////////////////////////////////////////////////////////////////////
//  File name     : yapp_tx_env.sv                                   //
//                                                                   //
//  Description   : This file defines the UVM environment class that //
//                  contains and manages the agent.                  //
//                                                                   //
//  version       : 1.0                                              //
///////////////////////////////////////////////////////////////////////

`ifndef ENVIRONMENT
`define ENVIRONMENT

/////////////////////////////
//                         //
//    ENVIRONMENT          //
//                         //
/////////////////////////////

class environment extends uvm_env;
  
  // Register the class with the UVM factory
  `uvm_component_utils(environment)
  
  // Declare a handle for the agent
  agent ag;
  
  // Constructor declaration
  extern function new(string name="environment",uvm_component parent=null);
 
  // Phase functions declarations
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

  // Constructor implementation
  function environment::new(string name="environment",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  // Build phase implementation
  function void environment::build_phase(uvm_phase phase);
    `uvm_info(get_name,"we are in build_phase",UVM_LOW)      
    super.build_phase(phase);
    // Create an instance of the agent
    ag = agent::type_id::create("ag", this);
  endfunction
  
  // Connect phase implementation
  function void environment::connect_phase(uvm_phase phase);  
    super.connect_phase(phase);    
    `uvm_info(get_name,"we are in connect_phase",UVM_LOW)
  endfunction

  // End of elaboration phase implementation
  function void environment::end_of_elaboration_phase(uvm_phase phase);                             
    `uvm_info(get_name,"we are in EOE",UVM_LOW)
  endfunction
  
  // Start of simulation phase implementation
  function void environment::start_of_simulation_phase(uvm_phase phase);                            
    `uvm_info(get_name,"we are in SOS",UVM_LOW)
  endfunction

  // Run phase implementation
  task environment::run_phase(uvm_phase phase);
    `uvm_info(get_name,"we are in run_phase",UVM_LOW)                                         
  endtask
 
  // Extract phase implementation
  function void environment::extract_phase(uvm_phase phase); 
    `uvm_info(get_name,"we are in extract_phase",UVM_LOW)                                       
  endfunction

  // Check phase implementation
  function void environment::check_phase(uvm_phase phase); 
    `uvm_info(get_name,"we are in check_phase",UVM_LOW)                                         
  endfunction

  // Report phase implementation
  function void environment::report_phase(uvm_phase phase); 
    `uvm_info(get_name,"we are in report_phase",UVM_LOW)                                        
  endfunction

  // Final phase implementation
  function void environment::final_phase(uvm_phase phase); 
    `uvm_info(get_name,"we are in final_phase",UVM_LOW)                                         
  endfunction

`endif

