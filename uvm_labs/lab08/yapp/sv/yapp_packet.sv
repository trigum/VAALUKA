

///////////////////////////////////////////////////////////////////////
//  File name     : yapp_packet.sv                                   //
//                                                                   //
//  Description   : this file have all the signals to be randomized  //
//                                                                   //
//  version       : 2.0                                              //
///////////////////////////////////////////////////////////////////////

`ifndef YAPP_PACKET
`define YAPP_PACKET

/////////////////////
//                 //
//  Normal PACKET  //
//                 //
/////////////////////

class yapp_packet extends uvm_sequence_item;

  // Static bit field to store intermediate parity calculations
  static bit [7:0] int_parity;
  
  // Randomized delay for the packet
  rand int packet_delay;
  
  // Randomized packet length
  rand bit [5:0] length;
  
  // Randomized address field
  rand bit [1:0] addr;
  
  // Randomized payload data
  rand bit [7:0] payload[];
  
  // Parity value
  bit [7:0] parity;
  
  // Randomized parity type (GOOD_PARITY or BAD_PARITY)
  rand parity_t parity_type;
  
  // Loop index for parity calculation
  int k;
  
  // Packet header
  bit [7:0] header;

  // UVM macros to provide factory and field macros
  `uvm_object_utils_begin(yapp_packet)
    `uvm_field_int (length, UVM_ALL_ON | UVM_DEC)
    `uvm_field_int (addr, UVM_ALL_ON | UVM_DEC)
    `uvm_field_array_int (payload, UVM_ALL_ON | UVM_BIN)
    `uvm_field_int (parity, UVM_ALL_ON | UVM_BIN)
    `uvm_field_int (packet_delay, UVM_ALL_ON | UVM_DEC)
    `uvm_field_enum (parity_t, parity_type, UVM_ALL_ON | UVM_DEC)
  `uvm_object_utils_end

  // Address constraint: addr should be less than 3
  constraint add { soft addr < 3; }
  
  // Length constraint: length should be between 1 and 63
  constraint len { soft length inside {[1:63]}; }
  
  // Parity type distribution: GOOD_PARITY more likely than BAD_PARITY
  constraint par_t { soft parity_type dist {GOOD_PARITY := 5, BAD_PARITY := 1}; }
  
  // Payload size constraint: payload size should match the length
  constraint payl { soft payload.size() == length; }
  
  // Packet delay constraint: delay should be between 0 and 20
  constraint pa_d { soft packet_delay inside {[0:20]}; }

  // Constructor declaration
  extern function new(string name = "yapp_packet");

  // Function to perform actions after randomization
  extern function void post_randomize();

  // Function to calculate parity
  extern function bit [7:0] calc_parity();

endclass

  // Constructor implementation
  function yapp_packet::new(string name = "yapp_packet");
    // Call the base class constructor
    super.new(name);
  endfunction

  // Post-randomize function implementation
  function void yapp_packet::post_randomize();
    bit [7:0] error;
    bit [2:0] l = $urandom;

    // Calculate parity based on the type
    if (parity_type == GOOD_PARITY) begin
      parity = calc_parity();
      foreach (payload[i])                                                       
        $display("-> %b", payload[i]);
    end else begin
      error = calc_parity();
      error[l] = ~error[l];
      parity = error;
    end
  endfunction

  // Parity calculation function implementation
  function bit [7:0] yapp_packet::calc_parity();
    // Set header with length and address
    header[7:2] = length;
    header[1:0] = addr;                                                      
    $display("-> %b", header);

    // Calculate parity for header and payload
    repeat(8) begin
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

  // UVM macro for object utilities
  `uvm_object_utils(yapp_short_item)
  
  // Constraint: length should be less than 5
  constraint lent { soft length < 5; }
  
  // Constraint: address should not be 2
  constraint adr { soft addr != 2; }

  // Constructor declaration
  extern function new(string name = "yapp_short_item");

endclass

  // Constructor implementation
  function yapp_short_item::new(string name = "yapp_short_item");
    // Call the base class constructor
    super.new(name);
  endfunction

`endif
    
    
    


          

    
    

          

    
    
