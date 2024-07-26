///////////////////////////////////////////////////////////////////////
//  File name     : router_test_lib                                  //
//                                                                   //
//  Description   : this lib has all test cases                      //
//                                                                   //
//  Version       : 2.0                                              //
///////////////////////////////////////////////////////////////////////

// test_library for yapp_router

`ifndef TEST
`define TEST

/////////////////////
//                 //
//   BASE TEST     //
//                 //
/////////////////////

// Base class for all test cases
class base_test extends uvm_test;

  // Macro to register the component with the factory
  `uvm_component_utils(base_test)

  router_tb rtb;

  uvm_active_passive_enum is_active;

  // Constructor
  extern function new (string name="base_test", uvm_component parent=null);

  // Build phase: setup testbench components
  extern function void build_phase(uvm_phase phase);

  // Connect phase: connect components
  extern function void connect_phase(uvm_phase phase);

  // End of elaboration phase: post-build configuration
  extern function void end_of_elaboration_phase(uvm_phase phase);

  // Start of simulation phase: initialization before run
  extern function void start_of_simulation_phase(uvm_phase phase);

  // Run phase: main test execution
  extern task run_phase(uvm_phase phase);

  // Extract phase: extract data
  extern function void extract_phase(uvm_phase phase);

  // Check phase: check results
  extern function void check_phase(uvm_phase phase);

  // Report phase: report results
  extern function void report_phase(uvm_phase phase);

  // Final phase: cleanup
  extern function void final_phase(uvm_phase phase);

endclass

// Constructor implementation
function base_test::new (string name="base_test", uvm_component parent=null);
  super.new(name, parent);
endfunction

// Build phase implementation
function void base_test::build_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in build_phase", UVM_LOW)
  super.build_phase(phase);
  rtb = router_tb::type_id::create("rtb", this);
endfunction

// Connect phase implementation
function void base_test::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  `uvm_info(get_name, "we are in connect_phase", UVM_LOW)
endfunction

// End of elaboration phase implementation
function void base_test::end_of_elaboration_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in EOE", UVM_LOW)
  uvm_top.print_topology();
endfunction

// Start of simulation phase implementation
function void base_test::start_of_simulation_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in SOS", UVM_LOW)
endfunction

// Run phase implementation
task base_test::run_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in run_phase", UVM_LOW)
  phase.phase_done.set_drain_time(this, 200ns);
endtask

// Extract phase implementation
function void base_test::extract_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in extract_phase", UVM_LOW)
endfunction

// Check phase implementation
function void base_test::check_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in check_phase", UVM_LOW)
endfunction

// Report phase implementation
function void base_test::report_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in report_phase", UVM_LOW)
endfunction

// Final phase implementation
function void base_test::final_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in final_phase", UVM_LOW)
endfunction


/////////////////////
//                 //
// SHORT_PACKET    //
//                 //
/////////////////////

// Test case for short packets
class short_packet_test extends base_test;

  // Macro to register the component with the factory
  `uvm_component_utils(short_packet_test)

  // Constructor
  extern function new(string name ="short_packet_test", uvm_component parent=null);

  // Build phase: setup testbench components
  extern function void build_phase(uvm_phase phase);

  // Connect phase: connect components
  extern function void connect_phase(uvm_phase phase);

  // End of elaboration phase: post-build configuration
  extern function void end_of_elaboration_phase(uvm_phase phase);

  // Start of simulation phase: initialization before run
  extern function void start_of_simulation_phase(uvm_phase phase);

  // Run phase: main test execution
  extern task run_phase(uvm_phase phase);

  // Extract phase: extract data
  extern function void extract_phase(uvm_phase phase);

  // Check phase: check results
  extern function void check_phase(uvm_phase phase);

  // Report phase: report results
  extern function void report_phase(uvm_phase phase);

  // Final phase: cleanup
  extern function void final_phase(uvm_phase phase);

endclass

// Constructor implementation
function short_packet_test::new(string name ="short_packet_test", uvm_component parent=null);
  super.new(name, parent);
endfunction

// Build phase implementation
function void short_packet_test::build_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in build_phase", UVM_LOW)
  set_type_override_by_type(yapp_packet::get_type(), yapp_short_item::get_type());
  set_config_int ("rtb.env.ag", "is_active", UVM_ACTIVE);
  super.build_phase(phase);
endfunction

// Connect phase implementation
function void short_packet_test::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  `uvm_info(get_name, "we are in connect_phase", UVM_LOW)
endfunction

// End of elaboration phase implementation
function void short_packet_test::end_of_elaboration_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in EOE", UVM_LOW)
  uvm_top.print_topology();
endfunction

