///////////////////////////////////////////////////////////////////////
//  File name     : yapp_test_lib.sv                                 //
//                                                                   //
//  Description   : This file defines the base test class for        //
//                  creating the environment and starting the        //
//                  respective sequence in a UVM-based verification  //
//                  environment.                                     //
//                                                                   //
//  version        : 02                                              //
///////////////////////////////////////////////////////////////////////

`ifndef TEST
`define TEST

//////////////////////
//                  //
//    BASE TEST     //
//                  //
//////////////////////

class base_test extends uvm_test;
  
  `uvm_component_utils(base_test)
  
  // Test environment instance
  environment env;
  
  // Active/passive test configuration
  uvm_active_passive_enum is_active;
  
  // Constructor
  extern function new(string name = "base_test", uvm_component parent = null);
   
  // Phases
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


// Constructor for base_test
function base_test::new(string name = "base_test", uvm_component parent = null);
  super.new(name, parent);
endfunction

// build_phase: Sets up the test environment and configurations
function void base_test::build_phase(uvm_phase phase);
  `uvm_info(get_name, "Entered build_phase", UVM_LOW)      
  
  // Configure sequence
  uvm_config_wrapper::set(this, "env.ag.seqr.run_phase", "default_sequence", sequences::type_id::get());
  
  // Call super class build phase
  super.build_phase(phase);
  
  // Create environment instance
  env = environment::type_id::create("env", this);
endfunction

// connect_phase: Handles connections and setup after build phase
function void base_test::connect_phase(uvm_phase phase);  
  super.connect_phase(phase);    
  `uvm_info(get_name, "Entered connect_phase", UVM_LOW)
endfunction

// end_of_elaboration_phase: Final setup before simulation starts
function void base_test::end_of_elaboration_phase(uvm_phase phase);
  `uvm_info(get_name, "Entered end_of_elaboration_phase", UVM_LOW)    
  
  // Print UVM topology
  uvm_top.print_topology();
endfunction 

// start_of_simulation_phase: Initial setup at the start of simulation
function void base_test::start_of_simulation_phase(uvm_phase phase);                            
  `uvm_info(get_name, "Entered start_of_simulation_phase", UVM_LOW)
endfunction

// run_phase: Executes the main test sequence
task base_test::run_phase(uvm_phase phase);
  `uvm_info(get_name, "Entered run_phase", UVM_LOW)                                              
endtask
 
// extract_phase: Performs data extraction tasks
function void base_test::extract_phase(uvm_phase phase); 
  `uvm_info(get_name, "Entered extract_phase", UVM_LOW)                                       
endfunction

// check_phase: Verifies expected results against actual results
function void base_test::check_phase(uvm_phase phase); 
  `uvm_info(get_name, "Entered check_phase", UVM_LOW)                                         
endfunction

// report_phase: Generates test report or summary
function void base_test::report_phase(uvm_phase phase); 
  `uvm_info(get_name, "Entered report_phase", UVM_LOW)                                        
endfunction

// final_phase: Cleanup tasks and final reporting
function void base_test::final_phase(uvm_phase phase); 
  `uvm_info(get_name, "Entered final_phase", UVM_LOW)                                         
endfunction

//////////////////////////
//                      //
//  SHORT PACKET TEST   //
//                      //
//////////////////////////

class short_packet_test extends base_test;
  
  `uvm_component_utils(short_packet_test)
   
  extern function new(string name = "short_packet_test", uvm_component parent = null);
  
  // Phases
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
  


// Constructor for short_packet_test
function short_packet_test::new(string name = "short_packet_test", uvm_component parent = null);
  super.new(name, parent);
endfunction
  
// build_phase: Sets up specific configurations for short packet testing
function void short_packet_test::build_phase(uvm_phase phase);
  `uvm_info(get_name, "Entered build_phase", UVM_LOW)          
  
  // Override packet type
  set_type_override_by_type(yapp_packet::get_type(), yapp_short_item::get_type());
  
  // Set active configuration
  set_config_int("env.ag", "is_active", UVM_ACTIVE);
  
  // Call super class build phase
  super.build_phase(phase);
endfunction
  
