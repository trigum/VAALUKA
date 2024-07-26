


///////////////////////////////////////////////////////////////////////
//  File name     : yapp_tx_driver.sv                                //
//                                                                   //
//  Description   : This file drives stimulus to the interface        //
//                                                                   //
//  Version       : 2.0                                              //
///////////////////////////////////////////////////////////////////////

`ifndef DRIVER
`define DRIVER

class driver extends uvm_driver #(yapp_packet);

  // Factory registration
  `uvm_component_utils(driver)
  
  // Property to count packets sent
  int num_sent;
  
  // Virtual interface handle
  virtual yapp_if vif;

  // Tasks and functions
  extern task send_to_dut(yapp_packet packet);
  extern task reset_signals();
  extern task get_and_drive();
  extern function new(string name = "driver", uvm_component parent = null);
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

// Implementation of the send_to_dut task
task driver::send_to_dut(yapp_packet packet);
  `uvm_info(get_name(), $sformatf("Sending packet with delay %d", packet.packet_delay), UVM_LOW)
  
  // Wait for packet delay
  repeat(packet.packet_delay)
    @(negedge vif.clock);

  // Start sending packet if not in_suspend signal
  @(negedge vif.clock iff (!vif.in_suspend));

  // Begin transaction recording
  void'(this.begin_tr(packet, "Input_YAPP_Packet"));

  // Enable start packet signal
  vif.in_data_vld <= 1'b1;

  // Drive the Header {Length, Addr}
  vif.in_data <= { packet.length, packet.addr };

  // Drive Payload
  for (int i = 0; i < packet.payload.size(); i++) begin
    @(negedge vif.clock iff (!vif.in_suspend))
    vif.in_data <= packet.payload[i];
  end

  // Drive Parity and reset Valid
  @(negedge vif.clock iff (!vif.in_suspend))
  vif.in_data_vld <= 1'b0;
  vif.in_data  <= packet.parity;
  
  // Update counters
  num_sent++;
  
  // End transaction recording
  this.end_tr(packet);
  
endtask : send_to_dut
  
// Implementation of the reset_signals task
task driver::reset_signals();
  forever begin
    @(posedge vif.reset);
    `uvm_info(get_type_name(), "Reset observed", UVM_MEDIUM)
    vif.in_data           <= 'hz;
    vif.in_data_vld       <= 1'b0;
    disable send_to_dut;
  end
endtask : reset_signals

// Implementation of the get_and_drive task
task driver::get_and_drive();
  @(negedge vif.reset);
  `uvm_info(get_type_name(), "Reset dropped", UVM_MEDIUM)
  forever begin
    seq_item_port.get_next_item(req);
    send_to_dut(req);
    seq_item_port.item_done();
  end
endtask : get_and_drive

// Implementation of the constructor
function driver::new(string name = "driver", uvm_component parent = null);
  super.new(name, parent);
endfunction

// Implementation of the build_phase function
function void driver::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if (!yapp_vif_config::get(this, "", "vif", vif))
    `uvm_fatal("NOVIF", { "vif not set for ", get_full_name(), ".vif" })
endfunction

// Implementation of the connect_phase function
function void driver::connect_phase(uvm_phase phase);  
  super.connect_phase(phase);    
  `uvm_info(get_name(), "We are in connect_phase", UVM_LOW)
endfunction

// Implementation of the end_of_elaboration_phase function
function void driver::end_of_elaboration_phase(uvm_phase phase);                             
  `uvm_info(get_name(), "We are in end_of_elaboration_phase", UVM_LOW)
endfunction
  
// Implementation of the start_of_simulation_phase function
function void driver::start_of_simulation_phase(uvm_phase phase);                            
  `uvm_info(get_name(), "We are in start_of_simulation_phase", UVM_LOW)
endfunction

// Implementation of the run_phase task
task driver::run_phase(uvm_phase phase);
  `uvm_info(get_name(), "We are in run_phase", UVM_LOW)    
  fork
    get_and_drive();
    reset_signals();
  join
endtask : run_phase

// Implementation of the extract_phase function
function void driver::extract_phase(uvm_phase phase); 
  `uvm_info(get_name(), "We are in extract_phase", UVM_LOW)                                       
endfunction

// Implementation of the check_phase function
function void driver::check_phase(uvm_phase phase); 
  `uvm_info(get_name(), "We are in check_phase", UVM_LOW)                                         
endfunction

// Implementation of the report_phase function
function void driver::report_phase(uvm_phase phase);
  `uvm_info(get_type_name(), $sformatf("Report: YAPP TX driver sent %0d packets", num_sent), UVM_LOW)
endfunction : report_phase

// Implementation of the final_phase function
function void driver::final_phase(uvm_phase phase); 
  `uvm_info(get_name(), "We are in final_phase", UVM_LOW)                                         
endfunction

`endif

