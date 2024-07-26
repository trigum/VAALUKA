

///////////////////////////////////////////////////////////////////////////////////
//                                                                               //
// File name     : yapp_tx_sequencer.sv                                          //
//                                                                               //
// Description   : this is a yapp_sequencer                                      //
//                                                                               //
// version       : 2.0                                                           //
//                                                                               //
///////////////////////////////////////////////////////////////////////////////////


`ifndef SEQUENCER
`define SEQUENCER

// Sequencer class for yapp_router
class sequencer extends uvm_sequencer #(yapp_packet);
  `uvm_component_utils(sequencer)  // Factory registration

  // Constructor
  extern function new(string name="sequencer", uvm_component parent=null);

  // Phase methods
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

// Constructor implementation
function sequencer::new(string name="sequencer", uvm_component parent=null);
  super.new(name, parent);
endfunction

// Build phase implementation
function void sequencer::build_phase(uvm_phase phase);
  `uvm_info(get_name(), "We are in build_phase", UVM_LOW)
  super.build_phase(phase);
endfunction

// Connect phase implementation
function void sequencer::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  `uvm_info(get_name(), "We are in connect_phase", UVM_LOW)
endfunction

// End of Elaboration phase implementation
function void sequencer::end_of_elaboration_phase(uvm_phase phase);
  `uvm_info(get_name(), "We are in end_of_elaboration_phase", UVM_LOW)
endfunction

// Start of Simulation phase implementation
function void sequencer::start_of_simulation_phase(uvm_phase phase);
  `uvm_info(get_name(), "We are in start_of_simulation_phase", UVM_LOW)
endfunction

// Run phase implementation
task sequencer::run_phase(uvm_phase phase);
  `uvm_info(get_name(), "We are in run_phase", UVM_LOW)
endtask

// Extract phase implementation
function void sequencer::extract_phase(uvm_phase phase);
  `uvm_info(get_name(), "We are in extract_phase", UVM_LOW)
endfunction

// Check phase implementation
function void sequencer::check_phase(uvm_phase phase);
  `uvm_info(get_name(), "We are in check_phase", UVM_LOW)
endfunction

// Report phase implementation
function void sequencer::report_phase(uvm_phase phase);
  `uvm_info(get_name(), "We are in report_phase", UVM_LOW)
endfunction

// Final phase implementation
function void sequencer::final_phase(uvm_phase phase);
  `uvm_info(get_name(), "We are in final_phase", UVM_LOW)
endfunction

`endif

  
