
    
///////////////////////////////////////////////////////////////////////
//  File name     : yapp_packet.sv                                   //
//                                                                   //
//  Description   : This file contains all the signals to be         //
//                  randomized for the yapp_packet sequence item.    //
//                                                                   //
//  version       : 02                                               //
///////////////////////////////////////////////////////////////////////

`ifndef YAPP_PACKET
`define YAPP_PACKET

// Class definition for the yapp_packet sequence item
class yapp_packet extends uvm_sequence_item;

  // Internal parity calculation storage
  static bit [7:0]  int_parity;
  
  // Random packet delay
  rand int packet_delay;
  
  // Random length of the packet
  rand bit [5:0] length;
  
  // Random address
  rand bit [1:0] address;
  
  // Random payload
  rand bit [7:0] payload[];
  
  // Calculated parity
  bit [7:0] parity;
  
  // Random parity type (good/bad)
  rand parity_t parity_type;
  
  // Loop variable for parity calculation
  int k;
  
  // Factory registration
  `uvm_object_utils_begin(yapp_packet)
    `uvm_field_int         (length, UVM_ALL_ON | UVM_DEC)
    `uvm_field_int         (address, UVM_ALL_ON | UVM_DEC)
    `uvm_field_array_int   (payload, UVM_ALL_ON | UVM_BIN)
    `uvm_field_int         (parity, UVM_ALL_ON | UVM_BIN)
    `uvm_field_int         (packet_delay, UVM_ALL_ON | UVM_DEC)
    `uvm_field_enum        (parity_t, parity_type, UVM_ALL_ON | UVM_DEC)
  `uvm_object_utils_end
  
  // Constraint to restrict the address range to less than 3
  constraint add { address < 3; }
  
  // Constraint to restrict the length of the payload to a maximum of 64
  constraint len { length inside {[1:63]}; }
  
  // Constraint to create good and bad parity in a ratio of 5:1
  constraint par_t { parity_type dist {GOOD_PARITY := 5, BAD_PARITY := 1}; }
  
  // Constraint to ensure the payload size matches the length
  constraint payl { payload.size() == length; }
  
  // Constraint to restrict packet delay between 0 and 20
  constraint pa_d { packet_delay inside {[0:20]}; }

  // Extern constructor
  extern function new(string name = "yapp_packet");

  // Extern post-randomize function
  extern function void post_randomize();

  // Extern parity calculation function
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
  if (parity_type == GOOD_PARITY) begin
    parity = calc_parity();
    foreach (payload[i]) $display("-> %b", payload[i]);
  end else begin
    error = calc_parity();
    error[l] = ~error[l];
    parity = error;
  end
endfunction

// Function to calculate parity
function bit [7:0] yapp_packet::calc_parity();
  bit [7:0] header;
  header[7:2] = length;
  header[1:0] = address;
  $display("-> %b", header);
  repeat (8) begin
    int_parity[k] = header[k];
    foreach (payload[i]) int_parity[k] = int_parity[k] ^ payload[i][k];
    k++;
  end
  return int_parity;
endfunction

`endif

    
    
