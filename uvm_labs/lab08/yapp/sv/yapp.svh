///////////////////////////////////////////////////////////////////////
//  File name     : yapp.sv                                          //
//                                                                   //
//  Description   : this file includes all the required files        //
//                                                                   //
//  version       : 2.0                                              //
///////////////////////////////////////////////////////////////////////

`ifndef PACKAGES
`define PACKAGES

    // we using enum to determine good and bad packet
    typedef enum{GOOD_PARITY,BAD_PARITY}parity_t;

    // we using config db typedef to set interface
    typedef uvm_config_db #(virtual yapp_if) yapp_vif_config;

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

    `include "router_tb.sv"

    `include "yapp_seq_lib.sv"

    `include "router_test_lib.sv"

`endif
