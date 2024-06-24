




`ifndef VIRTUAL_SEQUENCER
`define VIRTUAL_SEQUENCER

class router_virtual_sequencer extends uvm_sequencer;
  `uvm_component_utils(router_virtual_sequencer)

  hbus_master_sequencer h_seqr;

  sequencer seqr;

  extern function new(string name="router_virtual_sequencer",uvm_component parent=null);
  
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

  function router_virtual_sequencer::new(string name="router_virtual_sequencer",uvm_component parent=null);
    super.new(name,parent);
  endfunction

  // build_phase

  function void router_virtual_sequencer::build_phase(uvm_phase phase);
    `uvm_info(get_name,"we are in build_phase",UVM_LOW)  
  endfunction
  
  // connect phase
  
  function void router_virtual_sequencer::connect_phase(uvm_phase phase);  
    `uvm_info(get_name,"we are in connect_phase",UVM_LOW)    
    super.connect_phase(phase);    
  endfunction

  // end of elobaration phase

  function void router_virtual_sequencer::end_of_elaboration_phase(uvm_phase phase);                             
    `uvm_info(get_name,"we are in EOE",UVM_LOW)
  endfunction
  
  // start of simulation phase

  function void router_virtual_sequencer::start_of_simulation_phase(uvm_phase phase);                            
    `uvm_info(get_name,"we are in SOS",UVM_LOW)
  endfunction

  // run phase

  task router_virtual_sequencer::run_phase(uvm_phase phase);
    `uvm_info(get_name,"we are in run_phase",UVM_LOW)                                              // run phase which print topology
  endtask
 
  // extract phase

  function void router_virtual_sequencer::extract_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in extract_phase",UVM_LOW)                                       
  endfunction

  // check phase

  function void router_virtual_sequencer::check_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in check_phase",UVM_LOW)                                         
  endfunction

  // report phase

  function void router_virtual_sequencer::report_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in report_phase",UVM_LOW)                                        
  endfunction

  // final phase

  function void router_virtual_sequencer::final_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in final_phase",UVM_LOW)                                         
  endfunction

`endif 
  
    
    
    
