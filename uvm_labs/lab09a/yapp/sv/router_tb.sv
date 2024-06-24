
`ifndef ROUTER_TB
`define ROUTER_TB

class router_tb extends uvm_component;
  `uvm_component_utils(router_tb)
  
  environment env;
  
  channel_env ch0_env;
  
  channel_env ch1_env;
  
  channel_env ch2_env;
  
  hbus_env h_env;
  
  router_virtual_sequencer rv_seqr;
  
  router_scoreboard rsc;


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

  function router_tb::new(string name="router_tb",uvm_component parent=null);
    super.new(name,parent);
  endfunction

  function void router_tb::build_phase(uvm_phase phase);
    super.build_phase(phase);
    set_config_int("*","recording_details",1);
    set_config_int("*","has_tx",0);
    set_config_int("*","num_masters",1);
    set_config_int("*","num_slaves",0);
    
    env=environment::type_id::create("env",this);
    ch0_env=channel_env::type_id::create("ch0_env",this);
    ch1_env=channel_env::type_id::create("ch1_env",this);
    ch2_env=channel_env::type_id::create("ch2_env",this);
    h_env=hbus_env::type_id::create("h_env",this);
    rv_seqr=router_virtual_sequencer::type_id::create("rv_seqr",this);
    rsc=router_scoreboard::type_id::create("rsc",this);
  endfunction

  function void router_tb::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info(get_name,"we are in connect_phase",UVM_LOW)    
    rv_seqr.seqr=env.ag.seqr;
    rv_seqr.h_seqr=h_env.masters[0].sequencer;
    env.ag.mn.mon2scr.connect(rsc.m2s);
    ch0_env.monitor.item_collected_port.connect(rsc.ch02s);
    ch1_env.monitor.item_collected_port.connect(rsc.ch12s);
    ch2_env.monitor.item_collected_port.connect(rsc.ch22s);
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



