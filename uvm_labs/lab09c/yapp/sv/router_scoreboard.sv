

`ifndef SCOREBOARD
`define SCOREBOARD
class router_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(router_scoreboard)
  `uvm_analysis_imp_decl(_yapp)
  `uvm_analysis_imp_decl(_ch0)
  `uvm_analysis_imp_decl(_ch1)
  `uvm_analysis_imp_decl(_ch2)

  uvm_analysis_imp_yapp #(yapp_packet,router_scoreboard) m2s;
  uvm_analysis_imp_ch0 #(yapp_packet,router_scoreboard) ch02s;
  uvm_analysis_imp_ch1 #(yapp_packet,router_scoreboard) ch12s;
  uvm_analysis_imp_ch2 #(yapp_packet,router_scoreboard) ch22s;

 
  yapp_packet storage_0[$];
  yapp_packet storage_1[$];
  yapp_packet storage_2[$];


  extern function void write_yapp(yapp_packet t1);

  extern function void write_ch0(yapp_packet t3);

  extern function void write_ch1(yapp_packet t5);
  
  extern function void write_ch2(yapp_packet t7);
  
  extern function new(string name="router_scoreboard",uvm_component parent=null);
  
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
 
  function router_scoreboard::new(string name="router_scoreboard",uvm_component parent=null);
    super.new(name,parent);
    m2s=new("m2s",this);
    ch02s=new("ch02s",this);
    ch12s=new("ch12s",this);
    ch22s=new("ch22s",this);
  endfunction 

  function void router_scoreboard::write_yapp(yapp_packet t1);
    yapp_packet t2=new t1;
    if(t2.addr==2'b00)
      storage_0.push_front(t2);
    else if(t2.addr==2'b01)
      storage_1.push_front(t2);
    else if(t2.addr==2'b10)
      storage_2.push_front(t2);
  endfunction

  function void router_scoreboard::write_ch0(yapp_packet t3);
    yapp_packet t4;
    t4= storage_0.pop_back;
    if(t4.compare(t3))
    begin
      $display("correctly routed");
      ch0_crt++;
    end
    else 
    begin
      t4.print();
      t3.print();
      $display("wrong");
    end
  endfunction

  function void router_scoreboard::write_ch1(yapp_packet t5);
    yapp_packet t6;
    t6= storage_1.pop_back;
    if(t6.compare(t5)) 
    begin
      $display("correctly routed");
      ch1_crt++;
    end
    else 
    begin
      t5.print();
      t6.print();
      $display("wrong");
    end
  endfunction
    
  function void router_scoreboard::write_ch2(yapp_packet t7);
    yapp_packet t8;
    t8= storage_2.pop_back;
    if(t8.compare(t7))
    begin
      $display("correctly routed");
      ch2_crt++;
    end
    else 
    begin
      t7.print();
      t8.print();
      $display("wrong");
    end
  endfunction

  // build_phase

  function void router_scoreboard::build_phase(uvm_phase phase);
    `uvm_info(get_name,"we are in build_phase",UVM_LOW)  
  endfunction
  
  // connect phase
  
  function void router_scoreboard::connect_phase(uvm_phase phase);  
    super.connect_phase(phase);    
    `uvm_info(get_name,"we are in connect_phase",UVM_LOW)
  endfunction

  // end of elobaration phase

  function void router_scoreboard::end_of_elaboration_phase(uvm_phase phase);                             
    `uvm_info(get_name,"we are in EOE",UVM_LOW)
  endfunction
  
  // start of simulation phase

  function void router_scoreboard::start_of_simulation_phase(uvm_phase phase);                            
    `uvm_info(get_name,"we are in SOS",UVM_LOW)
  endfunction

  // run phase

  task router_scoreboard::run_phase(uvm_phase phase);
    `uvm_info(get_name,"we are in run_phase",UVM_LOW)                                              // run phase which print topology
  endtask
 
  // extract phase

  function void router_scoreboard::extract_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in extract_phase",UVM_LOW)                                       
  endfunction

  // check phase

  function void router_scoreboard::check_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in check_phase",UVM_LOW)                                         
  endfunction

  // report phase

  function void router_scoreboard::report_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in report_phase",UVM_LOW)                                        
  endfunction

  // final phase

  function void router_scoreboard::final_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in final_phase",UVM_LOW)                                         
  endfunction
   
  `endif    
