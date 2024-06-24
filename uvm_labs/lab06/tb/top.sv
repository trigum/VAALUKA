

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

`include "../rtl/yapp_if.sv"       

`include "../rtl/yapp_router.svh"  

module top();

// clock signal
  bit i_clk;                 

// active high reset signal  
  bit i_rst;                   
  
// error which asserted when the parity get mismatch
  bit error;               

// clock generation with using blocking  
  always
  begin
    i_clk = 0;
    #5;                           
    i_clk = 1;
    #5;
  end

// reset generation
// which initial asserted for 1 cycle and deasserted rest 
  always
  begin
    repeat (2)
    begin
      i_rst = 1;
      #10;                 
    end
    forever 
    begin

// deasserting for entire process
      i_rst = 0;
      #5;
    end
  end

// yapp_interface instantiation
  yapp_if in0 (i_clk,i_rst);         

// design instantiation
// which connect design and tb  
  yapp_router DUT (.clock(i_clk),	           
	           .reset(i_rst),		   
		   .in_data(in0.in_data),		  
		   .in_data_vld(in0.in_data_vld),      
		   .in_suspend(in0.in_suspend),
		   .suspend_0(1'b0),
		   .suspend_1(1'b0),
		   .suspend_2(1'b0)); 

  initial
  begin

// interface setting through config db
    yapp_vif_config::set (null,"*","vif",in0);          
    run_test();                                      
  end
endmodule 	
