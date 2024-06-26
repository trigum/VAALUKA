

`ifndef INTERFACE
`define INTERFACE


import uvm_pkg::*;

    ///////////////////  ENUM DECLARATION TO FIX WRITE OR READ TRANSFER  ///////////

    typedef enum {WRITE,READ,WRITE_READ} type_of_trans_t;

    typedef enum {FIXED,INCR,WRAP} types;

    ///////////////////  PARAMETER VALUES USED BY ALL COMPONENT  ////////////////////   

    // Width of data bus in bits
    parameter DATA_WIDTHS = 32;
    // Width of address bus in bits
    parameter ADDR_WIDTHS = 16;
    // Width of wstrb (width of data bus in words)
    parameter STRB_WIDTHS = (DATA_WIDTHS/8);
    // Width of ID signal
    parameter ID_WIDTHS = 8;
    // Extra pipeline register on output
    parameter PIPELINE_OUTPUTS = 0;
    int j;

    /////////////////  VARIABLE FOR REPORT GENERATION  //////////////////

    int addr; 
   
    int pass;
   
    int fail;

    int no_of_transaction;

    int no_of_incr;
  
    int no_of_fixed;

    int no_of_write;

    int no_of_read;

    int no_of_write_read;

    int no_of_aligned;

    int no_of_unaligned;
     
    /////////////////  INCLUDE ALL REQUIRED FILES  ////////////////

    `include "wrire_seq_item.sv"

    `include "write_sequence.sv"

    `include "write_driver.sv"

    `include "write_monitor.sv"
 
    `include "write_sequencer.sv"
 
    `include "read_monitor.sv"

    `include "write_agent.sv"

    `include "read_agent.sv"

    `include "axi_scoreboard.sv"

    `include "environment.sv"

    `include "test_lib.sv"

`endif
