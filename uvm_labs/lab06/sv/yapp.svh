///////////////////////////////////////////////////////////////////////
//  File name     : yapp.sv                                          //
//                                                                   //
//  Description   : This file includes all the required files        //
//                                                                   //
//  version       :  02                                              //
///////////////////////////////////////////////////////////////////////

`ifndef PACKAGES
`define PACKAGES

  // Enum typedef to determine good and bad packet  
  typedef enum { GOOD_PARITY , BAD_PARITY } parity_t;

  // Config db typedef to set interface
  typedef uvm_config_db#(virtual yapp_if) yapp_vif_config;

  // Include yapp_packet.sv file
  `include "yapp_packet.sv"
  
  // Include yapp_tx_seqs.sv file
  `include "yapp_tx_seqs.sv"
 
  // Include yapp_tx_sequencer.sv file
  `include "yapp_tx_sequencer.sv"
  
  // Include yapp_tx_driver.sv file
  `include "yapp_tx_driver.sv"
  
  // Include yapp_tx_monitor.sv file
  `include "yapp_tx_monitor.sv"
  
  // Include yapp_tx_agent.sv file
  `include "yapp_tx_agent.sv"
  
  // Include yapp_tx_env.sv file
  `include "yapp_tx_env.sv"
  
  // Include router_tb.sv file
  `include "router_tb.sv"
  
  // Include yapp_seq_lib.sv file
  `include "yapp_seq_lib.sv"
  
  // Include router_test_lib.sv file
  `include "router_test_lib.sv"

`endif // PACKAGES

