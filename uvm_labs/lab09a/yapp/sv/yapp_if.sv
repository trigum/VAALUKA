

////////////////////////////////////////////////////////////////////////
//  File name     : yapp_if.sv                                        //
//                                                                    //
//  Description   : this is a interface file                          //
//                                                                    //
//  version       : 2.0                                               //
////////////////////////////////////////////////////////////////////////



`ifndef INTERFACE
`define INTERFACE

  // Interface definition for yapp_if
  interface yapp_if (input bit clock, reset);
  
    // Data input signal (8-bit)
    logic [7:0] in_data;
  
    // Valid signal for data input
    logic in_data_vld;
  
    // Suspend signal
    logic in_suspend;
  
    // Error signal
    logic error;

  endinterface

`endif