// Start of simulation phase implementation
function void short_packet_test::start_of_simulation_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in SOS", UVM_LOW)
endfunction

// Run phase implementation
task short_packet_test::run_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in run_phase", UVM_LOW)
  phase.phase_done.set_drain_time(this, 200ns);
endtask

// Extract phase implementation
function void short_packet_test::extract_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in extract_phase", UVM_LOW)
endfunction

// Check phase implementation
function void short_packet_test::check_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in check_phase", UVM_LOW)
endfunction

// Report phase implementation
function void short_packet_test::report_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in report_phase", UVM_LOW)
endfunction

// Final phase implementation
function void short_packet_test::final_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in final_phase", UVM_LOW)
endfunction

/////////////////////
//                 //
//  CONFIG TEST    //
//                 //
/////////////////////

// Test case for configuration settings
class set_config_test extends base_test;

  // Macro to register the component with the factory
  `uvm_component_utils(set_config_test)

  // Constructor
  extern function new(string name ="set_config_test", uvm_component parent=null);

  // Build phase: setup testbench components
  extern function void build_phase(uvm_phase phase);

  // Connect phase: connect components
  extern function void connect_phase(uvm_phase phase);

  // End of elaboration phase: post-build configuration
  extern function void end_of_elaboration_phase(uvm_phase phase);

  // Start of simulation phase: initialization before run
  extern function void start_of_simulation_phase(uvm_phase phase);

  // Run phase: main test execution
  extern task run_phase(uvm_phase phase);

  // Extract phase: extract data
  extern function void extract_phase(uvm_phase phase);

  // Check phase: check results
  extern function void check_phase(uvm_phase phase);

  // Report phase: report results
  extern function void report_phase(uvm_phase phase);

  // Final phase: cleanup
  extern function void final_phase(uvm_phase phase);

endclass

// Constructor implementation
function set_config_test::new(string name ="set_config_test", uvm_component parent=null);
  super.new(name, parent);
endfunction

// Build phase implementation
function void set_config_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
  set_config_int("rtb.env.ag", "is_active", UVM_PASSIVE);
endfunction

// Connect phase implementation
function void set_config_test::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  `uvm_info(get_name, "we are in connect_phase", UVM_LOW)
endfunction

// End of elaboration phase implementation
function void set_config_test::end_of_elaboration_phase(uvm_phase phase);
  uvm_top.print_topology();
endfunction

// Start of simulation phase implementation
function void set_config_test::start_of_simulation_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in SOS", UVM_LOW)
endfunction

// Run phase implementation
task set_config_test::run_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in run_phase", UVM_LOW)
  phase.phase_done.set_drain_time(this, 200ns);
endtask

// Extract phase implementation
function void set_config_test::extract_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in extract_phase", UVM_LOW)
endfunction

// Check phase implementation
function void set_config_test::check_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in check_phase", UVM_LOW)
endfunction

// Report phase implementation
function void set_config_test::report_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in report_phase", UVM_LOW)
endfunction

// Final phase implementation
function void set_config_test::final_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in final_phase", UVM_LOW)
endfunction

///////////////////////
//                   //
// incr_payload test //
//                   //
///////////////////////

class short_incr_payload extends base_test;

  // Register the component with UVM
  `uvm_component_utils(short_incr_payload)
  
  // Constructor declaration
  extern function new(string name = "short_incr_payload", uvm_component parent = null);
  
  // Phases declaration
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
function short_incr_payload::new(string name = "short_incr_payload", uvm_component parent = null);
  super.new(name, parent);
endfunction

// Build phase implementation
function void short_incr_payload::build_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in build_phase", UVM_LOW)      
  set_type_override_by_type(yapp_packet::get_type(), yapp_short_item::get_type());
  uvm_config_wrapper::set(this, "rtb.env.ag.seqr.run_phase", "default_sequence", yapp_incr_payload_seq::type_id::get());
  super.build_phase(phase);
endfunction

// Connect phase implementation
function void short_incr_payload::connect_phase(uvm_phase phase);  
  super.connect_phase(phase);    
  `uvm_info(get_name, "we are in connect_phase", UVM_LOW)
endfunction

// End of elaboration phase implementation
function void short_incr_payload::end_of_elaboration_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in EOE", UVM_LOW)    
  uvm_top.print_topology();
endfunction

// Start of simulation phase implementation
function void short_incr_payload::start_of_simulation_phase(uvm_phase phase);                            
  `uvm_info(get_name, "we are in SOS", UVM_LOW)
endfunction

// Run phase implementation
task short_incr_payload::run_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in run_phase", UVM_LOW)     
  phase.phase_done.set_drain_time(this, 200ns);        
endtask

// Extract phase implementation
function void short_incr_payload::extract_phase(uvm_phase phase); 
  `uvm_info(get_name, "we are in extract_phase", UVM_LOW)                                       
