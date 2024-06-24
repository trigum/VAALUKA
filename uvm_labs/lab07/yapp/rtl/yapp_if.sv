/*-----------------------------------------------------------------
File name     : yapp_if.sv
Description   : this file is interface which connect tb and design
Notes         : 
-------------------------------------------------------------------
-----------------------------------------------------------------*/

//------------------------------------------------------------------------------
//
// yapp interface
//
//------------------------------------------------------------------------------

interface yapp_if (input bit clock,reset);   // input clock and reset
  
  logic [7:0] in_data;                       // input data
  
  logic in_data_vld;                         // data valid
  
  logic in_suspend;                          // suspend
  
  logic error;                                // error signal
 
endinterface

