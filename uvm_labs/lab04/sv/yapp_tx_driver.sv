
///////////////////////////////////////////////////////////////////////
//  File name     : yapp_tx_driver.sv                                //
//                                                                   //
//  Description   : Drives stimulus to the interface                 //
//                                                                   //
//  Notes         : This is the driver for transmitting yapp packets //
///////////////////////////////////////////////////////////////////////

`ifndef DRIVER
`define DRIVER

class driver extends uvm_driver #(yapp_packet);

  // Factory registration
  `uvm_component_utils(driver)

  // Task to display packet information
  extern task display(yapp_packet t1);
  
  // Constructor
  extern function new(string name = "driver", uvm_component parent = null);
  
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
    
// Task to display packet information
task driver::display(yapp_packet t1);
  t1.print();
endtask

// Constructor 
function driver::new(string name = "driver", uvm_component parent = null);
  super.new(name, parent);
endfunction

// build_phase
function void driver::build_phase(uvm_phase phase);
  `uvm_info(get_name, "Entered build_phase", UVM_LOW)  
endfunction

// connect phase
function void driver::connect_phase(uvm_phase phase);  
  `uvm_info(get_name, "Entered connect_phase", UVM_LOW)
  super.connect_phase(phase);    
endfunction

// end_of_elaboration_phase
function void driver::end_of_elaboration_phase(uvm_phase phase);                             
  `uvm_info(get_name, "Entered end_of_elaboration_phase", UVM_LOW)
endfunction

// start_of_simulation_phase
function void driver::start_of_simulation_phase(uvm_phase phase);                            
  `uvm_info(get_name, "Entered start_of_simulation_phase", UVM_LOW)
endfunction

// run_phase
task driver::run_phase(uvm_phase phase);
  `uvm_info(get_name, "Entered run_phase", UVM_LOW)                                              
  forever begin
    seq_item_port.get_next_item(req);
    display(req);
    seq_item_port.item_done();
  end
endtask

// extract_phase
function void driver::extract_phase(uvm_phase phase); 
  `uvm_info(get_name, "Entered extract_phase", UVM_LOW)                                       
endfunction

// check_phase
function void driver::check_phase(uvm_phase phase); 
  `uvm_info(get_name, "Entered check_phase", UVM_LOW)                                         
endfunction

// report_phase
function void driver::report_phase(uvm_phase phase); 
  `uvm_info(get_name, "Entered report_phase", UVM_LOW)                                        
endfunction

// final_phase
function void driver::final_phase(uvm_phase phase); 
  `uvm_info(get_name, "Entered final_phase", UVM_LOW)                                         
endfunction

`endif