endfunction

// Check phase implementation
function void short_incr_payload::check_phase(uvm_phase phase); 
  `uvm_info(get_name, "we are in check_phase", UVM_LOW)                                         
endfunction

// Report phase implementation
function void short_incr_payload::report_phase(uvm_phase phase); 
  `uvm_info(get_name, "we are in report_phase", UVM_LOW)                                        
endfunction

// Final phase implementation
function void short_incr_payload::final_phase(uvm_phase phase); 
  `uvm_info(get_name, "we are in final_phase", UVM_LOW)     
endfunction

///////////////////////////
//                       //
// sequence_library test //
//                       //
///////////////////////////

class exhaustive_seq_test extends base_test;

  // Register the component with UVM
  `uvm_component_utils(exhaustive_seq_test)
  
  // Member variable
  yapp_seq_lib seq_lib;

  // Constructor declaration
  extern function new(string name = "exhaustive_seq_test", uvm_component parent = null);
  
  // Phases declaration
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
function exhaustive_seq_test::new(string name = "exhaustive_seq_test", uvm_component parent = null);
  super.new(name, parent);
  seq_lib = yapp_seq_lib::type_id::create("seq_lib");
endfunction

// Build phase implementation
function void exhaustive_seq_test::build_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in build_phase", UVM_LOW)     
  super.build_phase(phase);
  seq_lib.selection_mode = UVM_SEQ_LIB_RANDC;
  seq_lib.max_random_count = 5;
  seq_lib.min_random_count = 2;
  void'(seq_lib.randomize());
  set_type_override_by_type(yapp_packet::get_type(), yapp_short_item::get_type);
  uvm_config_db #(uvm_sequence_base)::set(this, "rtb.env.ag.seqr.run_phase", "default_sequence", seq_lib);
endfunction

// Connect phase implementation
function void exhaustive_seq_test::connect_phase(uvm_phase phase);  
  super.connect_phase(phase);    
  `uvm_info(get_name, "we are in connect_phase", UVM_LOW)
endfunction

// End of elaboration phase implementation
function void exhaustive_seq_test::end_of_elaboration_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in EOE", UVM_LOW)    
  seq_lib.print();
  uvm_top.print_topology();
endfunction 

// Start of simulation phase implementation
function void exhaustive_seq_test::start_of_simulation_phase(uvm_phase phase);                            
  `uvm_info(get_name, "we are in SOS", UVM_LOW)
endfunction

// Run phase implementation
task exhaustive_seq_test::run_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in run_phase", UVM_LOW)     
  phase.phase_done.set_drain_time(this, 200ns);    
endtask

// Extract phase implementation
function void exhaustive_seq_test::extract_phase(uvm_phase phase); 
  `uvm_info(get_name, "we are in extract_phase", UVM_LOW)                                       
endfunction

// Check phase implementation
function void exhaustive_seq_test::check_phase(uvm_phase phase); 
  `uvm_info(get_name, "we are in check_phase", UVM_LOW)                                         
endfunction

// Report phase implementation
function void exhaustive_seq_test::report_phase(uvm_phase phase); 
  `uvm_info(get_name, "we are in report_phase", UVM_LOW)                                        
endfunction

// Final phase implementation
function void exhaustive_seq_test::final_phase(uvm_phase phase); 
  `uvm_info(get_name, "we are in final_phase", UVM_LOW)                                         
endfunction

///////////////////////////
//                       //
//   simple_012 test     //
//                       //
///////////////////////////

class simple_test extends base_test;

  // Register the component with UVM
  `uvm_component_utils(simple_test)
    
  // Constructor declaration
  extern function new(string name = "simple_test", uvm_component parent = null);
  
  // Phases declaration
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
function simple_test::new(string name = "simple_test", uvm_component parent = null);
  super.new(name, parent);
endfunction

// Build phase implementation
function void simple_test::build_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in build_phase", UVM_LOW)         
  set_type_override_by_type(yapp_packet::get_type(), yapp_short_item::get_type());
  uvm_config_wrapper::set(this, "rtb.env.ag.seqr.run_phase", "default_sequence", yapp_012_seq::type_id::get());
  uvm_config_wrapper::set(this, "rtb.ch0_env.rx_agent.sequencer.run_phase", "default_sequence", channel_rx_resp_seq::type_id::get());
  uvm_config_wrapper::set(this, "rtb.ch1_env.rx_agent.sequencer.run_phase", "default_sequence", channel_rx_resp_seq::type_id::get());
  uvm_config_wrapper::set(this, "rtb.ch2_env.rx_agent.sequencer.run_phase", "default_sequence", channel_rx_resp_seq::type_id::get());
  super.build_phase(phase);
endfunction

// Connect phase implementation
function void simple_test::connect_phase(uvm_phase phase);  
  super.connect_phase(phase);    
  `uvm_info(get_name, "we are in connect_phase", UVM_LOW)
