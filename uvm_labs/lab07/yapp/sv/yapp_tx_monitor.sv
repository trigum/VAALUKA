
/////////////////////////////////////////////////////////////////////////////////////
//                                                                                 //
// File name     : monitor_example.sv                                              //
//                                                                                 //
// Description   : This file supplies example yapp_tx_monitor methods for lab06    //
//                                                                                 //
// Version       : 2.0                                                             //
//                                                                                 //
/////////////////////////////////////////////////////////////////////////////////////

`ifndef MONITOR
`define MONITOR

class monitor extends uvm_monitor;

  // Factory registration
  `uvm_component_utils(monitor)

  // Collected Data handle
  yapp_packet packet_collected;

  // Virtual interface handle
  virtual yapp_if vif;

  // Count packets collected
  int num_pkt_col;

  // Task to collect a packet
  extern task collect_packet();

  // Constructor
  extern function new(string name = "monitor", uvm_component parent = null);

  // extern Phase functions
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

  // Task to collect a packet
  task monitor::collect_packet();

    // Monitor looks at the bus on posedge (Driver uses negedge)
    @(posedge vif.in_data_vld);

    // Wait for clock edge if not in suspend
    @(posedge vif.clock iff (!vif.in_suspend));

    // Begin transaction recording
    void'(this.begin_tr(packet_collected, "Monitor_YAPP_Packet"));

    `uvm_info(get_type_name(), "Collecting a packet", UVM_HIGH)

    // Collect Header {Length, Addr}
    { packet_collected.length, packet_collected.addr } = vif.in_data;

    // Allocate payload array based on length
    packet_collected.payload = new [packet_collected.length];

    // Collect the Payload
    for (int i = 0; i < packet_collected.length; i++) begin
      @(posedge vif.clock iff (!vif.in_suspend))
      packet_collected.payload[i] = vif.in_data;
    end

    // Collect Parity and Compute Parity Type
    @(posedge vif.clock iff (!vif.in_suspend))
      packet_collected.parity = vif.in_data;

    packet_collected.parity_type = (packet_collected.parity == packet_collected.calc_parity()) ? GOOD_PARITY : BAD_PARITY;

    // End transaction recording
    this.end_tr(packet_collected);

    `uvm_info(get_type_name(), $sformatf("Packet Collected :\n%s", packet_collected.sprint()), UVM_LOW)

    // Increment packet count
    num_pkt_col++;

  endtask : collect_packet

  // Constructor
  function monitor::new(string name = "monitor", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build phase
  function void monitor::build_phase(uvm_phase phase);
    `uvm_info(get_name(), "we are in build_phase", UVM_LOW)
    super.build_phase(phase);

    if (!yapp_vif_config::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", {"vif not set for", get_full_name(), ".vif"})

  endfunction

  // Connect phase
  function void monitor::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info(get_name(), "we are in connect_phase", UVM_LOW)
  endfunction

  // End of elaboration phase
  function void monitor::end_of_elaboration_phase(uvm_phase phase);
    `uvm_info(get_name(), "we are in EOE", UVM_LOW)
  endfunction

  // Start of simulation phase
  function void monitor::start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_name(), "we are in SOS", UVM_LOW)
  endfunction

  // Run phase
  task monitor::run_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "Inside the run_phase", UVM_MEDIUM)

    // Create collected packet instance
    packet_collected = yapp_packet::type_id::create("packet_collected", this);

    // Look for packets after reset
    @(negedge vif.reset)
    `uvm_info(get_type_name(), "Detected Reset Done", UVM_MEDIUM)

    forever 
      collect_packet();

  endtask : run_phase

  // Extract phase
  function void monitor::extract_phase(uvm_phase phase);
    `uvm_info(get_name(), "we are in extract_phase", UVM_LOW)
  endfunction

  // Check phase
  function void monitor::check_phase(uvm_phase phase);
    `uvm_info(get_name(), "we are in check_phase", UVM_LOW)
  endfunction

  // UVM report_phase
  function void monitor::report_phase(uvm_phase phase);
    `uvm_info(get_type_name(), $sformatf("Report: YAPP Monitor Collected %0d Packets", num_pkt_col), UVM_LOW)
  endfunction : report_phase

  // Final phase
  function void monitor::final_phase(uvm_phase phase);
    `uvm_info(get_name(), "we are in final_phase", UVM_LOW)
  endfunction

`endif

