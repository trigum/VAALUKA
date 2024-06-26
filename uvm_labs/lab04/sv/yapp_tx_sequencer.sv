
////////////////////////////////////////////////////////////////////////////////////
// File name   : yapp_tx_sequencer.sv                                             //
//                                                                                //
// Description : Defines the sequencer component for managing sequences.          //
//                                                                                //
// version     : 02                                                               //
////////////////////////////////////////////////////////////////////////////////////

`ifndef SEQUENCER
`define SEQUENCER

class sequencer extends uvm_sequencer #(yapp_packet);
  
  // Factory registration for sequencer class
  `uvm_component_utils(sequencer);

  // Constructor declaration
  extern function new(string name="sequencer", uvm_component parent=null);
    
  // Phase method declarations
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern function void end_of_elaboration_phase(uvm_phase phase);
  extern function void start_of_simulation_phase(uvm_phase phase);
  
  // Task declaration
  extern task run_phase(uvm_phase phase);
  
  // Phase method declarations
  extern function void extract_phase(uvm_phase phase);
  extern function void check_phase(uvm_phase phase);
  extern function void report_phase(uvm_phase phase);
  extern function void final_phase(uvm_phase phase);

endclass

`endif

// Constructor definition
function sequencer::new(string name="sequencer", uvm_component parent=null);
  super.new(name, parent);
endfunction

// build_phase definition
function void sequencer::build_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in build_phase", UVM_LOW)
endfunction

// connect phase definition
function void sequencer::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  `uvm_info(get_name, "we are in connect_phase", UVM_LOW)
endfunction

// end_of_elaboration_phase definition
function void sequencer::end_of_elaboration_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in EOE", UVM_LOW)
endfunction

// start_of_simulation_phase definition
function void sequencer::start_of_simulation_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in SOS", UVM_LOW)
endfunction

// run_phase definition
task sequencer::run_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in run_phase", UVM_LOW)
endtask

// extract_phase definition
function void sequencer::extract_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in extract_phase", UVM_LOW)
endfunction

// check_phase definition
function void sequencer::check_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in check_phase", UVM_LOW)
endfunction

// report_phase definition
function void sequencer::report_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in report_phase", UVM_LOW)
endfunction

// final_phase definition
function void sequencer::final_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in final_phase", UVM_LOW)
endfunction

