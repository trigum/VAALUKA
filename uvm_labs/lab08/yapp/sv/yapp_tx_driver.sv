

///////////////////////////////////////////////////////////////////////
//  File name     : yapp_tx_driver.sv                                //
//                                                                   //
//  Description   : this file drive stimulus to interface            //
//                                                                   //
//  version       : 2.0                                              //
///////////////////////////////////////////////////////////////////////


`ifndef DRIVER
`define DRIVER

/////////////////////////////
//                         //
//         DRIVER          //
//                         //
/////////////////////////////

// Define a UVM driver class for yapp_packet
class driver extends uvm_driver #(yapp_packet);

  // Register the class with the UVM factory
  `uvm_component_utils(driver);

  // Declare a property to count the number of packets sent
  int num_sent;

  // Virtual interface to connect with the DUT
  virtual yapp_if vif;

  // Task to send a packet to the DUT
  extern task send_to_dut(yapp_packet packet);
  
  // Task to reset all TX signals
  extern task reset_signals();
  
  // Task to get packets from the sequencer and drive them to the DUT
  extern task get_and_drive();

  // Constructor declaration
  extern function new(string name = "driver",uvm_component parent = null);
  
  // Phase functions declarations
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

  // Task to send a packet to the DUT
  task driver::send_to_dut(yapp_packet packet);
    $display("delay================================%d",packet.packet_delay);

    // Wait for the specified packet delay
    repeat(packet.packet_delay)
      @(negedge vif.clock);

    // Ensure signals are not in suspend state before starting
    @(negedge vif.clock iff (!vif.in_suspend));

    // Begin transaction recording
    void'(this.begin_tr(packet, "Input_YAPP_Packet"));

    // Enable the valid data signal
    vif.in_data_vld <= 1'b1;

    // Drive the Header {Length, Addr}
    vif.in_data <= { packet.length, packet.addr };

    // Drive Payload data
    for (int i = 0; i < packet.payload.size(); i++) begin
      @(negedge vif.clock iff (!vif.in_suspend))
      vif.in_data <= packet.payload[i];
    end

    // Drive Parity and reset Valid signal
    @(negedge vif.clock iff (!vif.in_suspend))
    vif.in_data_vld <= 1'b0;
    vif.in_data  <= packet.parity;

    // Set in_data to high impedance after the packet
    @(negedge vif.clock)
      vif.in_data  <= 8'bz;
      
    // Increment the packet count
    num_sent++;

    // End transaction recording
    this.end_tr(packet);

  endtask : send_to_dut
  
  // Task to reset all TX signals
  task driver::reset_signals();
    forever begin
      @(posedge vif.reset);
      `uvm_info(get_type_name(), "Reset observed", UVM_MEDIUM)
      vif.in_data           <=  'hz;
      vif.in_data_vld       <= 1'b0;
      disable send_to_dut;
    end
  endtask : reset_signals

  // Task to get packets from the sequencer and pass them to the driver
  task driver::get_and_drive();
    @(negedge vif.reset);
    `uvm_info(get_type_name(), "Reset dropped", UVM_MEDIUM)
    forever begin
       seq_item_port.get_next_item(req);
       send_to_dut(req);
       seq_item_port.item_done();
    end
  endtask : get_and_drive

  // Constructor implementation
  function driver::new(string name = "driver",uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  // Build phase implementation
  function void driver::build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Retrieve the virtual interface configuration
    if(!yapp_vif_config::get(this,"","vif",vif))
      `uvm_fatal("NOVIF",{"vif not set for",get_full_name(),".vif"})
  endfunction

  // Connect phase implementation
  function void driver::connect_phase(uvm_phase phase);  
    super.connect_phase(phase);    
    `uvm_info(get_name,"we are in connect_phase",UVM_LOW)
  endfunction

  // End of elaboration phase implementation
  function void driver::end_of_elaboration_phase(uvm_phase phase);                             
    `uvm_info(get_name,"we are in EOE",UVM_LOW)
  endfunction
  
  // Start of simulation phase implementation
  function void driver::start_of_simulation_phase(uvm_phase phase);                            
    `uvm_info(get_name,"we are in SOS",UVM_LOW)
  endfunction

  // Run phase implementation
  task driver::run_phase(uvm_phase phase);
    `uvm_info(get_name,"we are in run_phase",UVM_LOW)    
    fork
      get_and_drive();
      reset_signals();
    join
  endtask : run_phase

  // Extract phase implementation
  function void driver::extract_phase(uvm_phase phase); 
    `uvm_info(get_name,"we are in extract_phase",UVM_LOW)                                       
  endfunction

  // Check phase implementation
  function void driver::check_phase(uvm_phase phase); 
    `uvm_info(get_name,"we are in check_phase",UVM_LOW)                                         
  endfunction

  // Report phase implementation
  function void driver::report_phase(uvm_phase phase);
    `uvm_info(get_type_name(), $sformatf("Report: YAPP TX driver sent %0d packets", num_sent), UVM_LOW)
  endfunction : report_phase

  // Final phase implementation
  function void driver::final_phase(uvm_phase phase); 
    `uvm_info(get_name,"we are in final_phase",UVM_LOW)                                         
  endfunction

`endif

