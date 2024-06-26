////////////////////////////////////////////////
//                                            //   
//     file_name : environment.sv             //
//                                            // 
//     version   : 1.0                        //
//                                            //
//     notes     : environment of AXI         //                                        
//                                            // 
////////////////////////////////////////////////

`ifndef ENVIRONMENT
`define ENVIRONMENT

class environment extends uvm_env;

  // factory registration
  `uvm_component_utils(environment)

  // write_agent handle
  write_agent wa;
  
  // read_agent handle
  read_agent ra;

  // scoreboard handle
  axi_scoreboard sc;

  extern function new(string name = "environment",uvm_component parent = null);

  extern function void build_phase(uvm_phase phase);

  extern function void connect_phase(uvm_phase phase);

endclass

  /////////////////////  CONSTRUCTOR  ///////////////////////

  function environment::new(string name = "environment",uvm_component parent = null);
    super.new(name,parent);
  endfunction

  /////////////////////  BUILD_PHASE  ///////////////////////

  function void environment::build_phase(uvm_phase phase);
    super.build_phase(phase);

    // creating object for write_agent
    wa = write_agent::type_id::create("wa",this);

    // creating object for read_agent
    ra = read_agent::type_id::create("ra",this);

    // creating object for scoreboard
    sc = axi_scoreboard::type_id::create("sc",this);
  endfunction

  /////////////////////  CONNECT PHASE  ////////////////////

  function void environment::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    
    // connecting write monitor's write transaction data with scoreboard 
    wa.wm.wm2s.connect(sc.wm2s);

    // connecting write monitor's read address with scoreboard
    wa.wm.wm2s_r.connect(sc.wm2s_r);

    // connecting read monitor's read data with scoreboard
    ra.rm.rm2s.connect(sc.rm2s);

    wa.wm.wm2s_address.connect(sc.wm2s_address);
  endfunction

  `endif
