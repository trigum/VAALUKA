

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  File name     : top.sv                                                                                          //
//                                                                                                                  //
//  Description   : Top module for yapp_router containing interface and design instantiation                        //
//                                                                                                                  //
//  version       : 02                                                                                              //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

import uvm_pkg::*;                       

`include "uvm_macros.svh"                  

`include "../sv/yapp.svh"                    

module top();
  initial
  begin

    // Calling run_test to start the testbench
    run_test();                               
  end
endmodule

