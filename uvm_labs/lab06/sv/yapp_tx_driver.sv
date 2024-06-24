



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
  `uvm_component_utils(driver)
  
  virtual yapp_if vif;
  
  extern task send_to_dut();
  
  extern task reset_signals();
  
  extern task get_and_drive(yapp_packet t2);
  
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
    
  task driver::send_to_dut();
    forever
    begin
      seq_item_port.get_next_item(req);
      wait(!vif.i_rst)
      get_and_drive(req);
      seq_item_port.item_done();
    end
  endtask
   
  task driver::reset_signals();
    forever begin
      @(posedge vif.i_clk)
      if(vif.i_rst) begin
        disable get_and_drive;
        vif.in_data     <= 0;
        vif.in_data_vld <= 0;
      end
    end
  endtask

  task driver::get_and_drive(yapp_packet t2);
    t2.print();   
    @(negedge vif.i_clk)
      while(vif.in_suspend) @(negedge vif.i_clk);
       vif.in_data_vld <= 1;
    vif.in_data <= t2.header;
    foreach(t2.payload[i]) begin
    @(negedge vif.i_clk)
      while(vif.in_suspend) @(negedge vif.i_clk);        
    vif.in_data <= t2.payload[i];end
    @(negedge vif.i_clk)
      while(vif.in_suspend) @(negedge vif.i_clk);
       
    vif.in_data_vld <= 0;
    vif.in_data <= t2.parity;
  endtask

  // constructor
  function driver::new(string name = "driver",uvm_component parent = null);
    super.new(name,parent);
  endfunction

  // build_phase
  function void driver::build_phase(uvm_phase phase);
    `uvm_info(get_name,"we are in build_phase",UVM_LOW)      
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
    `uvm_info(get_name,"we are in run_phase",UVM_LOW)                                             
     fork
       send_to_dut();
       reset_signals();
     join
  endtask

   // extract phase

  function void driver::extract_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in extract_phase",UVM_LOW)                                       
  endfunction

  // check phase

  function void driver::check_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in check_phase",UVM_LOW)                                         
  endfunction

  // report phase

  function void driver::report_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in report_phase",UVM_LOW)                                        
  endfunction

  // final phase

  function void driver::final_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in final_phase",UVM_LOW)                                         
  endfunction

`endif
