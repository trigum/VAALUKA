

///////////////////////////////////////////////////////////////////////
//  File name     : yapp_packet.sv                                   //
//                                                                   //
//  Description   : this file have all the signals to be randomized  //
//                                                                   //
//  version       : 02                                               //
///////////////////////////////////////////////////////////////////////

`ifndef YAPP_PACKET
`define YAPP_PACKET

/////////////////////
//                 //
//  yapp PACKET    //
//                 //
/////////////////////

// Sequence_item for router
class yapp_packet extends uvm_sequence_item;

  static bit [7:0]  int_parity;
  rand   int        packet_delay;

  // All properties are declared as rand
  rand   bit [5:0]  length; 
  rand   bit [1:0]  address;
  rand   bit [7:0]  payload[];
         bit [7:0]  parity;
  rand   parity_t   parity_type;
         int        k;
         bit [7:0]  header;

  // Factory registration
  `uvm_object_utils_begin(yapp_packet)

    // All signals are registered with field macros
    `uvm_field_int         (length, UVM_ALL_ON | UVM_DEC)
    `uvm_field_int         (address, UVM_ALL_ON | UVM_DEC)
    `uvm_field_array_int   (payload, UVM_ALL_ON | UVM_BIN)
    `uvm_field_int         (parity, UVM_ALL_ON | UVM_BIN)
    `uvm_field_int         (packet_delay, UVM_ALL_ON | UVM_DEC)
    `uvm_field_enum        (parity_t, parity_type, UVM_ALL_ON | UVM_DEC)
   
  `uvm_object_utils_end

  // Constraint to restrict address < 3
  constraint add {soft address < 3;}

  // Max payload length is 64
  constraint len {soft length inside {[1:63]};}

  // Create good and bad parity in ratio of 5:1
  constraint par_t {soft parity_type dist {GOOD_PARITY := 5, BAD_PARITY := 1};}

  // Payload size should be equal to length
  constraint payl {soft payload.size() == length;}

  // Packet delay between 0 - 20
  constraint pa_d {soft packet_delay inside {[0:20]};}

  // Extern constructor
  extern function new(string name = "yapp_packet");

  // Extern post randomization
  extern function void post_randomize();

  // Extern calc_parity
  extern function bit [7:0] calc_parity();
     
endclass

  // Constructor
  function yapp_packet::new(string name = "yapp_packet");
    super.new(name);
  endfunction
  
  // Post randomize function to calculate parity
  function void yapp_packet::post_randomize();
    bit [7:0] error;
    bit [2:0] l = $urandom;
    if (parity_type == GOOD_PARITY) begin
      parity = calc_parity();
      foreach (payload[i])
        $display("-> %b", payload[i]);
    end else begin
      error    = calc_parity();
      error[l] = ~error[l];
      parity   = error;
    end
  endfunction
      
  // Function to calculate parity
  function bit [7:0] yapp_packet::calc_parity();
    header[7:2] = length;
    header[1:0] = address;
    $display("-> %b", header);
    repeat (8) begin
      int_parity[k] = header[k];
      foreach (payload[i])
        int_parity[k] = int_parity[k] ^ payload[i][k];
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
           
  // Constraints for short item
  constraint lent {soft length < 15;}
  constraint adr  {soft address != 2;}

  // Extern constructor
  extern function new(string name = "yapp_short_item");

endclass

  // Constructor
  function yapp_short_item::new(string name = "yapp_short_item");
    super.new(name);
  endfunction

`endif
    
    
          

    
    
