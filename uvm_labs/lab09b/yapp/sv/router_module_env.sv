
`ifndef MODULE
`define MODULE


class router_module_env extends uvm_env;
  `uvm_component_utils(router_module_env)
  
  router_scoreboard rsc;
  
  router_reference rr;

  extern function new(string name="router_module_env",uvm_component parent=null);
   
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
	
  function router_module_env::new(string name="router_module_env",uvm_component parent=null);
    super.new(name,parent);
  endfunction

  function void router_module_env::build_phase(uvm_phase phase);
    rsc=router_scoreboard::type_id::create("rsc",this);
    rr=router_reference::type_id::create("rr",this);
  endfunction


  function void router_module_env::connect_phase(uvm_phase phase);
    rr.r2s.connect(rsc.m2s);
  endfunction


   // end of elobaration phase

  function void router_module_env::end_of_elaboration_phase(uvm_phase phase);                             
    `uvm_info(get_name,"we are in EOE",UVM_LOW)
  endfunction
  
  // start of simulation phase

  function void router_module_env::start_of_simulation_phase(uvm_phase phase);                            
    `uvm_info(get_name,"we are in SOS",UVM_LOW)
  endfunction

  // run phase

  task router_module_env::run_phase(uvm_phase phase);
    `uvm_info(get_name,"we are in run_phase",UVM_LOW)                                              // run phase which print topology
  endtask
 
  // extract phase

  function void router_module_env::extract_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in extract_phase",UVM_LOW)                                       
  endfunction

  // check phase

  function void router_module_env::check_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in check_phase",UVM_LOW)                                         
  endfunction

  // report phase

  function void router_module_env::report_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in report_phase",UVM_LOW)                                        
  endfunction

  // final phase

  function void router_module_env::final_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in final_phase",UVM_LOW)                                         
  endfunction

  `endif
	
