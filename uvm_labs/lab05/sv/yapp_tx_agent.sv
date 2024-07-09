
///////////////////////////////////////////////////////////////////////
//  File name     : yapp_tx_agent.sv                                 //
//                                                                   //
//  Description   : this file has the tx_agent which is active       //
//                                                                   //
//  Notes         : this file includes driver, monitor, sequencer    //
///////////////////////////////////////////////////////////////////////

`ifndef AGENT
`define AGENT

// Class declaration extending uvm_agent
class agent extends uvm_agent;

  // Factory registration macro
  `uvm_component_utils(agent)

  // Driver handle
  driver dr;

  // Monitor handle
  monitor mn;

  // Sequencer handle
  sequencer seqr;

  // Variable to decide if agent is active or passive
  uvm_active_passive_enum is_active = UVM_ACTIVE;
  
  // Constructor declaration
  extern function new(string name = "agent", uvm_component parent = null);
  
  // Phase declarations
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

// Constructor definition
function agent::new(string name = "agent", uvm_component parent = null);
  // Call the base class constructor
  super.new(name, parent);
endfunction
 
// Build phase definition
function void agent::build_phase(uvm_phase phase);
  // Print a message indicating the build phase has started
  `uvm_info(get_name, "we are in build_phase", UVM_LOW)      
  // Call the base class build_phase method
  super.build_phase(phase);
  // If the agent is active, create the sequencer and driver
  if (get_is_active() == UVM_ACTIVE)
  begin
    seqr = sequencer::type_id::create("seqr", this);
    dr   = driver::type_id::create("dr", this);
  end
  // Always create the monitor
  mn = monitor::type_id::create("mn", this);
endfunction

// Connect phase definition
function void agent::connect_phase(uvm_phase phase);
  // Print a message indicating the connect phase has started
  `uvm_info(get_name, "we are in connect_phase", UVM_LOW)    
  // Call the base class connect_phase method
  super.connect_phase(phase);
  // If the agent is active, connect the driver and sequencer
  if (get_is_active() == UVM_ACTIVE)
    dr.seq_item_port.connect(seqr.seq_item_export);
endfunction

// End of elaboration phase definition
function void agent::end_of_elaboration_phase(uvm_phase phase);
  // Print a message indicating the end of elaboration phase has started                             
  `uvm_info(get_name, "we are in EOE", UVM_LOW)
endfunction
  
// Start of simulation phase definition
function void agent::start_of_simulation_phase(uvm_phase phase);
  // Print a message indicating the start of simulation phase has started                            
  `uvm_info(get_name, "we are in SOS", UVM_LOW)
endfunction

// Run phase definition
task agent::run_phase(uvm_phase phase);
  // Print a message indicating the run phase has started
  `uvm_info(get_name, "we are in run_phase", UVM_LOW)                                          
endtask
 
// Extract phase definition
function void agent::extract_phase(uvm_phase phase);
  // Print a message indicating the extract phase has started 
  `uvm_info(get_name, "we are in extract_phase", UVM_LOW)                                       
endfunction

// Check phase definition
function void agent::check_phase(uvm_phase phase);
  // Print a message indicating the check phase has started 
  `uvm_info(get_name, "we are in check_phase", UVM_LOW)                                         
endfunction

// Report phase definition
function void agent::report_phase(uvm_phase phase);
  // Print a message indicating the report phase has started 
  `uvm_info(get_name, "we are in report_phase", UVM_LOW)                                        
endfunction

// Final phase definition
function void agent::final_phase(uvm_phase phase);
  // Print a message indicating the final phase has started 
  `uvm_info(get_name, "we are in final_phase", UVM_LOW)                                         
endfunction

`endif

