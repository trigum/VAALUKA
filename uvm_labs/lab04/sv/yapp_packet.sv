

///////////////////////////////////////////////////////////////////////
//  File name     : yapp_packet.sv                                   //   
//                                                                   //
//  Description   : Definition of yapp_packet class, containing      // 
//                  signals for randomization and parity calculation //
//                                                                   //
//  Notes         : This class includes methods for calculating      //
//                  packet parity and constraints for randomization  //
///////////////////////////////////////////////////////////////////////

`ifndef YAPP_PACKET
`define YAPP_PACKET

//////////////////////
//                  //
//  Normal PACKET   //
//                  //
//////////////////////

class yapp_packet extends uvm_sequence_item;   

  // Static parity array
  static bit [7:0] int_parity;
  
  // Random variables
  rand int packet_delay;
  rand bit [5:0] length;
  rand bit [1:0] address;
  rand bit [7:0] payload[];
  
  // Parity calculation result
  bit [7:0] parity;
  
  // Random enum for parity type
  rand parity_t parity_type;
  
  // Iterator variable
  int k;
  
  // Header for parity calculation
  bit [7:0] header;
    
  `uvm_object_utils_begin(yapp_packet)                                   
    `uvm_field_int(length, UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(address, UVM_ALL_ON | UVM_DEC)
    `uvm_field_array_int(payload, UVM_ALL_ON | UVM_BIN)
    `uvm_field_int(parity, UVM_ALL_ON | UVM_BIN)
    `uvm_field_int(packet_delay, UVM_ALL_ON | UVM_DEC)
    `uvm_field_enum(parity_t, parity_type, UVM_ALL_ON | UVM_DEC)
  `uvm_object_utils_end
    
  // Address constraint
  constraint add {soft address < 3;}                                     
  
  // Length constraint
  constraint len {soft length inside {[1:63]};}                          
     
  // Parity type constraint
  constraint par_t {soft parity_type dist {GOOD_PARITY := 5, BAD_PARITY := 1};}
     
  // Payload size constraint
  constraint payl {soft payload.size() == length;}                       
  
  // Packet delay constraint
  constraint pa_d {soft packet_delay inside {[0:20]};}                   
 
  // Constructor
  extern function new(string name = "yapp_packet");                      
 
  // Post randomization method
  extern function void post_randomize();                                 
  
  // Parity calculation method
  extern function bit [7:0] calc_parity();                               
   
     
endclass

// Constructor implementation for yapp_packet
function yapp_packet::new(string name = "yapp_packet");
  super.new(name);                                                      
endfunction
  
// Post randomization method implementation
function void yapp_packet::post_randomize();
  bit [7:0] error;
  bit [2:0] l = $urandom;
  if (parity_type == GOOD_PARITY) begin
    parity = calc_parity();
    foreach (payload[i]) begin
      $display("-> %b", payload[i]);
    end
  end
  else begin
    error = calc_parity();
    error[l] = ~error[l];
    parity = error;
  end
endfunction
      
// Parity calculation method implementation
function bit [7:0] yapp_packet::calc_parity();
  header[7:2] = length;
  header[1:0] = address;                                                
  $display("-> %b", header);
  repeat (8) begin
    int_parity[k] = header[k];
    foreach (payload[i]) begin
      int_parity[k] = int_parity[k] ^ payload[i][k];
    end
    k++;
  end	
  return int_parity;
endfunction


//////////////////////
//                  //
//  SHORT PACKET    //
//                  //
//////////////////////

class yapp_short_item extends yapp_packet;
  
  `uvm_object_utils(yapp_short_item)
           
  // Length constraint for short packets
  constraint lent {soft length < 15;}
  
  // Address constraint for short packets
  constraint adr {soft address != 2;}

  // Constructor
  extern function new(string name = "yapp_short_item");

endclass


// Constructor implementation for yapp_short_item
function yapp_short_item::new(string name = "yapp_short_item");
  super.new(name);
endfunction

`endif
    
