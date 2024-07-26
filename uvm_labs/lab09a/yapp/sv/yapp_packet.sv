

///////////////////////////////////////////////////////////////////////
//  File name     : yapp_packet.sv                                    //
//                                                                    //
//  Description   : This file contains all signals to be randomized   //
//                                                                    //
//  version       : 2.0                                               //
///////////////////////////////////////////////////////////////////////

`ifndef YAPP_PACKET
`define YAPP_PACKET

/////////////////////
//                 //
//  Normal PACKET  //
//                 //
/////////////////////

class yapp_packet extends uvm_sequence_item;                         

  // Static variable for internal parity calculation
  static bit [7:0] int_parity;

  // Randomized variables
  rand int packet_delay;
  rand bit [5:0] length;                                                 
  rand bit [1:0] addr;
  rand bit [7:0] payload[];
  bit [7:0] parity;
  rand parity_t parity_type;
  
  // Non-randomized variables
  int k;
  bit [7:0] header;
    
  `uvm_object_utils_begin(yapp_packet)                               

    // UVM field macros for serialization and randomization
    `uvm_field_int(length, UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(addr, UVM_ALL_ON | UVM_DEC)
    `uvm_field_array_int(payload, UVM_ALL_ON | UVM_BIN)                          
    `uvm_field_int(parity, UVM_ALL_ON | UVM_BIN)
    `uvm_field_int(packet_delay, UVM_ALL_ON | UVM_DEC)
    `uvm_field_enum(parity_t, parity_type, UVM_ALL_ON | UVM_DEC)
   
  `uvm_object_utils_end
    
  // Constraints
  constraint add { soft addr < 3; }                                             
  constraint len { soft length inside {[1:63]}; }                                            
  constraint par_t { soft parity_type dist { GOOD_PARITY := 5, BAD_PARITY := 1 }; }      
  constraint payl { soft payload.size() == length; }                                      
  constraint pa_d { soft packet_delay inside {[0:20]}; }                           
 
  // Constructor
  extern function new(string name = "yapp_packet");                 
 
  // Post-randomize function to calculate parity
  extern function void post_randomize();                                   
   
  // Function to calculate parity
  extern function bit [7:0] calc_parity();                                   
   
endclass

  
// Implementation of the constructor
function yapp_packet::new(string name = "yapp_packet");
  super.new(name);                                                           
endfunction
  
// Implementation of the post-randomize function to calculate parity
function void yapp_packet::post_randomize();
  bit [7:0] error;
  bit [2:0] l = $urandom;
  if (parity_type == GOOD_PARITY) begin
    parity = calc_parity();
    foreach (payload[i])                                                       
      $display("-> %b", payload[i]);
  end
  else begin
    error = calc_parity();
    error[l] = ~error[l];
    parity = error;
  end
endfunction
      
// Implementation of the function to calculate parity
function bit [7:0] yapp_packet::calc_parity();
  header[7:2] = length;
  header[1:0] = addr;                                                      
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

/////////////////////
//                 //
//  SHORT PACKET   //
//                 //
/////////////////////

class yapp_short_item extends yapp_packet;
  
  `uvm_object_utils(yapp_short_item)
           
  // Constraints for short packets
  constraint lent { soft length < 15; }
  constraint adr  { soft addr != 2; }

  // Constructor
  extern function new(string name = "yapp_short_item");

endclass

// Implementation of the constructor
function yapp_short_item::new(string name = "yapp_short_item");
  super.new(name);
endfunction

`endif
    
    

          

    
    


          

    
    

          

    
    

          

    
    
