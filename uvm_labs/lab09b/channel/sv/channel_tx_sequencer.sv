/*-----------------------------------------------------------------
File name     : channel_tx_sequencer.sv
Description   : This file declares the sequencer the m.
Notes         : 
-------------------------------------------------------------------
-----------------------------------------------------------------*/

`ifndef CHANNEL_TX_SEQUENCER_SV
`define CHANNEL_TX_SEQUENCER_SV

//------------------------------------------------------------------------------
//
// CLASS: channel_tx_sequencer
//
//------------------------------------------------------------------------------

class channel_tx_sequencer extends uvm_sequencer #(yapp_packet);

  `uvm_component_utils(channel_tx_sequencer)

  // Constructor - required syntax for UVM automation and utilities
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

endclass : channel_tx_sequencer

`endif // CHANNEL_TX_SEQUENCER_SV

