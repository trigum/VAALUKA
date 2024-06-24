




// sequencer class for yapp router

`ifndef SEQUENCER
`define SEQUENCER

class sequencer extends uvm_sequencer #(yapp_packet);
  
  `uvm_component_utils(sequencer);                                                                // factory registration

  extern function new(string name="sequencer",uvm_component parent=null);
    
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

`endif

  //constructor

  function sequencer::new(string name="sequencer",uvm_component parent=null);
    super.new(name,parent);     
  endfunction

  // build_phase

  function void sequencer::build_phase(uvm_phase phase);
    `uvm_info(get_name,"we are in build_phase",UVM_LOW)  
  endfunction
  
  // connect phase
  
  function void sequencer::connect_phase(uvm_phase phase);  
    super.connect_phase(phase);    
    `uvm_info(get_name,"we are in connect_phase",UVM_LOW)
  endfunction

  // end of elobaration phase

  function void sequencer::end_of_elaboration_phase(uvm_phase phase);                             
    `uvm_info(get_name,"we are in EOE",UVM_LOW)
  endfunction
  
  // start of simulation phase

  function void sequencer::start_of_simulation_phase(uvm_phase phase);                            
    `uvm_info(get_name,"we are in SOS",UVM_LOW)
  endfunction

  // run phase

  task sequencer::run_phase(uvm_phase phase);
    `uvm_info(get_name,"we are in run_phase",UVM_LOW)                                              // run phase which print topology
  endtask
 
  // extract phase

  function void sequencer::extract_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in extract_phase",UVM_LOW)                                       
  endfunction

  // check phase

  function void sequencer::check_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in check_phase",UVM_LOW)                                         
  endfunction

  // report phase

  function void sequencer::report_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in report_phase",UVM_LOW)                                        
  endfunction

  // final phase

  function void sequencer::final_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in final_phase",UVM_LOW)                                         
  endfunction

  
