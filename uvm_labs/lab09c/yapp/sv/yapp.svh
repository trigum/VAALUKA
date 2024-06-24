
///////////////////////////////////////////////////////////////////////
//  File name     : yapp.sv                                          //
//                                                                   //
//  Description   : this file includes all the required files        //
//                                                                   //
//  Notes         : it have typedef enum and config db               //
///////////////////////////////////////////////////////////////////////


`ifndef PACKAGES
`define PACKAGES

// we using enum to determine good and bad packet
  typedef enum{GOOD_PARITY,BAD_PARITY}parity_t;

// we using config db typedef to set interface
  typedef uvm_config_db#(virtual yapp_if) yapp_vif_config;
int ch0_crt;

int ch1_crt;

int ch2_crt;

int total;

int noenb;

int drop;

  `include "yapp_packet.sv"
  
  `include "yapp_tx_seqs.sv"
  
  `include "yapp_tx_sequencer.sv"
  
  `include "yapp_tx_driver.sv"
  
  `include "yapp_tx_monitor.sv"
  
  `include "yapp_tx_agent.sv"
  
  `include "yapp_tx_env.sv"
  
  `include "../../channel/sv/channel.svh"
  
  `include "router_virtual_sequencer.sv"

  `include "router_virtual_seqs.sv"
  
  `include "router_scoreboard.sv"
  
  `include "router_reference.sv"
  
  `include "router_module_env.sv"
  
  `include "router_tb.sv"
  
  `include "yapp_seq_lib.sv"
  
  `include "router_test_lib.sv"


`endif

