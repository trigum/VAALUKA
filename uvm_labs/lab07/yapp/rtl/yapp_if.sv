
////////////////////////////////////////////////////////////////////////
//                                                                    //
// File name     : yapp_if.sv                                         //
//                                                                    //
// Description   : This file defines an interface to connect TB and   //
//                 design                                             //
//                                                                    //
// Version       : 2.0                                                //
//                                                                    //
////////////////////////////////////////////////////////////////////////

interface yapp_if (input bit clock, reset);

  // 8-bit input data
  logic [7:0] in_data;

  // Input data valid signal
  logic in_data_vld;

  // Suspend signal
  logic in_suspend;

  // Error signal
  logic error;

endinterface

