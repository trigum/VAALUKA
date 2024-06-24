
///////////////////////////////////////////////////////////////////////
//  File name     : yapp_tx_agent.sv                                 //
//                                                                   //
//  Description   : this file have tx_agent which is active          //
//                                                                   //
//  Notes         : this file have driver monitor sequencer          //
///////////////////////////////////////////////////////////////////////
//
`ifndef AGENT
`define AGENT

class agent extends uvm_agent;

// factory registration
  `uvm_component_utils(agent)

// driver handle  
  driver dr;

// monitor handle  
  monitor mn;

// sequencer handle  
  sequencer seqr;

// decide agent is active or passive  
  uvm_active_passive_enum is_active = UVM_ACTIVE ;
  
  
  extern function new(string name = "agent",uvm_component parent = null);
  
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

  // constructor 

  function agent::new(string name = "agent",uvm_component parent = null);
    super.new(name,parent);
  endfunction
 
  // build_phase 

  function void agent::build_phase(uvm_phase phase);
    `uvm_info(get_name,"we are in build_phase",UVM_LOW)      
    super.build_phase(phase);
    if(get_is_active() == UVM_ACTIVE)
    begin
      seqr = sequencer::type_id::create("seqr",this);
      dr   = driver::type_id::create("dr",this);
    end
    mn = monitor::type_id::create("mn",this);
  endfunction

  // connect phase

  function void agent::connect_phase(uvm_phase phase);
    `uvm_info(get_name,"we are in connect_phase",UVM_LOW)    
    super.connect_phase(phase);
    if(get_is_active() == UVM_ACTIVE)
      dr.seq_item_port.connect(seqr.seq_item_export);
  endfunction

  // end of elobaration phase

  function void agent::end_of_elaboration_phase(uvm_phase phase);                             
    `uvm_info(get_name,"we are in EOE",UVM_LOW)
  endfunction
  
  // start of simulation phase

  function void agent::start_of_simulation_phase(uvm_phase phase);                            
    `uvm_info(get_name,"we are in SOS",UVM_LOW)
  endfunction

  // run phase

  task agent::run_phase(uvm_phase phase);
    `uvm_info(get_name,"we are in run_phase",UVM_LOW)                                          
  endtask
 
  // extract phase

  function void agent::extract_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in extract_phase",UVM_LOW)                                       
  endfunction

  // check phase

  function void agent::check_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in check_phase",UVM_LOW)                                         
  endfunction

  // report phase

  function void agent::report_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in report_phase",UVM_LOW)                                        
  endfunction

  // final phase

  function void agent::final_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in final_phase",UVM_LOW)                                         
  endfunction

`endif
