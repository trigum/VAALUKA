
//////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                              //
//  File name     : yapp_test_lib.sv                                                            //
//                                                                                              //
//  Description   : this file have to create the environment and start the respective sequence  //
//                                                                                              //
//  version       : 02                                                                          //
//                                                                                              //
//////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef TEST
`define TEST


///////////////////////////
//                       //
//      Base test        //
//                       //
///////////////////////////

class base_test extends uvm_test;
  
  `uvm_component_utils(base_test)
  
  environment env;
  
  uvm_active_passive_enum is_active;
  
  // Constructor
  extern function new (string name="base_test", uvm_component parent=null);
  
  // Build phase
  extern function void build_phase(uvm_phase phase);
  
  // Connect phase
  extern function void connect_phase(uvm_phase phase);
  
  // End of elaboration phase
  extern function void end_of_elaboration_phase(uvm_phase phase);
  
  // Start of simulation phase
  extern function void start_of_simulation_phase(uvm_phase phase);
  
  // Run phase
  extern task run_phase(uvm_phase phase);
  
  // Extract phase
  extern function void extract_phase(uvm_phase phase);
  
  // Check phase
  extern function void check_phase(uvm_phase phase);
  
  // Report phase
  extern function void report_phase(uvm_phase phase);
  
  // Final phase
  extern function void final_phase(uvm_phase phase);

endclass

function base_test::new (string name="base_test", uvm_component parent=null);
  super.new(name, parent);
endfunction

function void base_test::build_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in build_phase", UVM_LOW)
  super.build_phase(phase);
  env = environment::type_id::create("env", this);
endfunction

function void base_test::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  `uvm_info(get_name, "we are in connect_phase", UVM_LOW)
endfunction

function void base_test::end_of_elaboration_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in EOE", UVM_LOW)
  uvm_top.print_topology();
endfunction

function void base_test::start_of_simulation_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in SOS", UVM_LOW)
endfunction

task base_test::run_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in run_phase", UVM_LOW)
endtask

function void base_test::extract_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in extract_phase", UVM_LOW)
endfunction

function void base_test::check_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in check_phase", UVM_LOW)
endfunction

function void base_test::report_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in report_phase", UVM_LOW)
endfunction

function void base_test::final_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in final_phase", UVM_LOW)
endfunction


///////////////////////////
//                       //
//   short packet test   //
//                       //
///////////////////////////

class short_packet_test extends base_test;
  
  `uvm_component_utils(short_packet_test)
  
  // Constructor
  extern function new(string name ="short_packet_test", uvm_component parent=null);
  
  // Build phase
  extern function void build_phase(uvm_phase phase);
  
  // Connect phase
  extern function void connect_phase(uvm_phase phase);
  
  // End of elaboration phase
  extern function void end_of_elaboration_phase(uvm_phase phase);
  
  // Start of simulation phase
  extern function void start_of_simulation_phase(uvm_phase phase);
  
  // Run phase
  extern task run_phase(uvm_phase phase);
  
  // Extract phase
  extern function void extract_phase(uvm_phase phase);
  
  // Check phase
  extern function void check_phase(uvm_phase phase);
  
  // Report phase
  extern function void report_phase(uvm_phase phase);
  
  // Final phase
  extern function void final_phase(uvm_phase phase);

endclass

function short_packet_test::new(string name ="short_packet_test", uvm_component parent=null);
  super.new(name, parent);
endfunction

function void short_packet_test::build_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in build_phase", UVM_LOW)
  set_type_override_by_type(yapp_packet::get_type(), yapp_short_item::get_type());
  set_config_int("env.ag", "is_active", UVM_ACTIVE);
  super.build_phase(phase);
endfunction

function void short_packet_test::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  `uvm_info(get_name, "we are in connect_phase", UVM_LOW)
endfunction

function void short_packet_test::end_of_elaboration_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in EOE", UVM_LOW)
  uvm_top.print_topology();
endfunction

function void short_packet_test::start_of_simulation_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in SOS", UVM_LOW)
endfunction

task short_packet_test::run_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in run_phase", UVM_LOW)
endtask

function void short_packet_test::extract_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in extract_phase", UVM_LOW)
endfunction

function void short_packet_test::check_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in check_phase", UVM_LOW)
endfunction

function void short_packet_test::report_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in report_phase", UVM_LOW)
endfunction

function void short_packet_test::final_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in final_phase", UVM_LOW)
endfunction


///////////////////////////
//                       //
//   set config test     //
//                       //
///////////////////////////

class set_config_test extends base_test;

  `uvm_component_utils(set_config_test)

  // Constructor
  extern function new(string name ="set_config_test", uvm_component parent=null);
  
  // Build phase
  extern function void build_phase(uvm_phase phase);
  
  // Connect phase
  extern function void connect_phase(uvm_phase phase);
  
  // End of elaboration phase
  extern function void end_of_elaboration_phase(uvm_phase phase);
  
  // Start of simulation phase
  extern function void start_of_simulation_phase(uvm_phase phase);
  
  // Run phase
  extern task run_phase(uvm_phase phase);
  
  // Extract phase
  extern function void extract_phase(uvm_phase phase);
  
  // Check phase
  extern function void check_phase(uvm_phase phase);
  
  // Report phase
  extern function void report_phase(uvm_phase phase);
  
  // Final phase
  extern function void final_phase(uvm_phase phase);

endclass

function set_config_test::new(string name ="set_config_test", uvm_component parent=null);
  super.new(name, parent);
endfunction

function void set_config_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
  set_config_int("env.ag", "is_active", UVM_PASSIVE);
