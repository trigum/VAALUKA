
///////////////////////////////////////////////////////////////////////
//  File name     : yapp_packet.sv                                   //
//                                                                   //
//  Description   : this file have all the signals to be randomized  //
//                                                                   //
//  Notes         : it have the parity calculation method            //
///////////////////////////////////////////////////////////////////////

`ifndef YAPP_PACKET
`define YAPP_PACKET

/////////////////////
//                 //
//  Normal PACKET  //
//                 //
/////////////////////


class yapp_packet extends uvm_sequence_item;                             // sequence_item for router

  static   bit [7:0]  int_parity;
  rand     int        packet_delay;
  rand     bit [5:0]  length;                                                   // all properties are declared as rand
  rand     bit [1:0]  addr;
  rand     bit [7:0]  payload[];
           bit [7:0]  parity;
  rand     parity_t   parity_type;
           int        k;
           bit [7:0]  header;
	   
    
  `uvm_object_utils_begin(yapp_packet)                                   // factory registration

    `uvm_field_int         (length,UVM_ALL_ON |UVM_DEC)
    `uvm_field_int         (addr,UVM_ALL_ON |UVM_DEC)
    `uvm_field_array_int   (payload,UVM_ALL_ON |UVM_BIN)                          // all signals are register with field macros
    `uvm_field_int         (parity,UVM_ALL_ON |UVM_BIN)
    `uvm_field_int         (packet_delay,UVM_ALL_ON |UVM_DEC)
    `uvm_field_enum        (parity_t,parity_type,UVM_ALL_ON |UVM_DEC)
   
  `uvm_object_utils_end
    
  constraint add    {soft addr < 3;}                                              // constraint to restrict address == 4
     
  constraint len    {soft length inside {[1:63]};}                                              // max payload length is 64
     
  constraint par_t  {soft parity_type dist {GOOD_PARITY := 5,BAD_PARITY := 1};}      // create good and bad parity in ratio of 5:1
     
  constraint payl   {soft payload.size() == length;}                                      // payload size should be equal to length
     
  constraint pa_d   {soft packet_delay inside{[0:20]};}                              // packet delay between 0 - 20
 
  extern function new(string name = "yapp_packet");                      // extern constructor
 
  extern function void post_randomize();                                        // extern post randomization

  extern function bit [7:0] calc_parity();                                        // extern calc_property
   
     
endclass

  
  // constructor

  function yapp_packet::new(string name = "yapp_packet");
    super.new(name);                                                           
  endfunction
  
  // post randomize function to calculate parity

  function void yapp_packet::post_randomize();
    bit [7:0] error;
    bit [2:0] l = $urandom;
    if(parity_type == GOOD_PARITY)
    begin
      parity = calc_parity();
      foreach(payload[i])                                                       
        $display("-> %b",payload[i]);
    end
    else
    begin
      error    = calc_parity();
      error[l] = ~error[l];
      parity   = error;
    end
  endfunction
      
  // function to calculate parity

  function bit [7:0] yapp_packet::calc_parity();
    header[7:2] = length;
    header[1:0] = addr;                                                      
    $display("-> %b",header);
    repeat(8)
    begin
      int_parity[k] = header[k];
      foreach(payload[i])
      begin
        int_parity[k] = int_parity[k] ^ payload[i][k];
      end
      k++;
    end	
    return int_parity;
  endfunction



    
    

/////////////////////
//                 //
//  SHORT PACKET   //
//                 //
/////////////////////


class yapp_short_item extends yapp_packet;
  
  `uvm_object_utils(yapp_short_item)
           
  constraint lent {soft length < 15;}

  constraint adr  {soft addr != 2;}

  extern function new(string name = "yapp_short_item");

endclass

  // constructor

  function yapp_short_item::new(string name = "yapp_short_item");
    super.new(name);
  endfunction

`endif
    
    
          

    
    


          

    
    

          

    
    

          

    
    

          

    
    
          

    
    