// connect_phase: Handles connections and setup after build phase
function void short_packet_test::connect_phase(uvm_phase phase);  
  super.connect_phase(phase);    
  `uvm_info(get_name, "Entered connect_phase", UVM_LOW)
endfunction

// end_of_elaboration_phase: Final setup before simulation starts
function void short_packet_test::end_of_elaboration_phase(uvm_phase phase);
  `uvm_info(get_name, "Entered end_of_elaboration_phase", UVM_LOW)        
  
  // Print UVM topology
  uvm_top.print_topology();
endfunction 

// start_of_simulation_phase: Initial setup at the start of simulation
function void short_packet_test::start_of_simulation_phase(uvm_phase phase);                            
  `uvm_info(get_name, "Entered start_of_simulation_phase", UVM_LOW)
endfunction

// run_phase: Executes the main test sequence
task short_packet_test::run_phase(uvm_phase phase);
  `uvm_info(get_name, "Entered run_phase", UVM_LOW)                                              
endtask
 
// extract_phase: Performs data extraction tasks
function void short_packet_test::extract_phase(uvm_phase phase); 
  `uvm_info(get_name, "Entered extract_phase", UVM_LOW)                                       
endfunction

// check_phase: Verifies expected results against actual results
function void short_packet_test::check_phase(uvm_phase phase); 
  `uvm_info(get_name, "Entered check_phase", UVM_LOW)                                         
endfunction

// report_phase: Generates test report or summary
function void short_packet_test::report_phase(uvm_phase phase); 
  `uvm_info(get_name, "Entered report_phase", UVM_LOW)                                        
endfunction

// final_phase: Cleanup tasks and final reporting
function void short_packet_test::final_phase(uvm_phase phase); 
  `uvm_info(get_name, "Entered final_phase", UVM_LOW)                                         
endfunction

//////////////////////
//                  //
//    SET CONFIG    //
//                  //
//////////////////////

class set_config_test extends base_test;

  `uvm_component_utils(set_config_test)

  extern function new(string name = "set_config_test", uvm_component parent = null);
  
  // Phases
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


// Constructor for set_config_test
function set_config_test::new(string name = "set_config_test", uvm_component parent = null);
  super.new(name, parent);
endfunction
  
// build_phase: Sets up specific configurations for configuration testing
function void set_config_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
  // Set passive configuration
  set_config_int("env.ag", "is_active", UVM_PASSIVE);
endfunction
  
// connect_phase: Handles connections and setup after build phase
function void set_config_test::connect_phase(uvm_phase phase);  
  super.connect_phase(phase);    
  `uvm_info(get_name, "Entered connect_phase", UVM_LOW)
endfunction

// end_of_elaboration_phase: Final setup before simulation starts
function void set_config_test::end_of_elaboration_phase(uvm_phase phase);
  // Print UVM topology
  uvm_top.print_topology();
endfunction 

// start_of_simulation_phase: Initial setup at the start of simulation
function void set_config_test::start_of_simulation_phase(uvm_phase phase);                            
  `uvm_info(get_name, "Entered start_of_simulation_phase", UVM_LOW)
endfunction

// run_phase: Executes the main test sequence
task set_config_test::run_phase(uvm_phase phase);
  `uvm_info(get_name, "Entered run_phase", UVM_LOW)                                              
endtask
 
// extract_phase: Performs data extraction tasks
function void set_config_test::extract_phase(uvm_phase phase); 
  `uvm_info(get_name, "Entered extract_phase", UVM_LOW)                                       
endfunction

// check_phase: Verifies expected results against actual results
function void set_config_test::check_phase(uvm_phase phase); 
  `uvm_info(get_name, "Entered check_phase", UVM_LOW)                                         
endfunction

// report_phase: Generates test report or summary
function void set_config_test::report_phase(uvm_phase phase); 
  `uvm_info(get_name, "Entered report_phase", UVM_LOW)                                        
endfunction

// final_phase: Cleanup tasks and final reporting
function void set_config_test::final_phase(uvm_phase phase); 
  `uvm_info(get_name, "Entered final_phase", UVM_LOW)                                         
endfunction
  
`endif


