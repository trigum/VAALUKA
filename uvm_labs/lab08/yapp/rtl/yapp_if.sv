///////////////////////////////////////////////////////////
//                                                       //
// File name     : yapp_if.sv                            //
//                                                       //
// Description   : interface                             //
//                                                       //
// version       : 2.0                                   //
//                                                       //
///////////////////////////////////////////////////////////


interface yapp_if (input bit clock,reset);
  
  // data_in
  logic [7:0] in_data;                    
  
  // valid signal
  logic in_data_vld;                        
  
  // suspend signal
  logic in_suspend;                          
  
  // error signal
  logic error;                            

endinterface


