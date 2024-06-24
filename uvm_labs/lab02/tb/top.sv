
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  File name     : top.sv                                                                                          //
//                                                                                                                  //
//  Description   : this file is top module for yapp_router which have all the interface and design instatiation    //
//                                                                                                                  //
//                                                                                                                  //
//  Notes         : it going to start the tb phases                                                                 //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

import uvm_pkg::*;                                                                                 

`include "uvm_macros.svh"                                                                         

`include "../sv/yapp.svh"                                                                               

module top();

// environment handle declaration
  environment env;                                                                                
  
  initial
  begin 
    env = environment::type_id::create("env",null);                                          
  end
  
  initial
  begin

// setting a default sequence
    uvm_config_wrapper :: set(null,"env.ag.seqr.run_phase","default_sequence",sequences::type_id::get());  
   
// this delay to give space to driver to see the posedge of reset
 run_test();                                                                                      
  end

endmodule 	
