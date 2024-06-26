/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  File name     : top.sv                                                                                             //
//                                                                                                                     //
//  Description   : This file is the top module for yapp_router, which contains all interface and design instantiation.//
//                                                                                                                     //
//  version       : 02                                                                                                 //
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

import uvm_pkg::*;                                                                                 

`include "uvm_macros.svh"                                                                         

`include "../sv/yapp.svh"                                                                               

module top();

  // Environment handle declaration
  environment env;                                                                                
  
  initial
  begin 
    env = environment::type_id::create("env", null);                                          
  end
  
  initial
  begin
    // Setting a default sequence
    uvm_config_wrapper::set(null, "env.ag.seqr.run_phase", "default_sequence", sequences::type_id::get());  
   
    // This delay creates space for the driver to see the posedge of reset
    run_test();                                                                                      
  end

endmodule