endfunction

// End of elaboration phase implementation
function void simple_test::end_of_elaboration_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in EOE", UVM_LOW)    
  uvm_top.print_topology();
endfunction 

// Start of simulation phase implementation
function void simple_test::start_of_simulation_phase(uvm_phase phase);                            
  `uvm_info(get_name, "we are in SOS", UVM_LOW)
endfunction

// Run phase implementation
task simple_test::run_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in run_phase", UVM_LOW)     
  phase.phase_done.set_drain_time(this, 200ns);    
endtask

// Extract phase implementation
function void simple_test::extract_phase(uvm_phase phase); 
  `uvm_info(get_name, "we are in extract_phase", UVM_LOW)                                       
endfunction

// Check phase implementation
function void simple_test::check_phase(uvm_phase phase); 
  `uvm_info(get_name, "we are in check_phase", UVM_LOW)                                         
endfunction

// Report phase implementation
function void simple_test::report_phase(uvm_phase phase); 
  `uvm_info(get_name, "we are in report_phase", UVM_LOW)                                        
endfunction

// Final phase implementation
function void simple_test::final_phase(uvm_phase phase); 
  `uvm_info(get_name, "we are in final_phase", UVM_LOW)                                         
endfunction

///////////////////////////////
//                           //
//   virtual_sequence test   //
//                           //
///////////////////////////////

class router_vtest_lib extends base_test;

  // Register the component with UVM
  `uvm_component_utils(router_vtest_lib)

  // Constructor declaration
  extern function new(string name = "router_vtest_lib", uvm_component parent = null);
  
  // Phases declaration
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
function router_vtest_lib::new(string name = "router_vtest_lib", uvm_component parent = null);
  super.new(name, parent);
endfunction

// Build phase implementation
function void router_vtest_lib::build_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in build_phase", UVM_LOW)             
  set_type_override_by_type(yapp_packet::get_type(), yapp_short_item::get_type());
  uvm_config_wrapper::set(this, "rtb.ch0_env.rx_agent.sequencer.run_phase", "default_sequence", channel_rx_resp_seq::type_id::get());
  uvm_config_wrapper::set(this, "rtb.ch1_env.rx_agent.sequencer.run_phase", "default_sequence", channel_rx_resp_seq::type_id::get());
  uvm_config_wrapper::set(this, "rtb.ch2_env.rx_agent.sequencer.run_phase", "default_sequence", channel_rx_resp_seq::type_id::get());
  uvm_config_wrapper::set(this, "rtb.rv_seqr.run_phase", "default_sequence", router_simple_vseq::type_id::get());
  super.build_phase(phase);
endfunction

// Connect phase implementation
function void router_vtest_lib::connect_phase(uvm_phase phase);  
  super.connect_phase(phase);    
  `uvm_info(get_name, "we are in connect_phase", UVM_LOW)
endfunction

// End of elaboration phase implementation
function void router_vtest_lib::end_of_elaboration_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in EOE", UVM_LOW)    
  uvm_top.print_topology();
endfunction 

// Start of simulation phase implementation
function void router_vtest_lib::start_of_simulation_phase(uvm_phase phase);                            
  `uvm_info(get_name, "we are in SOS", UVM_LOW)
endfunction

// Run phase implementation
task router_vtest_lib::run_phase(uvm_phase phase);
  `uvm_info(get_name, "we are in run_phase", UVM_LOW)     
  phase.phase_done.set_drain_time(this, 200ns);    
endtask

// Extract phase implementation
function void router_vtest_lib::extract_phase(uvm_phase phase); 
  `uvm_info(get_name, "we are in extract_phase", UVM_LOW)                                       
endfunction

// Check phase implementation
function void router_vtest_lib::check_phase(uvm_phase phase); 
  `uvm_info(get_name, "we are in check_phase", UVM_LOW)                                         
endfunction

// Report phase implementation
function void router_vtest_lib::report_phase(uvm_phase phase); 
  `uvm_info(get_name, "we are in report_phase", UVM_LOW)  
  $display("total=", total);
  $display("channel 1=", ch0_crt); 
  $display("channel 2=", ch1_crt);  
  $display("channel 3=", ch2_crt);  
endfunction

// Final phase implementation
function void router_vtest_lib::final_phase(uvm_phase phase); 
  `uvm_info(get_name, "we are in final_phase", UVM_LOW)                                         
endfunction

`endif

