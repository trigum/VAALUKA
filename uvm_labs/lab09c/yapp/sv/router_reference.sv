


`ifndef REFERENCE
`define REFERENCE


class router_reference extends uvm_component;
  `uvm_component_utils(router_reference)
  `uvm_analysis_imp_decl(_yapp_r)
  `uvm_analysis_imp_decl(_hbus)
  uvm_analysis_imp_yapp_r #(yapp_packet,router_reference) y2r;
  uvm_analysis_imp_hbus #(hbus_transaction,router_reference) h2r;
  uvm_analysis_port #(yapp_packet) r2s;
  int max_pkt_size;
  int enable;

  extern function void write_hbus(hbus_transaction t1);

  extern function void write_yapp_r(yapp_packet t2);
  
  extern function new(string name="router_reference",uvm_component parent=null);

  extern function void build_phase(uvm_phase phase);                                  
 
  extern function void connect_phase(uvm_phase phase);                                 

  extern function void end_of_elaboration_phase(uvm_phase phase);                      
  
  extern function void start_of_simulation_phase(uvm_phase phase);     
  
  extern task run_phase(uvm_phase phase);                                                  // extern  phases
  
  extern function void extract_phase(uvm_phase phase);                                 
  
  extern function void check_phase(uvm_phase phase);                                   
  
  extern function void report_phase(uvm_phase phase);                                 
  
  extern function void final_phase(uvm_phase phase);

  
endclass

  function void router_reference::write_hbus(hbus_transaction t1);
    if(t1.hwr_rd==HBUS_READ && t1.haddr==0)
      max_pkt_size=t1.hdata;
    if(t1.hwr_rd==HBUS_READ && t1.haddr==1)
      enable=t1.hdata;
  endfunction

  function void router_reference::write_yapp_r(yapp_packet t2);
    if(enable&&t2.length<=max_pkt_size)
    begin
      yapp_packet t3=new t2;
      r2s.write(t3);
    end
    else if(t2.length>max_pkt_size)begin
      $display("packet_dropped due to high length");
      drop++;end
      else if(!enable) begin
      $display("enable is low");
      noenb++;end
  endfunction


  function router_reference::new(string name="router_reference",uvm_component parent=null);
    super.new(name,parent);
  endfunction

  function void router_reference::build_phase(uvm_phase phase);
    y2r=new("y2r",this);
    h2r=new("h2r",this);
    r2s=new("r2s",this);
  endfunction
	
  // connect phase
  
  function void router_reference::connect_phase(uvm_phase phase);  
    super.connect_phase(phase);    
    `uvm_info(get_name,"we are in connect_phase",UVM_LOW)
  endfunction

  // end of elobaration phase

  function void router_reference::end_of_elaboration_phase(uvm_phase phase);                             
    `uvm_info(get_name,"we are in EOE",UVM_LOW)
  endfunction
  
  // start of simulation phase

  function void router_reference::start_of_simulation_phase(uvm_phase phase);                            
    `uvm_info(get_name,"we are in SOS",UVM_LOW)
  endfunction

  // run phase

  task router_reference::run_phase(uvm_phase phase);
    `uvm_info(get_name,"we are in run_phase",UVM_LOW)                                              // run phase which print topology
  endtask
 
  // extract phase

  function void router_reference::extract_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in extract_phase",UVM_LOW)                                       
  endfunction

  // check phase

  function void router_reference::check_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in check_phase",UVM_LOW)                                         
  endfunction

  // report phase

  function void router_reference::report_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in report_phase",UVM_LOW)                                        
  endfunction

  // final phase

  function void router_reference::final_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in final_phase",UVM_LOW)                                         
  endfunction


  `endif



