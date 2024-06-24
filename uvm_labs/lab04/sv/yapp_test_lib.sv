/*-----------------------------------------------------------------
File name     : yapp_test_lib.sv
Description   : this file have to create the environment and start the respective sequence 
Notes         : 
-------------------------------------------------------------------
-----------------------------------------------------------------*/

//------------------------------------------------------------------------------
//
// test library
//
//------------------------------------------------------------------------------

`ifndef TEST
`define TEST

/////////////////////
//                 //
//   BASE TEST     //
//                 //
/////////////////////

class base_test extends uvm_test;
  
  `uvm_component_utils(base_test)
  
  environment env;
  
  uvm_active_passive_enum is_active;
  
  extern function new (string name="base_test",uvm_component parent=null);
   
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

  //constructor

  function base_test::new (string name="base_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction

  // build phase

  function void base_test::build_phase(uvm_phase phase);
    `uvm_info(get_name,"we are in build_phase",UVM_LOW)      
    uvm_config_wrapper ::set(this,"env.ag.seqr.run_phase","default_sequence",sequences::type_id::get());
    super.build_phase(phase);
    env=environment::type_id::create("env",this);
  endfunction

  // connect phase
  
  function void base_test::connect_phase(uvm_phase phase);  
    super.connect_phase(phase);    
    `uvm_info(get_name,"we are in connect_phase",UVM_LOW)
  endfunction

  // end of elaboration phase

  function void base_test::end_of_elaboration_phase(uvm_phase phase);
    `uvm_info(get_name,"we are in EOE",UVM_LOW)    
    uvm_top.print_topology();
  endfunction 

  // start of simulation phase

  function void base_test::start_of_simulation_phase(uvm_phase phase);                            
    `uvm_info(get_name,"we are in SOS",UVM_LOW)
  endfunction

  // run phase

  task base_test::run_phase(uvm_phase phase);
    `uvm_info(get_name,"we are in run_phase",UVM_LOW)                                              
  endtask
 
  // extract phase

  function void base_test::extract_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in extract_phase",UVM_LOW)                                       
  endfunction

  // check phase

  function void base_test::check_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in check_phase",UVM_LOW)                                         
  endfunction

  // report phase

  function void base_test::report_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in report_phase",UVM_LOW)                                        
  endfunction

  // final phase

  function void base_test::final_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in final_phase",UVM_LOW)                                         
  endfunction



/////////////////////
//                 //
//   SHORT_PACKET  //
//                 //
/////////////////////


class short_packet_test extends base_test;
  
  `uvm_component_utils(short_packet_test)
   
  extern function new(string name ="short_packet_test",uvm_component parent=null);
  
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
  

  // constructor

  function short_packet_test::new(string name ="short_packet_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  // build phase

  function void short_packet_test::build_phase(uvm_phase phase);
    `uvm_info(get_name,"we are in build_phase",UVM_LOW)          
    set_type_override_by_type(yapp_packet::get_type(),yapp_short_item::get_type());
    set_config_int ("env.ag","is_active",UVM_ACTIVE);
    super.build_phase(phase);
  endfunction
  
  // connect phase
  
  function void short_packet_test::connect_phase(uvm_phase phase);  
    super.connect_phase(phase);    
    `uvm_info(get_name,"we are in connect_phase",UVM_LOW)
  endfunction

  // end of elaboration phase
  
  function void short_packet_test::end_of_elaboration_phase(uvm_phase phase);
    `uvm_info(get_name,"we are in EOE",UVM_LOW)        
    uvm_top.print_topology();
  endfunction 

  // start of simulation phase

  function void short_packet_test::start_of_simulation_phase(uvm_phase phase);                            
    `uvm_info(get_name,"we are in SOS",UVM_LOW)
  endfunction

  // run phase

  task short_packet_test::run_phase(uvm_phase phase);
    `uvm_info(get_name,"we are in run_phase",UVM_LOW)                                              
  endtask
 
  // extract phase

  function void short_packet_test::extract_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in extract_phase",UVM_LOW)                                       
  endfunction

  // check phase

  function void short_packet_test::check_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in check_phase",UVM_LOW)                                         
  endfunction

  // report phase

  function void short_packet_test::report_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in report_phase",UVM_LOW)                                        
  endfunction

  // final phase

  function void short_packet_test::final_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in final_phase",UVM_LOW)                                         
  endfunction

/////////////////////
//                 //
//  CONFIG TEST    //
//                 //
/////////////////////


class set_config_test extends base_test;

   `uvm_component_utils(set_config_test)

  extern function new(string name ="set_config_test",uvm_component parent=null);
  
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

  // constructor

  function set_config_test::new(string name ="set_config_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  // build phase

  function void set_config_test::build_phase(uvm_phase phase);
    super.build_phase(phase);
    set_config_int("env.ag","is_active",UVM_PASSIVE);
  endfunction
  
   // connect phase
  
  function void set_config_test::connect_phase(uvm_phase phase);  
    super.connect_phase(phase);    
    `uvm_info(get_name,"we are in connect_phase",UVM_LOW)
  endfunction

  // end of elaboration phase

  function void set_config_test::end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();
  endfunction 

  // start of simulation phase

  function void set_config_test::start_of_simulation_phase(uvm_phase phase);                            
    `uvm_info(get_name,"we are in SOS",UVM_LOW)
  endfunction

  // run phase

  task set_config_test::run_phase(uvm_phase phase);
    `uvm_info(get_name,"we are in run_phase",UVM_LOW)                                              
  endtask
 
  // extract phase

  function void set_config_test::extract_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in extract_phase",UVM_LOW)                                       
  endfunction

  // check phase

  function void set_config_test::check_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in check_phase",UVM_LOW)                                         
  endfunction

  // report phase

  function void set_config_test::report_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in report_phase",UVM_LOW)                                        
  endfunction

  // final phase

  function void set_config_test::final_phase(uvm_phase phase); 
   `uvm_info(get_name,"we are in final_phase",UVM_LOW)                                         
  endfunction
  
`endif
