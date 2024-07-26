
///////////////////////////////////////////////////////////////////////////////////
//                                                                               //
// File name     : monitor_example.sv                                            //
//                                                                               //
// Description   : The monitor monitors the activity of its interface bus.       //
//               : It collects both packets and responses.                       //
//                                                                               //
// version       : 2.0                                                           //
//                                                                               //
///////////////////////////////////////////////////////////////////////////////////

`ifndef MONITOR
`define MONITOR

class monitor extends uvm_monitor;
  `uvm_component_utils(monitor)

  // Collected Data handle
  yapp_packet packet_collected;

  // Virtual interface
  virtual yapp_if vif;

  // Analysis port to send collected packets
  uvm_analysis_port #(yapp_packet) mon2scr;

  // Counter for packets collected
  int num_pkt_col;

  // Task and functions declaration
  extern task collect_packet();
  extern function new(string name="monitor", uvm_component parent=null);
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

// Constructor
function monitor::new(string name="monitor", uvm_component parent=null);
  super.new(name, parent);
  mon2scr = new("mon2scr", this);
endfunction

// Build phase
function void monitor::build_phase(uvm_phase phase);
  `uvm_info(get_name(), "Entering build_phase", UVM_LOW)
  super.build_phase(phase);
  if (!yapp_vif_config::get(this, "", "vif", vif))
    `uvm_fatal("NOVIF", $sformatf("VIF not set for %s.vif", get_full_name()))
endfunction

// Connect phase
function void monitor::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  `uvm_info(get_name(), "Entering connect_phase", UVM_LOW)
endfunction

// End of elaboration phase
function void monitor::end_of_elaboration_phase(uvm_phase phase);
  `uvm_info(get_name(), "Entering end_of_elaboration_phase", UVM_LOW)
endfunction

// Start of simulation phase
function void monitor::start_of_simulation_phase(uvm_phase phase);
  `uvm_info(get_name(), "Entering start_of_simulation_phase", UVM_LOW)
endfunction

// Run phase
task monitor::run_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "Entering run_phase", UVM_MEDIUM)
  
  // Wait for reset to be de-asserted
  @(negedge vif.reset)
  `uvm_info(get_type_name(), "Reset de-asserted, beginning packet collection", UVM_MEDIUM)
  
  // Continuously collect packets
  forever collect_packet();
endtask : run_phase

// Task to collect packets
task monitor::collect_packet();
  // Create a new packet to store collected data
  packet_collected = yapp_packet::type_id::create("packet_collected", this);
  
  // Wait for data valid signal
  @(posedge vif.in_data_vld);

  // Collect header information
  @(posedge vif.clock iff (!vif.in_suspend))
  void'(this.begin_tr(packet_collected, "Monitor_YAPP_Packet"));

  `uvm_info(get_type_name(), "Collecting a packet", UVM_HIGH)
  { packet_collected.length, packet_collected.addr } = vif.in_data;
  packet_collected.payload = new[packet_collected.length]; // Allocate the payload array
  
  // Collect the payload
  for (int i = 0; i < packet_collected.length; i++) begin
    @(posedge vif.clock iff (!vif.in_suspend))
    packet_collected.payload[i] = vif.in_data;
  end

  // Collect parity and compute parity type
  @(posedge vif.clock iff (!vif.in_suspend))
  packet_collected.parity = vif.in_data;
  packet_collected.parity_type = (packet_collected.parity == packet_collected.calc_parity()) ? GOOD_PARITY : BAD_PARITY;

  // End transaction recording
  this.end_tr(packet_collected);
  
  `uvm_info(get_type_name(), $sformatf("Packet Collected:\n%s", packet_collected.sprint()), UVM_LOW)
  num_pkt_col++;
  
  // Send collected packet to the scoreboard
  mon2scr.write(packet_collected);
endtask : collect_packet

// Extract phase
function void monitor::extract_phase(uvm_phase phase);
  `uvm_info(get_name(), "Entering extract_phase", UVM_LOW)
endfunction

// Check phase
function void monitor::check_phase(uvm_phase phase);
  `uvm_info(get_name(), "Entering check_phase", UVM_LOW)
endfunction

// Report phase
function void monitor::report_phase(uvm_phase phase);
  `uvm_info(get_type_name(), $sformatf("Report: YAPP Monitor Collected %0d Packets", num_pkt_col), UVM_LOW)
endfunction

// Final phase
function void monitor::final_phase(uvm_phase phase);
  `uvm_info(get_name(), "Entering final_phase", UVM_LOW)
endfunction

`endif

