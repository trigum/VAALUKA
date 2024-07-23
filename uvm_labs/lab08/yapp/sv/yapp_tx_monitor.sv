
///////////////////////////////////////////////////////////////////////
//  File name     : monitor.sv                                      //
//                                                                   //
//  Description   : This file defines the UVM monitor class that     //
//                  observes transactions and collects data from the //
//                  DUT.                                             //
//                                                                   //
//  version       : 1.0                                              //
///////////////////////////////////////////////////////////////////////

`ifndef MONITOR
`define MONITOR

/////////////////////////////
//                         //
//    MONITOR              //
//                         //
/////////////////////////////

class monitor extends uvm_monitor;
  
  // Register the class with the UVM factory
  `uvm_component_utils(monitor)
  
  // Handle for the collected data
  yapp_packet packet_collected;

  // Virtual interface for communication with DUT
  virtual yapp_if vif;

  // Count of collected packets
  int num_pkt_col;
  
  // Method to collect a packet
  extern task collect_packet();
  
  // Constructor declaration
  extern function new(string name="monitor",uvm_component parent=null);

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

  // Task to collect packets from the DUT
  task monitor::collect_packet();
    // Monitor looks at the bus on posedge (Driver uses negedge)
    @(posedge vif.in_data_vld);

    @(posedge vif.clock iff (!vif.in_suspend))

    // Begin transaction recording
    void'(this.begin_tr(packet_collected, "Monitor_YAPP_Packet"));

    `uvm_info(get_type_name(), "Collecting a packet", UVM_HIGH)
    // Collect Header {Length, Addr}
    { packet_collected.length, packet_collected.addr }  = vif.in_data;
    packet_collected.payload = new[packet_collected.length]; // Allocate the payload
    // Collect the Payload
    for (int i = 0; i < packet_collected.length; i++) begin
      @(posedge vif.clock iff (!vif.in_suspend))
      packet_collected.payload[i] = vif.in_data;
    end

    // Collect Parity and Compute Parity Type
    @(posedge vif.clock iff !vif.in_suspend)
      packet_collected.parity = vif.in_data;
    packet_collected.parity_type = (packet_collected.parity == packet_collected.calc_parity()) ? GOOD_PARITY : BAD_PARITY;
    
    // End transaction recording
    this.end_tr(packet_collected);
    `uvm_info(get_type_name(), $sformatf("Packet Collected :\n%s", packet_collected.sprint()), UVM_LOW)
    num_pkt_col++;
  endtask : collect_packet

  // Constructor implementation
  function monitor::new(string name="monitor",uvm_component parent=null);
    super.new(name, parent);
  endfunction

  // Build phase implementation
  function void monitor::build_phase(uvm_phase phase);
    `uvm_info(get_name,"we are in build_phase",UVM_LOW)      
    super.build_phase(phase);
    if (!yapp_vif_config::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", {"vif not set for", get_full_name(), ".vif"})
  endfunction

  // Connect phase implementation
  function void monitor::connect_phase(uvm_phase phase);  
    super.connect_phase(phase);    
    `uvm_info(get_name,"we are in connect_phase",UVM_LOW)
  endfunction

  // End of elaboration phase implementation
  function void monitor::end_of_elaboration_phase(uvm_phase phase);                             
    `uvm_info(get_name,"we are in EOE",UVM_LOW)
  endfunction
  
  // Start of simulation phase implementation
  function void monitor::start_of_simulation_phase(uvm_phase phase);                            
    `uvm_info(get_name,"we are in SOS",UVM_LOW)
  endfunction

  // Run phase implementation
  task monitor::run_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "Inside the run_phase", UVM_MEDIUM)

    // Create an instance for the collected packet
    packet_collected = yapp_packet::type_id::create("packet_collected", this);

    // Look for packets after reset
    @(negedge vif.reset)
    `uvm_info(get_type_name(), "Detected Reset Done", UVM_MEDIUM)
    forever 
      collect_packet();
  endtask : run_phase

  // Extract phase implementation
  function void monitor::extract_phase(uvm_phase phase); 
    `uvm_info(get_name,"we are in extract_phase",UVM_LOW)                                       
  endfunction

  // Check phase implementation
  function void monitor::check_phase(uvm_phase phase); 
    `uvm_info(get_name,"we are in check_phase",UVM_LOW)                                         
  endfunction

  // Report phase implementation
  function void monitor::report_phase(uvm_phase phase);
    `uvm_info(get_type_name(), $sformatf("Report: YAPP Monitor Collected %0d Packets", num_pkt_col), UVM_LOW)
  endfunction : report_phase

  // Final phase implementation
  function void monitor::final_phase(uvm_phase phase); 
    `uvm_info(get_name,"we are in final_phase",UVM_LOW)                                         
  endfunction

`endif

