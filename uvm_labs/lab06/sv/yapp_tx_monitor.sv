

///////////////////////////////////////////////////////////////////////////
//                                                                       //
//  File name     : yapp_tx_monitor.sv                                   //
//                                                                       //
//  Description   : this file have to monitor signals from interface     //
//                                                                       //
//  Version       : 02                                                   //
//                                                                       //
///////////////////////////////////////////////////////////////////////////

`ifndef MONITOR
`define MONITOR

class monitor extends uvm_monitor;
    
    // factory registration
    `uvm_component_utils(monitor)
    
    // virtual interface declaration
    virtual yapp_if vif;
    
    // extren methods declarartion
    extern task collection_data();
  
    extern function new(string name = "monitor", uvm_component parent = null);
  
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
    
// collect task
task monitor::collection_data();
    while (vif.in_data_vld)
    begin
        $display(vif.in_data);
        @(negedge vif.i_clk);
    end
    $display(vif.in_data);
endtask

// constructor
function monitor::new(string name = "monitor", uvm_component parent = null);
    super.new(name, parent);
endfunction 
  
// build_phase
function void monitor::build_phase(uvm_phase phase);
    `uvm_info(get_name, "we are in build_phase", UVM_LOW)    
    super.build_phase(phase);
    if (!yapp_vif_config::get(this, "", "vif", vif))
        `uvm_fatal("NOVIF", {"vif not set for", get_full_name(), ".vif"})
endfunction

// connect phase
function void monitor::connect_phase(uvm_phase phase);  
    super.connect_phase(phase);    
    `uvm_info(get_name, "we are in connect_phase", UVM_LOW)
endfunction

// end of elaboration phase
function void monitor::end_of_elaboration_phase(uvm_phase phase);                             
    `uvm_info(get_name, "we are in EOE", UVM_LOW)
endfunction
  
// start of simulation phase
function void monitor::start_of_simulation_phase(uvm_phase phase);                            
    `uvm_info(get_name, "we are in SOS", UVM_LOW)
endfunction

// run phase
task monitor::run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("monitor", "", UVM_LOW)
    forever 
    begin
        @(negedge vif.i_clk)
        if (vif.in_data_vld)
            collection_data();
    end
endtask

// extract phase
function void monitor::extract_phase(uvm_phase phase); 
    `uvm_info(get_name, "we are in extract_phase", UVM_LOW)                                       
endfunction

// check phase
function void monitor::check_phase(uvm_phase phase); 
    `uvm_info(get_name, "we are in check_phase", UVM_LOW)                                         
endfunction

// report phase
function void monitor::report_phase(uvm_phase phase); 
    `uvm_info(get_name, "we are in report_phase", UVM_LOW)                                        
endfunction

// final phase
function void monitor::final_phase(uvm_phase phase); 
    `uvm_info(get_name, "we are in final_phase", UVM_LOW)                                         
endfunction

`endif

