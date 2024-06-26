

///////////////////////////////////////////////////////////////////////
//  File name     : yapp_packet.sv                                   //
//                                                                   //
//  Description   : this file have all the signals to be randomized  //
//                                                                   //
//  Notes         : it have the parity calculation method            //
///////////////////////////////////////////////////////////////////////

`ifndef YAPP_PACKET
`define YAPP_PACKET

class yapp_packet extends uvm_sequence_item; 

  // sequence_item for router

  static bit [7:0] int_parity;
  rand int packet_delay;
  rand bit [5:0] length; 
  
  // all properties are declared as rand
  
  rand bit [1:0] address;
  rand bit [7:0] payload[];
  bit [7:0] parity;
  rand parity_t parity_type;
  int k;
    
  `uvm_object_utils_begin(yapp_packet) 
  
  // factory registration

    `uvm_field_int(length, UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(address, UVM_ALL_ON | UVM_DEC)
    `uvm_field_array_int(payload, UVM_ALL_ON | UVM_BIN) 
    
    // all signals are registered with field macros
    
    `uvm_field_int(parity, UVM_ALL_ON | UVM_BIN)
    `uvm_field_int(packet_delay, UVM_ALL_ON | UVM_DEC)
    `uvm_field_enum(parity_t, parity_type, UVM_ALL_ON | UVM_DEC)
   
  `uvm_object_utils_end
    
  // constraint to restrict address == 4
  constraint add {address < 3;} 
     
  // max payload length is 64
  constraint len {length inside {[1:63]};} 
     
  // create good and bad parity in ratio of 5:1
  constraint par_t {parity_type dist {GOOD_PARITY := 5, BAD_PARITY := 1};} 
     
  // payload size should be equal to length
  constraint payl {payload.size() == length;} 
     
  // packet delay between 0 - 20
  constraint pa_d {packet_delay inside {[0:20]};} 
 
  // extern constructor
  extern function new(string name = "yapp_packet"); 
 
  // extern post randomization
  extern function void post_randomize(); 

  // extern calc_property
  extern function bit [7:0] calc_parity(); 
   
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
      $display("-> %b", payload[i]);
  end
  else
  begin
    error = calc_parity();
    error[l] = ~error[l];
    parity = error;
  end
endfunction
      
// function to calculate parity

function bit [7:0] yapp_packet::calc_parity();
  bit [7:0] header;
  header[7:2] = length;
  header[1:0] = address;                                                      
  $display("-> %b", header);
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

`endif

    
    

    
    
