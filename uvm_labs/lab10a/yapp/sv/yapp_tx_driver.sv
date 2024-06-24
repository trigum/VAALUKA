


///////////////////////////////////////////////////////////////////////
//  File name     : yapp_tx_driver.sv                                //
//                                                                   //
//  Description   : this file drive stimulus to interface            //
//                                                                   //
//  Notes         : it is tx_yapp driver                             //
///////////////////////////////////////////////////////////////////////


`ifndef DRIVER
`define DRIVER
class driver extends uvm_driver #(yapp_packet);

// factory registration
  `uvm_component_utils(driver);
  // Declare this property to count packets sent
  int num_sent;
  
  virtual yapp_if vif;

  extern task send_to_dut(yapp_packet packet);
  
  extern task reset_signals();
  
  extern task get_and_drive();

  extern function new(string name = "driver",uvm_component parent = null);
  
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


  // Gets a packet and drive it into the DUT
  task driver::send_to_dut(yapp_packet packet);
    $display("delay================================%d",packet.packet_delay);
    // Wait for packet delay
    repeat(packet.packet_delay)
      @(negedge vif.clock);

    // Start to send packet if not in_suspend signal
    @(negedge vif.clock iff (!vif.in_suspend));

    // Begin Transaction recording:browse confirm wa
    //
    void'(this.begin_tr(packet, "Input_YAPP_Packet"));

    // Enable start packet signal
    vif.in_data_vld <= 1'b1;

    // Drive the Header {Length, Addr}
    vif.in_data <= { packet.length, packet.addr };

    // Drive Payload
    for (int i=0; i<packet.payload.size(); i++) begin
      @(negedge vif.clock iff (!vif.in_suspend))
      vif.in_data <= packet.payload[i];
    end
    // Drive Parity and reset Valid
    @(negedge vif.clock iff (!vif.in_suspend))
    vif.in_data_vld <= 1'b0;
    vif.in_data  <= packet.parity;
    total++;

    @(negedge  vif.clock)
      vif.in_data  <= 8'bz;
    num_sent++;

    // End transaction recording
    this.end_tr(packet);

  endtask : send_to_dut
  
  
  // Reset all TX signals
  task driver::reset_signals();
    forever begin
      @(posedge vif.reset);
       `uvm_info(get_type_name(), "Reset observed", UVM_MEDIUM)
      vif.in_data           <=  'hz;
      vif.in_data_vld       <= 1'b0;
      disable send_to_dut;
    end
  endtask : reset_signals

  // Gets packets from the sequencer and passes them to the driver. 
  task driver::get_and_drive();
    @(negedge vif.reset);
    `uvm_info(get_type_name(), "Reset dropped", UVM_MEDIUM)
    forever begin
       seq_item_port.get_next_item(req);
       send_to_dut(req);
       seq_item_port.item_done();
    end
  endtask : get_and_drive

  function driver::new(string name = "driver",uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  // build phase

  function void driver::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!yapp_vif_config::get(this,"","vif",vif))
      `uvm_fatal("NOVIF",{"vif not set for",get_full_name(),".vif"})
  endfunction

  // connect phase
  
  function void driver::connect_phase(uvm_phase phase);  
    super.connect_phase(phase);    
    `uvm_info(get_name,"we are in connect_phase",UVM_LOW)
  endfunction

  // end of elobaration phase

  function void driver::end_of_elaboration_phase(uvm_phase phase);                             
    `uvm_info(get_name,"we are in EOE",UVM_LOW)
  endfunction
  
  // start of simulation phase

  function void driver::start_of_simulation_phase(uvm_phase phase);                            
    `uvm_info(get_name,"we are in SOS",UVM_LOW)
  endfunction

  // run phase

  task driver::run_phase(uvm_phase phase);
    `uvm_info(get_name,"we are in SOS",UVM_LOW)    
    fork
      get_and_drive();
      reset_signals();
    join
  endtask : run_phase

   // extract phase

  function void driver::extract_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in extract_phase",UVM_LOW)                                       
  endfunction

  // check phase

  function void driver::check_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in check_phase",UVM_LOW)                                         
  endfunction

  // UVM report_phase() 

  function void driver::report_phase(uvm_phase phase);
    `uvm_info(get_type_name(), $sformatf("Report: YAPP TX driver sent %0d packets", num_sent), UVM_LOW)
  endfunction : report_phase

   // final phase

  function void driver::final_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in final_phase",UVM_LOW)                                         
  endfunction

`endif
