////////////////////////////////////////////////
//                                            //   
//     file_name : test_lib.sv                //
//                                            // 
//     version   : 1.0                        //
//                                            //
//     notes     : test_lib of AXI            //                                        
//                                            // 
////////////////////////////////////////////////

`ifndef TEST
`define TEST
class base_test extends uvm_test;

  // factory registration
  `uvm_component_utils(base_test)

  // write_agent handle
  environment env;

  write_seq_item t1;
  
  uvm_active_passive_enum is_active;

  extern function new(string name = "base_test",uvm_component parent = null);

  extern function void build_phase(uvm_phase phase);

  extern task run_phase(uvm_phase phase);

  extern function void report_phase(uvm_phase phase);

endclass

  ////////////////////////  CONSTRUCTOR  ///////////////////////////

  function base_test::new(string name = "base_test",uvm_component parent = null);
    super.new(name,parent);
  endfunction

  ///////////////////////  BUILD_PHASE  /////////////////////////////

  function void base_test::build_phase(uvm_phase phase);
    super.build_phase(phase);

    // setting write_agent as active
    set_config_int("env.wa","is_active",UVM_ACTIVE);

    // setting defult sequence
    uvm_config_wrapper::set(this,"env.wa.wseqh.run_phase","default_sequence",write_sequence::type_id::get());

    // creating object for environment
    env = environment::type_id::create("env",this);
    t1 = write_seq_item::type_id::create("t1");
    
  endfunction

  ////////////////////////  RUN PHASE  //////////////////////////////

  task base_test::run_phase(uvm_phase phase);
    
    // print topology
    uvm_top.print_topology();
  endtask

  ////////////////////////  REPORT PHASE ///////////////////////////

  function void base_test::report_phase(uvm_phase phase);

    // printing report
    t1.reports();
  endfunction
  `endif
