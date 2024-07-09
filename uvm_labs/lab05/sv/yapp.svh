///////////////////////////////////////////////////////////////////////
//  File name     : yapp.sv                                          //
//                                                                   //
//  Description   : this file includes all the required files        //
//                                                                   //
//  version       : 02                                               //
///////////////////////////////////////////////////////////////////////

`ifndef PACKAGE
`define PACKAGE

    // Using enum to determine good and bad packet
    typedef enum {GOOD_PARITY, BAD_PARITY} parity_t;

    // Including yapp_packet.sv file
    `include "yapp_packet.sv"

    // Including yapp_tx_seqs.sv file
    `include "yapp_tx_seqs.sv"

    // Including yapp_tx_sequencer.sv file
    `include "yapp_tx_sequencer.sv"

    // Including yapp_tx_driver.sv file
    `include "yapp_tx_driver.sv"

    // Including yapp_tx_monitor.sv file
    `include "yapp_tx_monitor.sv"

    // Including yapp_tx_agent.sv file
    `include "yapp_tx_agent.sv"

    // Including yapp_tx_env.sv file
    `include "yapp_tx_env.sv"

    // Including yapp_seq_lib.sv file
    `include "yapp_seq_lib.sv"

    // Including yapp_test_lib.sv file
    `include "yapp_test_lib.sv"

`endif


