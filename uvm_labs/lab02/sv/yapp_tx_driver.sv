 
///////////////////////////////////////////////////////////////////////
//  File name     : yapp_tx_driver.sv                                //
//                                                                   //
//  Description   : This file drives stimulus to the interface.      //
//                                                                   //
//  Notes         : It is the tx_yapp driver.                        //
///////////////////////////////////////////////////////////////////////

`ifndef DRIVER
`define DRIVER

// Class definition for the driver
class driver extends uvm_driver #(yapp_packet);

  // Factory registration
  `uvm_component_utils(driver)

  // Extern constructor
  extern function new(string name = "driver", uvm_component parent = null);

  // Extern display task
  extern task display(yapp_packet t1);

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

// Constructor for the driver
function driver::new(string name = "driver", uvm_component parent = null);
  super.new(name, parent);
endfunction

// Display method to print packet information
task driver::display(yapp_packet t1);
  t1.print();
endtask

// Build phase
function void driver::build_phase(uvm_phase phase);
  `uvm_info(get_name, "We are in build_phase", UVM_LOW);
endfunction

// Connect phase
function void driver::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  `uvm_info(get_name, "We are in connect_phase", UVM_LOW);
endfunction

// End of elaboration phase
function void driver::end_of_elaboration_phase(uvm_phase phase);
  `uvm_info(get_name, "We are in end_of_elaboration_phase", UVM_LOW);
endfunction

// Start of simulation phase
function void driver::start_of_simulation_phase(uvm_phase phase);
  `uvm_info(get_name, "We are in start_of_simulation_phase", UVM_LOW);
endfunction

// Run phase
task driver::run_phase(uvm_phase phase);
  `uvm_info(get_name, "We are in run_phase", UVM_LOW);
  forever begin
    seq_item_port.get_next_item(req);
    display(req);
    seq_item_port.item_done();
  end
endtask

// Extract phase
function void driver::extract_phase(uvm_phase phase);
  `uvm_info(get_name, "We are in extract_phase", UVM_LOW);
endfunction

// Check phase
function void driver::check_phase(uvm_phase phase);
  `uvm_info(get_name, "We are in check_phase", UVM_LOW);
endfunction

// Report phase
function void driver::report_phase(uvm_phase phase);
  `uvm_info(get_name, "We are in report_phase", UVM_LOW);
endfunction

// Final phase
function void driver::final_phase(uvm_phase phase);
  `uvm_info(get_name, "We are in final_phase", UVM_LOW);
endfunction

