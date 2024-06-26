////////////////////////////////////////////////
//                                            //   
//     file_name : read_agent.sv              //
//                                            // 
//     version   : 1.0                        //
//                                            //
//     notes     : agent of AXI               //                                        
//                                            // 
////////////////////////////////////////////////


`ifndef READ_AGENT
`define READ_AGENT

//////////////////////////////
//                          //
//  IT IS A PASSIVE AGENT   //
//                          //
//////////////////////////////

class read_agent extends uvm_agent;

  // factory registration
  `uvm_component_utils(read_agent)
  
  // monitor handle
  read_monitor rm;

  extern function new(string name = "read_agent",uvm_component parent = null);

  extern function void build_phase(uvm_phase phase);

endclass

  /////////////////////  CONSTRUCTOR  ////////////////////////

  function read_agent::new(string name = "read_agent",uvm_component parent = null);
    super.new(name,parent);
  endfunction

  /////////////////////  BUILD PHASE  ////////////////////////

  function void read_agent::build_phase(uvm_phase phase);
    super.build_phase(phase);

    // creating object for read monitor
    rm = read_monitor::type_id::create("rm",this);
  endfunction

  `endif
