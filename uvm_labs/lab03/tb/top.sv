
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
  
  initial
  begin

// calling all phases and run the base test
    run_test("base_test");             
  end

endmodule 	
