
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

// enum for generating good and bad packet
typedef enum{GOOD_PARITY,BAD_PARITY}parity_t;

`include "../sv/yapp_packet.sv"              

module top();

// sequence item handle declaration
  yapp_packet t1;                      
  
  initial

// generating 10 packets
  repeat(10)
  begin
// randomize and display the packet if not raise fatal
    t1 = yapp_packet::type_id::create("t1");  
    if(!t1.randomize())
      `uvm_fatal("t1 is not randomized","TOP")     
    else  
	
// printing of randomized packet  
      t1.print();
  end                                           

endmodule
