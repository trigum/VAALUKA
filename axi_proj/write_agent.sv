////////////////////////////////////////////////
//                                            //   
//     file_name : write_agent.sv             //
//                                            // 
//     version   : 1.0                        //
//                                            //
//     notes     : agent of AXI               //                                        
//                                            // 
////////////////////////////////////////////////

`ifndef WRITE_AGENT
`define WRITE_AGENT

class write_agent extends uvm_agent;

  // factory registration
  `uvm_component_utils(write_agent)

  // decide agent is active or passive
  uvm_active_passive_enum is_active;

  // driver handle
  write_driver wd;
  
  // monitor handle
  write_monitor wm;

  // sequencer handle
  write_sequencer wseqh;

  extern function new(string name = "write_agent",uvm_component parent = null);

  extern function void build_phase(uvm_phase phase);

  extern function void connect_phase(uvm_phase phase);

endclass

  ////////////////////  CONSTRUCTOR  //////////////////////

  function write_agent::new(string name = "write_agent",uvm_component parent = null);
    super.new(name,parent);
  endfunction

  /////////////////////  BUILD_PHASE  ////////////////////

  function void write_agent::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(get_is_active == UVM_ACTIVE) begin
      wd = write_driver::type_id::create("wd",this);
      wseqh = write_sequencer::type_id::create("wseqh",this);
    end
    wm = write_monitor::type_id::create("wm",this);
  endfunction

  //////////////////////  CONNECT_PHASE  ////////////////////

  function void write_agent::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    
    // connect the driver and sequencer
    wd.seq_item_port.connect(wseqh.seq_item_export);
  endfunction

  `endif