endfunction

function void set_config_test::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  `uvm_info(get_name, "we are in connect_phase", UVM_LOW)
endfunction

function void set_config_test::end_of_elaboration_phase(uvm_phase phase);
  uvm_top.print_topology();
endfunction

function void set_config_test::start_of_simulation_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in SOS", UVM_LOW)
endfunction

task set_config_test::run_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in run_phase", UVM_LOW)
endtask

function void set_config_test::extract_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in extract_phase", UVM_LOW)
endfunction

function void set_config_test::check_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in check_phase", UVM_LOW)
endfunction

function void set_config_test::report_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in report_phase", UVM_LOW)
endfunction

function void set_config_test::final_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in final_phase", UVM_LOW)
endfunction


///////////////////////////
//                       //
//   short incr payload  //
//                       //
///////////////////////////

class short_incr_payload extends base_test;

  `uvm_component_utils(short_incr_payload)
  
  // Constructor
  extern function new(string name ="short_incr_payload", uvm_component parent=null);
  
  // Build phase
  extern function void build_phase(uvm_phase phase);
  
  // Connect phase
  extern function void connect_phase(uvm_phase phase);
  
  // End of elaboration phase
  extern function void end_of_elaboration_phase(uvm_phase phase);
  
  // Start of simulation phase
  extern function void start_of_simulation_phase(uvm_phase phase);
  
  // Run phase
  extern task run_phase(uvm_phase phase);
  
  // Extract phase
  extern function void extract_phase(uvm_phase phase);
  
  // Check phase
  extern function void check_phase(uvm_phase phase);
  
  // Report phase
  extern function void report_phase(uvm_phase phase);
  
  // Final phase
  extern function void final_phase(uvm_phase phase);

endclass

function short_incr_payload::new(string name ="short_incr_payload", uvm_component parent=null);
  super.new(name, parent);
endfunction

function void short_incr_payload::build_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in build_phase", UVM_LOW)
  set_type_override_by_type(yapp_packet::get_type(), yapp_short_item::get_type());
  set_config_int("env.ag", "is_active", UVM_ACTIVE);
  super.build_phase(phase);
endfunction

function void short_incr_payload::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  `uvm_info(get_name, "we are in connect_phase", UVM_LOW)
endfunction

function void short_incr_payload::end_of_elaboration_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in EOE", UVM_LOW)
  uvm_top.print_topology();
endfunction

function void short_incr_payload::start_of_simulation_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in SOS", UVM_LOW)
endfunction

task short_incr_payload::run_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in run_phase", UVM_LOW)
endtask

function void short_incr_payload::extract_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in extract_phase", UVM_LOW)
endfunction

function void short_incr_payload::check_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in check_phase", UVM_LOW)
endfunction

function void short_incr_payload::report_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in report_phase", UVM_LOW)
endfunction

function void short_incr_payload::final_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in final_phase", UVM_LOW)
endfunction


///////////////////////////
//                       //
// sequence_library test //
//                       //
///////////////////////////

class exhaustive_seq_test extends base_test;

  // factory registration
  `uvm_component_utils(exhaustive_seq_test)

  // seq lib handle
  yapp_seq_lib seq_lib;

  // extern phases declaration
  extern function new(string name="exhaustive_seq_test", uvm_component parent=null);
  
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
  
// constructor 
function exhaustive_seq_test::new(string name="exhaustive_seq_test", uvm_component parent=null);
  super.new(name, parent);
  seq_lib = yapp_seq_lib::type_id::create("seq_lib");
endfunction
  
// build phase
function void exhaustive_seq_test::build_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in build_phase", UVM_LOW)     
  super.build_phase(phase);
  seq_lib.selection_mode = UVM_SEQ_LIB_RANDC;
  seq_lib.max_random_count = 5;
  seq_lib.min_random_count = 2;
  void'(seq_lib.randomize());
  set_type_override_by_type(yapp_packet::get_type(), yapp_short_item::get_type);
  uvm_config_db#(uvm_sequence_base)::set(this, "env.ag.seqr.run_phase", "default_sequence", seq_lib);
endfunction

// connect phase
function void exhaustive_seq_test::connect_phase(uvm_phase phase);  
  super.connect_phase(phase);    
  `uvm_info(get_name, "we are in connect_phase", UVM_LOW)
endfunction

// end of elaboration phase
function void exhaustive_seq_test::end_of_elaboration_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in EOE", UVM_LOW)    
  seq_lib.print();
  uvm_top.print_topology();
endfunction 

// start of simulation phase
function void exhaustive_seq_test::start_of_simulation_phase(uvm_phase phase);                            
  `uvm_info(get_name, "we are in SOS", UVM_LOW)
endfunction

// run phase
task exhaustive_seq_test::run_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in run_phase", UVM_LOW)                                              
endtask

// extract phase
function void exhaustive_seq_test::extract_phase(uvm_phase phase); 
  `uvm_info(get_name, "we are in extract_phase", UVM_LOW)                                       
endfunction

// check phase
function void exhaustive_seq_test::check_phase(uvm_phase phase); 
  `uvm_info(get_name, "we are in check_phase", UVM_LOW)                                         
endfunction

// report phase
function void exhaustive_seq_test::report_phase(uvm_phase phase); 
  `uvm_info(get_name, "we are in report_phase", UVM_LOW)                                        
endfunction

// final phase
function void exhaustive_seq_test::final_phase(uvm_phase phase); 
  `uvm_info(get_name, "we are in final_phase", UVM_LOW)                                         
endfunction

`endif

