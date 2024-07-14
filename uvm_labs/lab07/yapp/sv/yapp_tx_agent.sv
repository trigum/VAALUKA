///////////////////////////////////////////////////////////////////////
//  File name     : yapp_tx_agent.sv                                 //
//                                                                   //
//  Description   : This file contains the TX agent, which is active.//
//                                                                   //
//  Version       : 2.0                                              //
///////////////////////////////////////////////////////////////////////

`ifndef AGENT
`define AGENT

class agent extends uvm_agent;

  // Factory registration
  `uvm_component_utils(agent)

  // Driver handle
  driver dr;

  // Monitor handle
  monitor mn;

  // Sequencer handle
  sequencer seqr;

  // Decide if agent is active or passive
  uvm_active_passive_enum is_active = UVM_ACTIVE;
  
  // Constructor function
  extern function new(string name = "agent", uvm_component parent = null);

  // Build phase function
  extern function void build_phase(uvm_phase phase);                                  
  
  // Connect phase function
  extern function void connect_phase(uvm_phase phase);                                 

  // End of elaboration phase function
  extern function void end_of_elaboration_phase(uvm_phase phase);                      
  
  // Start of simulation phase function
  extern function void start_of_simulation_phase(uvm_phase phase);     
  
  // Run phase task
  extern task run_phase(uvm_phase phase);                                                  
  
  // Extract phase function
  extern function void extract_phase(uvm_phase phase);                                 
  
  // Check phase function
  extern function void check_phase(uvm_phase phase);                                   
  
  // Report phase function
  extern function void report_phase(uvm_phase phase);                                 
  
  // Final phase function
  extern function void final_phase(uvm_phase phase);

endclass

  // Constructor implementation
  function agent::new(string name = "agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction
 
  // Build phase implementation
  function void agent::build_phase(uvm_phase phase);
    `uvm_info(get_name(), "We are in build_phase", UVM_LOW)      
    super.build_phase(phase);
    if (get_is_active() == UVM_ACTIVE)
    begin
      seqr = sequencer::type_id::create("seqr", this);
      dr   = driver::type_id::create("dr", this);
    end
    mn = monitor::type_id::create("mn", this);
  endfunction

  // Connect phase implementation
  function void agent::connect_phase(uvm_phase phase);
    `uvm_info(get_name(), "We are in connect_phase", UVM_LOW)    
    super.connect_phase(phase);
    if (get_is_active() == UVM_ACTIVE)
      dr.seq_item_port.connect(seqr.seq_item_export);
  endfunction

  // End of elaboration phase implementation
  function void agent::end_of_elaboration_phase(uvm_phase phase);                             
    `uvm_info(get_name(), "We are in end_of_elaboration_phase", UVM_LOW)
  endfunction
  
  // Start of simulation phase implementation
  function void agent::start_of_simulation_phase(uvm_phase phase);                            
    `uvm_info(get_name(), "We are in start_of_simulation_phase", UVM_LOW)
  endfunction

  // Run phase implementation
  task agent::run_phase(uvm_phase phase);
    `uvm_info(get_name(), "We are in run_phase", UVM_LOW)                                         
  endtask
 
  // Extract phase implementation
  function void agent::extract_phase(uvm_phase phase); 
    `uvm_info(get_name(), "We are in extract_phase", UVM_LOW)                                       
  endfunction

  // Check phase implementation
  function void agent::check_phase(uvm_phase phase); 
    `uvm_info(get_name(), "We are in check_phase", UVM_LOW)                                         
  endfunction

  // Report phase implementation
  function void agent::report_phase(uvm_phase phase); 
    `uvm_info(get_name(), "We are in report_phase", UVM_LOW)                                        
  endfunction

  // Final phase implementation
  function void agent::final_phase(uvm_phase phase); 
    `uvm_info(get_name(), "We are in final_phase", UVM_LOW)                                         
  endfunction

`endif

