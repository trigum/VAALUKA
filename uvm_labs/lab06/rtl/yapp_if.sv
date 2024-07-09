


////////////////////////////////////////////////////////////////////////////
//                                                                        //
//  File name     : yapp_if.sv                                            //
//                                                                        //
//  Description   : this file is interface which connect tb and design    //
//                                                                        //
//  version       : 02                                                    // 
//                                                                        //
////////////////////////////////////////////////////////////////////////////

interface yapp_if (input bit i_clk,i_rst);   
  
  // data in signal
  logic [7:0] in_data;                    
  
  // valid signal
  logic in_data_vld;                    
 
  // suspend signal
  logic in_suspend;                   
  
  // error detection signal
  logic error;                        
 
endinterface


