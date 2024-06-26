
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  File name     : top.sv                                                                                          //
//                                                                                                                  //
//  Description   : this file is top module for yapp_router which have all the interface and design instatiation    //
//                                                                                                                  //
//                                                                                                                  //
//  Notes         : it going to start the tb phases                                                                 //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// Importing UVM package
import uvm_pkg::*;                           

// Including UVM macros
`include "uvm_macros.svh"                   

// Including application-specific header file
`include "../sv/yapp.svh"                   

module top();

  // Initial block to start the testbench
  initial
  begin
    // Calling the base test "base_test"
    run_test("base_test");
  end

endmodule

