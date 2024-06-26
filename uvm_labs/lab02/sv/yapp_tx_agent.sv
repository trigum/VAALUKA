

///////////////////////////////////////////////////////////////////////
//  File name     : yapp_tx_agent.sv                                 //
//                                                                   //
//  Description   : This file contains the tx_agent which is active. //
//                                                                   //
//  version       : 02                                               //
///////////////////////////////////////////////////////////////////////

`ifndef YAPP_AGENT
`define YAPP_AGENT

// Class definition for the agent
class agent extends uvm_agent;

  // Factory registration
  `uvm_component_utils(agent)

  // Driver handle
  driver dr;

  // Monitor handle
  monitor mn;

  // Sequencer handle
  sequencer seqr;

  // Decide if the agent is active or passive
  uvm_active_passive_enum is_active = UVM_ACTIVE;

  // Extern constructor
  extern function new(string name = "agent", uvm_component parent = null);

  // Extern build phase function
  extern function void build_phase(uvm_phase phase);

  // Extern connect phase function
  extern function void connect_phase(uvm_phase phase);

  // Extern end of elaboration phase function
  extern function void end_of_elaboration_phase(uvm_phase phase);

  // Extern start of simulation phase function
  extern function void start_of_simulation_phase(uvm_phase phase);

  // Extern run phase task
  extern task run_phase(uvm_phase phase);

  // Extern extract phase function
  extern function void extract_phase(uvm_phase phase);

  // Extern check phase function
  extern function void check_phase(uvm_phase phase);

  // Extern report phase function
  extern function void report_phase(uvm_phase phase);

  // Extern final phase function
  extern function void final_phase(uvm_phase phase);

endclass

`endif

// Constructor for the agent
function agent::new(string name = "agent", uvm_component parent = null);
  super.new(name, parent);
endfunction

// Build phase
function void agent::build_phase(uvm_phase phase);
  super.build_phase(phase);
  `uvm_info(get_name, "We are in build_phase", UVM_LOW)
  if (is_active == UVM_ACTIVE) begin
    seqr = sequencer::type_id::create("seqr", this);
    dr   = driver::type_id::create("dr", this);
  end
  mn = monitor::type_id::create("mn", this);
endfunction

// Connect phase
function void agent::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  `uvm_info(get_name, "We are in connect_phase", UVM_LOW)
  if (is_active == UVM_ACTIVE) begin
    dr.seq_item_port.connect(seqr.seq_item_export);
  end
endfunction

// End of elaboration phase
function void agent::end_of_elaboration_phase(uvm_phase phase);
  `uvm_info(get_name, "We are in end_of_elaboration_phase", UVM_LOW)
endfunction

// Start of simulation phase
function void agent::start_of_simulation_phase(uvm_phase phase);
  `uvm_info(get_name, "We are in start_of_simulation_phase", UVM_LOW)
endfunction

// Run phase
task agent::run_phase(uvm_phase phase);
  `uvm_info(get_name, "We are in run_phase", UVM_LOW)
endtask

// Extract phase
function void agent::extract_phase(uvm_phase phase);
  `uvm_info(get_name, "We are in extract_phase", UVM_LOW)
endfunction

// Check phase
function void agent::check_phase(uvm_phase phase);
  `uvm_info(get_name, "We are in check_phase", UVM_LOW)
endfunction

// Report phase
function void agent::report_phase(uvm_phase phase);
  `uvm_info(get_name, "We are in report_phase", UVM_LOW)
endfunction

// Final phase
function void agent::final_phase(uvm_phase phase);
  `uvm_info(get_name, "We are in final_phase", UVM_LOW)
endfunction

