

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  File name     : top.sv                                                                                              //
//                                                                                                                      //
//  Description   : This file is the top module for yapp_router, containing all the interfaces and design instantiation.//
//                                                                                                                      //
//  Notes         : This module initiates the testbench phases for packet generation and verification.                  //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

import uvm_pkg::*;

`include "uvm_macros.svh"

// Enumeration for generating packets with good and bad parity
typedef enum {GOOD_PARITY, BAD_PARITY} parity_t;

`include "../sv/yapp_packet.sv"

module top();

  // Declare a handle for the sequence item (packet)
  yapp_packet t1;

  initial

    // Generate and randomize 10 packets
    repeat (10) begin

      // Create a new instance of the yapp_packet
      t1 = yapp_packet::type_id::create("t1");

      // Randomize the packet and check if randomization is successful
      if (!t1.randomize())
        
        // If randomization fails, raise a fatal error
        `uvm_fatal("t1 is not randomized", "TOP")
      else

        // If randomization is successful, print the details of the packet
        t1.print();
    end

endmodule

