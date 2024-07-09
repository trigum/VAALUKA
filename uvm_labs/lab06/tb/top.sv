
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  File name     : top.sv                                                                                          //
//                                                                                                                  //
//  Description   : This file is the top module for yapp_router which contains all the interface and design         //
//                  instantiation.                                                                                  //
//                                                                                                                  //
//  version       : 02                                                                                              //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

import uvm_pkg::*;                 
`include "uvm_macros.svh"          
`include "../sv/yapp.svh"          
`include "../rtl/yapp_if.sv"       
`include "../rtl/yapp_router.svh"  

module top();

  // Clock signal
  bit i_clk;                 

  // Active high reset signal  
  bit i_rst;                   

  // Error signal, asserted when the parity gets mismatched
  bit error;               

  // Clock generation using blocking assignment
  always
  begin
    i_clk = 0;
    #5;                         
    i_clk = 1;
    #5;
  end

  // Reset generation
  // Initially asserted for 1 cycle and then deasserted
  always
  begin
    repeat (2)
    begin
      i_rst = 1;
      #10;                
    end
    forever 
    begin

      // Deasserting reset for the entire process
      i_rst = 0;
      #5;
    end
  end

  // yapp_interface instantiation
  yapp_if in0 (i_clk, i_rst);         

  // Design instantiation
  // Connecting the design and testbench
  yapp_router DUT (
    .clock(i_clk),	           
    .reset(i_rst),		   
    .in_data(in0.in_data),		  
    .in_data_vld(in0.in_data_vld),      
    .in_suspend(in0.in_suspend),
    .suspend_0(1'b0),
    .suspend_1(1'b0),
    .suspend_2(1'b0)
  ); 

  initial
  begin

    // Interface setting through config db
    yapp_vif_config::set(null, "*", "vif", in0); 

    // Running the test
    run_test();                                      
  end

endmodule

