

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                  //
//  File name     : top.sv                                                                                          //
//                                                                                                                  //
//  Description   : This file is the top module for yapp_router which includes all the interface and design         //
//                  instantiations.                                                                                 //
//                                                                                                                  //
//  Version       : 2.0                                                                                             //
//                                                                                                                  //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

import uvm_pkg::*;                                     

import hbus_pkg::*;                                     

`include "uvm_macros.svh"                             

`include "../../channel/rtl/channel_if.sv"              

`include "../../hbus/rtl/hbus_if.sv"                   

`include "../sv/yapp.svh"                               

`include "../rtl/yapp_if.sv"                        
 
`include "../rtl/yapp_router.svh"                      

module top();

  // Clock signal declaration 
  bit clock;                                       

  // Reset signal which is active high  
  bit reset;                                       
  
  // Error signal asserted when parity mismatch occurs
  bit error;                                     

  // Clock generation for yapp_router 
  always
  begin
    clock = 0;
    #5;                                             
    clock = 1;
    #5;
  end

  // Active high reset generation which provides reset
  // initially and then holds reset high for a short period
  always
  begin
    reset = 0;

    // Delay to provide space for the driver to detect the posedge of reset
    #1;
    repeat (2)
    begin                                          
      reset = 1;
      #10;
    end
    forever 
    begin

      // After reset, the reset signal should be low for the remainder of the process
      reset = 0;
      #5;
    end
  end

  // yapp_router interface instantiation
  yapp_if in0 (clock, reset);                            

  // Router design instantiation and connection with interfaces
  yapp_router DUT (
    .clock (clock),
    .reset (reset),
    .error (in0.error),
    .in_data (in0.in_data),
    .in_data_vld (in0.in_data_vld),
    .in_suspend (in0.in_suspend),
    .data_0 (ch0_if.data),
    .data_vld_0 (ch0_if.data_vld),
    .suspend_0 (ch0_if.suspend),
    .data_1 (ch1_if.data),               
    .data_vld_1 (ch1_if.data_vld),
    .suspend_1 (ch1_if.suspend),
    .data_2 (ch2_if.data),
    .data_vld_2 (ch2_if.data_vld),
    .suspend_2 (ch2_if.suspend),
    .haddr (h_if.haddr),
    .hdata (h_if.hdata_w),
    .hen (h_if.hen),
    .hwr_rd (h_if.hwr_rd)
  );

  // Channels interface instantiation
  channel_if ch0_if (clock, reset);
  
  channel_if ch1_if (clock, reset);                    
  
  channel_if ch2_if (clock, reset);

  // hbus interface instantiation  
  hbus_if h_if (clock, reset);
  
  initial
  begin

    // Interface setting through config DB
    yapp_vif_config    :: set (null, "uvm_test_top.rtb.env*", "vif", in0);
    
    channel_vif_config :: set (null, "uvm_test_top.rtb.ch0_env*", "vif", ch0_if);
    
    channel_vif_config :: set (null, "uvm_test_top.rtb.ch1_env*", "vif", ch1_if);    
    
    channel_vif_config :: set (null, "uvm_test_top.rtb.ch2_env*", "vif", ch2_if);
    
    hbus_vif_config    :: set (null, "uvm_test_top.rtb.h_env*", "vif", h_if);

    // Calling the testbench phases
    run_test();                                                                  
  end

endmodule

