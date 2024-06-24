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


interface yapp_if (input bit clock,reset);
  
  logic [7:0] in_data;                         // input data
  
  logic in_data_vld;                           // valid signal
  
  logic in_suspend;                            // in suspend
  
  logic error;                                  // error

endinterface


