
///////////////////////////////////////////////////////////////////////
//  File name     : yapp.sv                                          //
//                                                                   //
//  Description   : This file includes all the required files for    //
//                  the YAPP router testbench.                       //
//                                                                   //
//  Notes         : It includes type definitions, configuration      //
//                  database, and various modules.                   //
///////////////////////////////////////////////////////////////////////

`ifndef PACKAGES
`define PACKAGES

  // Define an enumeration to classify packets as having good or bad parity
  typedef enum {GOOD_PARITY, BAD_PARITY} parity_t;

  // Include the sequence item (packet) definition
  `include "yapp_packet.sv"

  // Include the sequence definitions
  `include "yapp_tx_seqs.sv"

  // Include the sequencer definition
  `include "yapp_tx_sequencer.sv"

  // Include the driver definition
  `include "yapp_tx_driver.sv"

  // Include the monitor definition
  `include "yapp_tx_monitor.sv"

  // Include the agent definition
  `include "yapp_tx_agent.sv"

  // Include the environment definition
  `include "yapp_tx_env.sv"

`endif


