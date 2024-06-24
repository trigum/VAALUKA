/*-----------------------------------------------------------------
File name     : channel_resp.sv
Description   :  This file declares the UVC packet. It is
              :  used by both rx and tx.
Notes         :
-------------------------------------------------------------------
-----------------------------------------------------------------*/

`ifndef CHANNEL_RESP_SV
`define CHANNEL_RESP_SV

//----------------------------------------------------------------------
// CLASS: channel_resp
//----------------------------------------------------------------------
class channel_resp extends uvm_sequence_item;     
  rand int resp_delay; // #clocks to keep suspend raised

  constraint default_delay { resp_delay >= 0; resp_delay < 8; }

  // UVM macros for built-in automation - These declarations enable automation
  // of the data_item fields and implement create() and get_type_name()
  `uvm_object_utils_begin(channel_resp)
    `uvm_field_int(resp_delay, UVM_ALL_ON | UVM_DEC)
  `uvm_object_utils_end

  // new - constructor
  function new (string name = "channel_resp");
    super.new(name);
  endfunction : new

endclass : channel_resp

`endif // CHANNEL_RESP_SV
