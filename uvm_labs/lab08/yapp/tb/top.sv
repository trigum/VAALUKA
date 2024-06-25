

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  File name     : top.sv                                                                                          //
//                                                                                                                  //
//  Description   : this file is top module for yapp_router which have all the interface and design instatiation    //
//                                                                                                                  //
//                                                                                                                  //
//  Notes         : it going to start the tb phases                                                                 //
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

// clock signal declaration 
  bit clock; 

// active high reset signal  
  bit reset;                                 

// error which get asserted when parity get mismatch
  bit error;                               

// clock generation using blocking assignment  
  always
  begin
    clock = 0;
    #5;                                     
    clock = 1;
    #5;
  end

// active high reset generation which give reset
// at initial and no reset for rest
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

// yapp interface instantiation
  yapp_if in0 (clock,reset);                      

// design instantiation which connect the router design and interface
  yapp_router DUT (.clock(clock),
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
		   .hwr_rd(h_if.hwr_rd));

// channels interface instantiation
  channel_if ch0_if (clock,reset);
  
  channel_if ch1_if (clock,reset);               
  
  channel_if ch2_if (clock,reset);

// hbus interface instantiation  
  hbus_if    h_if   (clock,reset);

  initial
  begin

// setting all the interface using config db
    yapp_vif_config    :: set(null,"uvm_test_top.rtb.env*","vif",in0);
    
    channel_vif_config :: set(null,"uvm_test_top.rtb.ch0_env*","vif",ch0_if);
    
    channel_vif_config :: set(null,"uvm_test_top.rtb.ch1_env*","vif",ch1_if);             
    
    channel_vif_config :: set(null,"uvm_test_top.rtb.ch2_env*","vif",ch2_if);
    
    hbus_vif_config    :: set(null,"uvm_test_top.rtb.h_env*","vif",h_if);

// start the respective test and all phases    
    run_test("simple_test");
  end
endmodule 	