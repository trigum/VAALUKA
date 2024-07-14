


/////////////////////////////////////////////////////////////////////////
//  File name     : yapp_packet.sv                                     //
//                                                                     //
//  Description   : This file defines all the signals to be randomized //
//                  and includes the parity calculation method.        //
//                                                                     //
//  version       : 2.0                                                //
/////////////////////////////////////////////////////////////////////////

`ifndef YAPP_PACKET
`define YAPP_PACKET

/////////////////////
//                 //
//  Normal PACKET  //
//                 //
/////////////////////

// yapp_packet class extending uvm_sequence_item
class yapp_packet extends uvm_sequence_item;

  // Static integer for internal parity calculation
  static   bit [7:0]  int_parity;

  // Randomized packet delay
  rand     int        packet_delay;

  // Randomized length of the packet
  rand     bit [5:0]  length;                                           

  // Randomized address field
  rand     bit [1:0]  addr;

  // Randomized payload, which is a dynamic array
  rand     bit [7:0]  payload[];

  // Parity field
  bit [7:0]  parity;

  // Randomized parity type
  rand     parity_t   parity_type;

  // Integer for indexing and header field
  int        k;
  bit [7:0]  header;

  // UVM object utilities macro
  `uvm_object_utils_begin(yapp_packet)

    // Fields to be exposed for UVM
    `uvm_field_int         (length, UVM_ALL_ON | UVM_DEC)
    `uvm_field_int         (addr, UVM_ALL_ON | UVM_DEC)
    `uvm_field_array_int   (payload, UVM_ALL_ON | UVM_BIN)                          
    `uvm_field_int         (parity, UVM_ALL_ON | UVM_BIN)
    `uvm_field_int         (packet_delay, UVM_ALL_ON | UVM_DEC)
    `uvm_field_enum        (parity_t, parity_type, UVM_ALL_ON | UVM_DEC)

  `uvm_object_utils_end

  // Constraint to limit the address value
  constraint add    { soft addr < 3; }                                          

  // Constraint to ensure length is within the specified range
  constraint len    { soft length inside {[1:63]}; }                                          

  // Constraint for parity type distribution
  constraint par_t  { soft parity_type dist { GOOD_PARITY := 5, BAD_PARITY := 1 }; }    
    
  // Constraint to match payload size with length
  constraint payl   { soft payload.size() == length; }                                      
     
  // Constraint to limit packet delay
  constraint pa_d   { soft packet_delay inside {[0:20]}; }                          

  // Constructor function
  extern function new(string name = "yapp_packet");

  // Post-randomize function to calculate parity
  extern function void post_randomize();                                    

  // Function to calculate parity
  extern function bit [7:0] calc_parity();                                    

endclass

  
  // Constructor for yapp_packet
  function yapp_packet::new(string name = "yapp_packet");
    super.new(name);                                                           
  endfunction
  
  // Post-randomize function to calculate parity
  function void yapp_packet::post_randomize();
    bit [7:0] error;
    bit [2:0] l = $urandom;
    if (parity_type == GOOD_PARITY)
    begin
      parity = calc_parity();
      foreach (payload[i])                                                       
        $display("-> %b", payload[i]);
    end
    else
    begin
      error    = calc_parity();
      error[l] = ~error[l];
      parity   = error;
    end
  endfunction
      
  // Function to calculate parity
  function bit [7:0] yapp_packet::calc_parity();
    header[7:2] = length;
    header[1:0] = addr;                                                      
    $display("-> %b", header);
    repeat (8)
    begin
      int_parity[k] = header[k];
      foreach (payload[i])
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

// yapp_short_item class extending yapp_packet
class yapp_short_item extends yapp_packet;
  
  // UVM object utilities macro
  `uvm_object_utils(yapp_short_item)
           
  // Constraint to limit length for short packets
  constraint lent { soft length < 15; }

  // Constraint to avoid a specific address value
  constraint adr  { soft addr != 2; }

  // Constructor function
  extern function new(string name = "yapp_short_item");

endclass

  // Constructor for yapp_short_item
  function yapp_short_item::new(string name = "yapp_short_item");
    super.new(name);
  endfunction

`endif
    
    
          


          

    
    


          

    
    
