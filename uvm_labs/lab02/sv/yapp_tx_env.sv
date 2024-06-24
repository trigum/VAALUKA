
///////////////////////////////////////////////////////////////////////
//  File name     : yapp_tx_env.sv                                   //
//                                                                   //
//  Description   : this file have tx agent                          //
//                                                                   //
//  Notes         : it have the control over agent                   //
///////////////////////////////////////////////////////////////////////

`ifndef ENVIRONMENT

`define ENVIRONMENT

class environment extends uvm_env;
 
// factory registration
  `uvm_component_utils(environment)                                                     // environment registration in factory
  
  agent ag;                                                                             // agent handle 

  extern function new(string name="environment",uvm_component parent=null);
  
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
 
`endif

  // constructor 

  function environment::new(string name="environment",uvm_component parent=null);
    super.new(name,parent);             
  endfunction
  
  // build_phase

  function void environment::build_phase(uvm_phase phase);
    `uvm_info(get_name,"we are in build_phase",UVM_LOW)  
    super.build_phase(phase);                                                           // build phase which creating object for agent
    ag = agent::type_id::create("ag",this);
  endfunction
  
  // connect phase
  
  function void environment::connect_phase(uvm_phase phase); 
    super.connect_phase(phase); 
    `uvm_info(get_name,"we are in connect_phase",UVM_LOW)
  endfunction

  // end of elobaration phase

  function void environment::end_of_elaboration_phase(uvm_phase phase);                             
    `uvm_info(get_name,"we are in EOE",UVM_LOW)
  endfunction
  
  // start of simulation phase

  function void environment::start_of_simulation_phase(uvm_phase phase);                            
    `uvm_info(get_name,"we are in SOS",UVM_LOW)
  endfunction

  // run phase

  task environment::run_phase(uvm_phase phase);
    `uvm_info(get_name,"we are in run_phase",UVM_LOW) 
      print();                                                                          // run phase which print topology
  endtask
 
  // extract phase

  function void environment::extract_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in extract_phase",UVM_LOW)                                       
  endfunction

  // check phase

  function void environment::check_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in check_phase",UVM_LOW)                                         
  endfunction

  // report phase

  function void environment::report_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in report_phase",UVM_LOW)                                        
  endfunction

  // final phase

  function void environment::final_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in final_phase",UVM_LOW)                                         
  endfunction

