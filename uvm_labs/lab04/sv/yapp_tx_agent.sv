
///////////////////////////////////////////////////////////////////////
//  File name     : yapp_tx_agent.sv                                 //
//                                                                   //
//  Description   : Defines an agent for transmitting packets with   //
//                  active behavior.                                 //
//                                                                   //
//  Notes         : Contains driver, monitor, and sequencer handles. //
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

  // Active/passive configuration  
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


// Constructor for agent
function agent::new(string name = "agent", uvm_component parent = null);
  super.new(name, parent);
endfunction


// build_phase: Sets up components based on active or passive configuration
function void agent::build_phase(uvm_phase phase);
  `uvm_info(get_name, "Entered build_phase", UVM_LOW)      
  
  // Call super class build phase
  super.build_phase(phase);
  
  // Create sequencer and driver if active
  if (get_is_active() == UVM_ACTIVE) begin
    seqr = sequencer::type_id::create("seqr", this);
    dr = driver::type_id::create("dr", this);
  end
  
  // Always create monitor
  mn = monitor::type_id::create("mn", this);
endfunction


// connect_phase: Connects driver to sequencer if active
function void agent::connect_phase(uvm_phase phase);
  `uvm_info(get_name, "Entered connect_phase", UVM_LOW)    
  
  // Call super class connect phase
  super.connect_phase(phase);
  
  // Connect driver to sequencer if active
  if (get_is_active() == UVM_ACTIVE)
    dr.seq_item_port.connect(seqr.seq_item_export);
endfunction


// end_of_elaboration_phase: Performs actions at end of elaboration
function void agent::end_of_elaboration_phase(uvm_phase phase);                             
  `uvm_info(get_name, "Entered end_of_elaboration_phase", UVM_LOW)
  
endfunction


// start_of_simulation_phase: Initializes at start of simulation
function void agent::start_of_simulation_phase(uvm_phase phase);                            
  `uvm_info(get_name, "Entered start_of_simulation_phase", UVM_LOW)
  
endfunction


// run_phase: Executes main agent functionality
task agent::run_phase(uvm_phase phase);
  `uvm_info(get_name, "Entered run_phase", UVM_LOW)                                           
  
endtask


// extract_phase: Handles data extraction tasks
function void agent::extract_phase(uvm_phase phase); 
  `uvm_info(get_name, "Entered extract_phase", UVM_LOW)                                       
  
endfunction


// check_phase: Performs result verification
function void agent::check_phase(uvm_phase phase); 
  `uvm_info(get_name, "Entered check_phase", UVM_LOW)                                         
  
endfunction


// report_phase: Generates test report or summary
function void agent::report_phase(uvm_phase phase); 
  `uvm_info(get_name, "Entered report_phase", UVM_LOW)                                        
  
endfunction


// final_phase: Cleans up and performs final actions
function void agent::final_phase(uvm_phase phase); 
  `uvm_info(get_name, "Entered final_phase", UVM_LOW)                                         
  
  endfunction

`endif

