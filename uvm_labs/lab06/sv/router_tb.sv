

/*-----------------------------------------------------------------
File name     : router_tb.sv
Description   : this file is junction for tx and rx
Notes         : 
-------------------------------------------------------------------
-----------------------------------------------------------------*/

//------------------------------------------------------------------------------
//
// router tb
//
//------------------------------------------------------------------------------
//
`ifndef ROUTER_TB
`define ROUTER_TB
class router_tb extends uvm_component;
  `uvm_component_utils(router_tb)
  
  environment env;
  
  extern function new(string name="router_tb",uvm_component parent=null);
  
  extern function void build_phase(uvm_phase phase);                                  
 
  extern function void connect_phase(uvm_phase phase);                                 

  extern function void end_of_elaboration_phase(uvm_phase phase);                      
  
  extern function void start_of_simulation_phase(uvm_phase phase);     
  
  extern task run_phase(uvm_phase phase);                                                  // extern  phases
  
  extern function void extract_phase(uvm_phase phase);                                 
  
  extern function void check_phase(uvm_phase phase);                                   
  
  extern function void report_phase(uvm_phase phase);                                 
  
  extern function void final_phase(uvm_phase phase);

endclass
  
  // constructor

  function router_tb::new(string name="router_tb",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  // build_phase 

  function void router_tb::build_phase(uvm_phase phase);
    `uvm_info(get_name,"we are in build_phase",UVM_LOW)      
    super.build_phase(phase);
    set_config_int("*","recording_details",1);
    env=environment::type_id::create("env",this);
  endfunction
  
   // connect phase
  
  function void router_tb::connect_phase(uvm_phase phase);  
    super.connect_phase(phase);    
    `uvm_info(get_name,"we are in connect_phase",UVM_LOW)
  endfunction

  // end of elobaration phase

  function void router_tb::end_of_elaboration_phase(uvm_phase phase);                             
    `uvm_info(get_name,"we are in EOE",UVM_LOW)
  endfunction
  
  // start of simulation phase

  function void router_tb::start_of_simulation_phase(uvm_phase phase);                            
    `uvm_info(get_name,"we are in SOS",UVM_LOW)
  endfunction

  // run phase

  task router_tb::run_phase(uvm_phase phase);
    `uvm_info(get_name,"we are in run_phase",UVM_LOW)                                              // run phase which print topology
  endtask
 
  // extract phase

  function void router_tb::extract_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in extract_phase",UVM_LOW)                                       
  endfunction

  // check phase

  function void router_tb::check_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in check_phase",UVM_LOW)                                         
  endfunction

  // report phase

  function void router_tb::report_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in report_phase",UVM_LOW)                                        
  endfunction

  // final phase

  function void router_tb::final_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in final_phase",UVM_LOW)                                         
  endfunction

`endif
