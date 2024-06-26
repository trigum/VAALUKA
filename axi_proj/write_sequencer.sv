////////////////////////////////////////////////
//                                            //   
//     file_name : write_sequencer.sv         //
//                                            // 
//     version   : 1.0                        //
//                                            //
//     notes     : sequencer of AXI           //                                        
//                                            // 
////////////////////////////////////////////////

`ifndef WRITE_SEQUENCER
`define WRITE_SEQUENCER

class write_sequencer extends uvm_sequencer#(write_seq_item);

  // factory registration
  `uvm_component_utils(write_sequencer)

  extern function new(string name = "write_sequencer",uvm_component parent = null);

endclass

  ////////////////////////  CONSTRUCTOR  //////////////////////////
  
  function write_sequencer::new(string name = "write_sequencer",uvm_component parent = null);
    super.new(name,parent);
  endfunction

  `endif
