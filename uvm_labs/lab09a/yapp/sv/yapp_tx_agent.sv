

///////////////////////////////////////////////////////////////////////
//  File name     : yapp_tx_agent.sv                                 //
//                                                                   //
//  Description   : This file defines the tx_agent which can be      //
//                  active or passive                                //
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
  
  // Constructor
  extern function new(string name = "agent", uvm_component parent = null);
  
  // Phases
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
function agent::new(string name = "agent", uvm_component parent = null);
  super.new(name, parent);
endfunction

// Implementation of the build phase
function void agent::build_phase(uvm_phase phase);
  `uvm_info(get_name(), "we are in build_phase", UVM_LOW)      
  super.build_phase(phase);

  // Create sequencer and driver if agent is active
  if (get_is_active() == UVM_ACTIVE) begin
    seqr = sequencer::type_id::create("seqr", this);
    dr   = driver::type_id::create("dr", this);
  end

  // Create monitor
  mn = monitor::type_id::create("mn", this);
endfunction

// Implementation of the connect phase
function void agent::connect_phase(uvm_phase phase);
  `uvm_info(get_name(), "we are in connect_phase", UVM_LOW)    
  super.connect_phase(phase);

  // Connect driver to sequencer if agent is active
  if (get_is_active() == UVM_ACTIVE)
    dr.seq_item_port.connect(seqr.seq_item_export);
endfunction

// Implementation of the end of elaboration phase
function void agent::end_of_elaboration_phase(uvm_phase phase);                             
  `uvm_info(get_name(), "we are in end_of_elaboration_phase", UVM_LOW)
endfunction
  
// Implementation of the start of simulation phase
function void agent::start_of_simulation_phase(uvm_phase phase);                            
  `uvm_info(get_name(), "we are in start_of_simulation_phase", UVM_LOW)
endfunction

// Implementation of the run phase
task agent::run_phase(uvm_phase phase);
  `uvm_info(get_name(), "we are in run_phase", UVM_LOW)                                        
endtask
 
// Implementation of the extract phase
function void agent::extract_phase(uvm_phase phase); 
  `uvm_info(get_name(), "we are in extract_phase", UVM_LOW)                                       
endfunction

// Implementation of the check phase
function void agent::check_phase(uvm_phase phase); 
  `uvm_info(get_name(), "we are in check_phase", UVM_LOW)                                         
endfunction

// Implementation of the report phase
function void agent::report_phase(uvm_phase phase); 
  `uvm_info(get_name(), "we are in report_phase", UVM_LOW)                                        
endfunction

// Implementation of the final phase
function void agent::final_phase(uvm_phase phase); 
  `uvm_info(get_name(), "we are in final_phase", UVM_LOW)                                         
endfunction

`endif

