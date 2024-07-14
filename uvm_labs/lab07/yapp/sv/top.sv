
// Top module for yapp_router

import uvm_pkg::*;
import hbus_pkg::*;

`include "uvm_macros.svh"
`include "../../channel/rtl/chaneel_if.sv"
`include "../sv/yapp.svh"
`include "../rtl/yapp_if.sv"
`include "../rtl/yapp_router.svh"

module top();

  // Clock signal declaration
  bit clock;
  
  // Reset signal declaration
  bit reset;
  
  // Error signal declaration
  bit error;

  // Clock generation process
  always
  begin
    clock = 0;
    #5;
    clock = 1;
    #5;
  end

  // Reset signal generation process
  always
  begin
    reset = 0;
    #1;
    repeat (2)
    begin
      reset = 1;
      #10;
    end
    forever 
    begin
      reset = 0;
      #5;
    end
  end

  // Instantiate yapp_if
  yapp_if in0(clock, reset);

  // Instantiate yapp_router with connections to signals
  yapp_router DUT (
    .clock(clock),
    .reset(reset),
    .error(in0.error),
    .in_data(in0.in_data),
    .in_data_vld(in0.in_data_vld),
    .in_suspend(in0.in_suspend),
    .data_0(ch0_if.data),
    .data_vld_0(ch0_if.data_vld),
    .suspend_0(ch0_if.suspend),
    .data_1(ch1_if.data),
    .data_vld_1(ch1_if.data_vld),
    .suspend_1(ch1_if.suspend),
    .data_2(ch2_if.data),
    .data_vld_2(ch2_if.data_vld),
    .suspend_2(ch2_if.suspend),
    .haddr(h_if.haddr),
    .hdata(h_if.hdata_w),
    .hen(h_if.hen),
    .hwr_rd(h_if.hwr_rd)
  );

  // Instantiate channel_if for channels 0, 1, and 2
  channel_if ch0_if(clock, reset);
  channel_if ch1_if(clock, reset);
  channel_if ch2_if(clock, reset);

  // Instantiate hbus_if
  hbus_if h_if(clock, reset);

  // Initial block to configure virtual interfaces and run test
  initial
  begin
    // Configure virtual interface for yapp_if
    yapp_vif_config::set(null, "uvm_test_top.rtb.env*", "vif", in0);

    // Configure virtual interface for channel 0
    channel_vif_config::set(null, "uvm_test_top.rtb.ch0_env*", "vif", ch0_if);

    // Configure virtual interface for channel 1
    channel_vif_config::set(null, "uvm_test_top.rtb.ch1_env*", "vif", ch1_if);

    // Configure virtual interface for channel 2
    channel_vif_config::set(null, "uvm_test_top.rtb.ch2_env*", "vif", ch2_if);

    // Configure virtual interface for hbus_if
    hbus_vif_config::set(null, "uvm_test_top.rtb.h_env*", "vif", h_if);

    // Run the test named "simple_test"
    run_test("simple_test");
  end

endmodule

