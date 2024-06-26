///////////////////////////////////////////////////////////////////////
//  File name     : yapp.sv                                          //
//                                                                   //
//  Description   : This file includes all the required files        //
//                                                                   //
//  version       : 02                                               //
///////////////////////////////////////////////////////////////////////

`ifndef PACKAGE
`define PACKAGE

// We use enum to determine good and bad packet
typedef enum {GOOD_PARITY , BAD_PARITY} parity_t;

`include "yapp_packet.sv"

`include "yapp_tx_seqs.sv"  

`include "yapp_tx_sequencer.sv"  

`include "yapp_tx_driver.sv" 

`include "yapp_tx_monitor.sv"  

`include "yapp_tx_agent.sv"  

`include "yapp_tx_env.sv"   

`include "yapp_test_lib.sv"       

`endif



