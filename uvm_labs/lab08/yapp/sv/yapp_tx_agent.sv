

///////////////////////////////////////////////////////////////////////
//  File name     : yapp_tx_agent.sv                                 //
//                                                                   //
//  Description   : this file have tx_agent which is active          //
//                                                                   //
//  version       : 2.0                                              //
///////////////////////////////////////////////////////////////////////


`ifndef AGENT
`define AGENT

/////////////////////////////
//                         //
//         AGENT           //
//                         //
/////////////////////////////

// Define a UVM agent class
class agent extends uvm_agent;
  
  // Register the class with the UVM factory
  `uvm_component_utils(agent)
 
  // Handle for the driver
  driver dr;

  // Handle for the monitor  
  monitor mn;
 
  // Handle for the sequencer
  sequencer seqr;

  // Enum to decide if the agent is active or passive  
  uvm_active_passive_enum is_active = UVM_ACTIVE;
  
  // Constructor declaration
  extern function new(string name = "agent",uvm_component parent = null);
  
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

  // Constructor implementation
  function agent::new(string name = "agent",uvm_component parent = null);
    super.new(name,parent);
  endfunction
 
  // Build phase implementation
  function void agent::build_phase(uvm_phase phase);
    `uvm_info(get_name,"we are in build_phase",UVM_LOW)
    super.build_phase(phase);

    // Create handles for the sequencer and driver if the agent is active
    if(get_is_active() == UVM_ACTIVE)
    begin
      seqr = sequencer::type_id::create("seqr",this);
      dr   = driver::type_id::create("dr",this);
    end

    // Create a handle for the monitor
    mn = monitor::type_id::create("mn",this);
  endfunction

  // Connect phase implementation
  function void agent::connect_phase(uvm_phase phase);
    `uvm_info(get_name,"we are in connect_phase",UVM_LOW)
    super.connect_phase(phase);

    // Connect the driver to the sequencer if the agent is active
    if(get_is_active() == UVM_ACTIVE)
      dr.seq_item_port.connect(seqr.seq_item_export);
  endfunction

  // End of elaboration phase implementation
  function void agent::end_of_elaboration_phase(uvm_phase phase);                             
    `uvm_info(get_name,"we are in EOE",UVM_LOW)
  endfunction
  
  // Start of simulation phase implementation
  function void agent::start_of_simulation_phase(uvm_phase phase);                            
    `uvm_info(get_name,"we are in SOS",UVM_LOW)
  endfunction

  // Run phase implementation
  task agent::run_phase(uvm_phase phase);
    `uvm_info(get_name,"we are in run_phase",UVM_LOW)                                          
  endtask
 
  // Extract phase implementation
  function void agent::extract_phase(uvm_phase phase); 
    `uvm_info(get_name,"we are in extract_phase",UVM_LOW)                                       
  endfunction

  // Check phase implementation
  function void agent::check_phase(uvm_phase phase); 
    `uvm_info(get_name,"we are in check_phase",UVM_LOW)                                         
  endfunction

  // Report phase implementation
  function void agent::report_phase(uvm_phase phase); 
    `uvm_info(get_name,"we are in report_phase",UVM_LOW)                                        
  endfunction

  // Final phase implementation
  function void agent::final_phase(uvm_phase phase); 
    `uvm_info(get_name,"we are in final_phase",UVM_LOW)                                         
  endfunction

`endif

