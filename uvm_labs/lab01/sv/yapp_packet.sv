

/*////////////////////////////////////////////////////////////////////////
//  File name     : yapp_packet.sv                                   //
//                                                                   //
//  Description   : this file have all the signals to be randomized  //
//                                                                   //
//  Notes         : it have the parity calculation method            //
///////////////////////////////////////////////////////////////////////

`ifndef YAPP_PACKET
`define YAPP_PACKET


class yapp_packet extends uvm_sequence_item;                             // sequence_item for router

  static   bit [7:0]  int_parity;
  rand     int        packet_delay;
  rand     bit [5:0]  length;                                                   // all properties are declared as rand
  rand     bit [1:0]  address;
  rand     bit [7:0]  payload[];
           bit [7:0]  parity;
  rand     parity_t   parity_type;
           int        k;
    
  `uvm_object_utils_begin(yapp_packet)                                   // factory registration

    `uvm_field_int         (length,UVM_ALL_ON |UVM_DEC)
    `uvm_field_int         (address,UVM_ALL_ON |UVM_DEC)
    `uvm_field_array_int   (payload,UVM_ALL_ON |UVM_BIN)                          // all signals are register with field macros
    `uvm_field_int         (parity,UVM_ALL_ON |UVM_BIN)
    `uvm_field_int         (packet_delay,UVM_ALL_ON |UVM_DEC)
    `uvm_field_enum        (parity_t,parity_type,UVM_ALL_ON |UVM_DEC)
   
  `uvm_object_utils_end
    
  constraint add    {address < 3;}                                              // constraint to restrict address == 4
     
  constraint len    {length inside {[1:63]};}                                              // max payload length is 64
     
  constraint par_t  {parity_type dist {GOOD_PARITY := 5,BAD_PARITY := 1};}      // create good and bad parity in ratio of 5:1
     
  constraint payl   {payload.size() == length;}                                      // payload size should be equal to length
     
  constraint pa_d   {packet_delay inside{[0:20]};}                              // packet delay between 0 - 20
 
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
    bit [7:0] header;
    header[7:2] = length;
    header[1:0] = address;                                                      
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

`endif*/

///////////////////////////////////////////////////////////////////////
//  File name     : yapp_packet.sv                                   //
///////////////////////////////////////////////////////////////////////
//                                                                   //
//  Description   : This file defines a UVM sequence item for        //
//                  packet generation and includes methods for       //
//                  randomization and parity calculation.            //
//                                                                   //
//  Notes         : It has the parity calculation method             //
///////////////////////////////////////////////////////////////////////

`ifndef YAPP_PACKET
`define YAPP_PACKET

// Class definition for yapp_packet extending uvm_sequence_item
class yapp_packet extends uvm_sequence_item;

  // Static variable for parity calculation across instances
  static   bit [7:0]  int_parity;
  
  // Randomized variables for packet characteristics
  rand     int        packet_delay;    
  rand     bit [5:0]  length;          
  rand     bit [1:0]  address;         
  rand     bit [7:0]  payload[];       
           bit [7:0]  parity;          
  rand     parity_t   parity_type;     
           int        k;               
    
  // UVM macro for registering the class with the factory
  `uvm_object_utils_begin(yapp_packet)
  
    // Register fields with UVM
    `uvm_field_int         (length, UVM_ALL_ON | UVM_DEC)
    `uvm_field_int         (address, UVM_ALL_ON | UVM_DEC)
    `uvm_field_array_int   (payload, UVM_ALL_ON | UVM_BIN)
    `uvm_field_int         (parity, UVM_ALL_ON | UVM_BIN)
    `uvm_field_int         (packet_delay, UVM_ALL_ON | UVM_DEC)
    `uvm_field_enum        (parity_t, parity_type, UVM_ALL_ON | UVM_DEC)
    
  `uvm_object_utils_end
    
  // Constraints for the packet fields
  
  // Address should be less than 3
  constraint add    {address < 3;}
     
  // Length of the payload should be between 1 and 63
  constraint len    {length inside {[1:63]};}
     
  // Distribution for parity type: 5 times GOOD_PARITY for every BAD_PARITY
  constraint par_t  {parity_type dist {GOOD_PARITY := 5, BAD_PARITY := 1};}
     
  // Payload size should be equal to the length field
  constraint payl   {payload.size() == length;}
     
  // Packet delay should be between 0 and 20
  constraint pa_d   {packet_delay inside {[0:20]};}
 
  // External declarations for constructor and functions
  extern function new(string name = "yapp_packet");
  extern function void post_randomize();
  extern function bit [7:0] calc_parity();
     
endclass

// Constructor for yapp_packet class
function yapp_packet::new(string name = "yapp_packet");
  super.new(name);
endfunction

// Post-randomize function to calculate parity
function void yapp_packet::post_randomize();
  bit [7:0] error;
  bit [2:0] l = $urandom; 
  if (parity_type == GOOD_PARITY) begin
    parity = calc_parity(); 
    foreach(payload[i])
      $display("-> %b", payload[i]); 
  end else begin
    error    = calc_parity(); 
    error[l] = ~error[l]; 
    parity   = error; 
  end
endfunction
      
// Function to calculate the parity for the packet
function bit [7:0] yapp_packet::calc_parity();
  bit [7:0] header;
  header[7:2] = length; 
  header[1:0] = address; 
  $display("-> %b", header); 
  int_parity = 0; 
  k = 0;
  repeat(8) begin
    int_parity[k] = header[k]; 
    foreach(payload[i])
      int_parity[k] = int_parity[k] ^ payload[i][k]; 
    k++;
  end
  return int_parity; 
endfunction

`endif
    
    
