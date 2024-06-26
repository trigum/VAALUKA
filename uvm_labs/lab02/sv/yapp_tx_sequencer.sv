///////////////////////////////////////////////////////////////////////
//  File name     : yapp_tx_sequencer.sv                             //
//                                                                   //
//  Description   : This file defines the sequencer component        //
//                  responsible for coordinating packet generation   //
//                  and transmission in the yapp_tx system.          //
//                                                                   //
//  version       : 02                                               // 
///////////////////////////////////////////////////////////////////////

`ifndef SEQUENCER
`define SEQUENCER

// Class definition for sequencer
class sequencer extends uvm_sequencer #(yapp_packet);
  
  // Factory registration for sequencer
  `uvm_component_utils(sequencer)

  // Extern constructor
  extern function new(string name = "sequencer", uvm_component parent = null);
    
  // Extern build phase method
  extern function void build_phase(uvm_phase phase);                                  
 
  // Extern connect phase method
  extern function void connect_phase(uvm_phase phase);                                 

  // Extern end of elaboration phase method
  extern function void end_of_elaboration_phase(uvm_phase phase);                      
  
  // Extern start of simulation phase method
  extern function void start_of_simulation_phase(uvm_phase phase);     
  
  // Extern run phase task
  extern task run_phase(uvm_phase phase);                                                  
  
  // Extern extract phase method
  extern function void extract_phase(uvm_phase phase);                                 
  
  // Extern check phase method
  extern function void check_phase(uvm_phase phase);                                   
  
  // Extern report phase method
  extern function void report_phase(uvm_phase phase);                                 
  
  // Extern final phase method
  extern function void final_phase(uvm_phase phase);

endclass

`endif

// Constructor for sequencer
function sequencer::new(string name = "sequencer", uvm_component parent = null);
  super.new(name, parent);     
endfunction

// build_phase method
function void sequencer::build_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in build_phase", UVM_LOW)  
endfunction
  
// connect phase method
function void sequencer::connect_phase(uvm_phase phase);  
  super.connect_phase(phase);    
  `uvm_info(get_name, "we are in connect_phase", UVM_LOW)
endfunction

// end_of_elaboration phase method
function void sequencer::end_of_elaboration_phase(uvm_phase phase);                             
  `uvm_info(get_name, "we are in EOE", UVM_LOW)
endfunction
  
// start_of_simulation phase method
function void sequencer::start_of_simulation_phase(uvm_phase phase);                            
  `uvm_info(get_name, "we are in SOS", UVM_LOW)
endfunction

// run phase task
task sequencer::run_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in run_phase", UVM_LOW)                                             
endtask
 
// extract phase method
function void sequencer::extract_phase(uvm_phase phase); 
  `uvm_info(get_name, "we are in extract_phase", UVM_LOW)                                       
endfunction

// check phase method
function void sequencer::check_phase(uvm_phase phase); 
  `uvm_info(get_name, "we are in check_phase", UVM_LOW)                                         
endfunction

// report phase method
function void sequencer::report_phase(uvm_phase phase); 
  `uvm_info(get_name, "we are in report_phase", UVM_LOW)                                        
endfunction

// final phase method
function void sequencer::final_phase(uvm_phase phase); 
  `uvm_info(get_name, "we are in final_phase", UVM_LOW)                                         
endfunction

