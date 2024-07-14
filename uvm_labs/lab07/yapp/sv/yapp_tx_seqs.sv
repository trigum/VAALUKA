

///////////////////////////////////////////////////////
//                                                   //
// File name     : yapp_tx_seqs.sv                   //
//                                                   //
// Description   : this file is to generate stimulus // 
//                                                   //
// Version       : 2.0                               //     
//                                                   //
///////////////////////////////////////////////////////

`ifndef SEQUENCE
`define SEQUENCE

/////////////////////
//                 //
//  Base sequence  //
//                 //
/////////////////////

class sequences extends uvm_sequence #(yapp_packet);
  `uvm_object_utils(sequences)

  // Constructor for sequences class
  extern function new(string name = "sequences");

  // Task to execute the sequence
  extern task body();
  
endclass

  // Constructor definition
  function sequences::new(string name = "sequences");
    super.new(name);
  endfunction

  // Body task definition
  task sequences::body();
    // Raise objection to starting_phase
    if (starting_phase != null)
      starting_phase.raise_objection(this);

    // Generate 15 random packets
    for (int i = 0; i < 15; i++) begin
      req = yapp_packet::type_id::create("req");
      start_item(req);
      req.randomize();
      finish_item(req);
    end

    // Drop objection to starting_phase
    if (starting_phase != null)
      starting_phase.drop_objection(this);
  endtask


/////////////////////
//                 //
// 0_1_2 sequence //
//                 //
/////////////////////

class yapp_012_seq extends sequences;
  `uvm_object_utils(yapp_012_seq)

  // Constructor for yapp_012_seq class
  extern function new(string name = "yapp_012_seq");

  // Task to execute the sequence
  extern task body();
  
endclass

  // Constructor definition
  function yapp_012_seq::new(string name = "yapp_012_seq");
    super.new(name);
  endfunction

  // Body task definition
  task yapp_012_seq::body();
    // Raise objection to starting_phase
    if (starting_phase != null)
      starting_phase.raise_objection(this);

    `uvm_info("012", "", UVM_LOW)

    // Generate 3 packets with addresses 0, 1, 2
    for (int i = 0; i < 3; i++) begin
      req = yapp_packet::type_id::create("req");
      start_item(req);
      req.randomize() with { addr == i; };
      finish_item(req);
    end

    // Drop objection to starting_phase
    if (starting_phase != null)
      starting_phase.drop_objection(this);
  endtask


/////////////////////
//                 //
// 1 sequence     //
//                 //
/////////////////////

class yapp_1_seq extends sequences;
  `uvm_object_utils(yapp_1_seq)

  // Constructor for yapp_1_seq class
  extern function new(string name = "yapp_1_seq");

  // Task to execute the sequence
  extern task body();
  
endclass

  // Constructor definition
  function yapp_1_seq::new(string name = "yapp_1_seq");
    super.new(name);
  endfunction

  // Body task definition
  task yapp_1_seq::body();
    `uvm_info("1", "", UVM_LOW)

    // Raise objection to starting_phase
    if (starting_phase != null)
      starting_phase.raise_objection(this);

    // Generate a packet with address 1
    req = yapp_packet::type_id::create("req");
    start_item(req);
    req.randomize() with { addr == 1; };
    finish_item(req);

    // Drop objection to starting_phase
    if (starting_phase != null)
      starting_phase.drop_objection(this);
  endtask


///////////////////////////////////////////////
//                                           //
// Repeat with same random address sequence //
//                                           //
///////////////////////////////////////////////

class yapp_repeat_addr_seq extends sequences;
  `uvm_object_utils(yapp_repeat_addr_seq)

  // Temporary variable to hold address
  int tem;

  // Constructor for yapp_repeat_addr_seq class
  extern function new(string name = "yapp_repeat_addr_seq");

  // Task to execute the sequence
  extern task body();
  
endclass

  // Constructor definition
  function yapp_repeat_addr_seq::new(string name = "yapp_repeat_addr_seq");
    super.new(name);
  endfunction

  // Body task definition
  task yapp_repeat_addr_seq::body();
    `uvm_info("yapp_repeat_addr_seq", "", UVM_LOW)

    // Raise objection to starting_phase
    if (starting_phase != null)
      starting_phase.raise_objection(this);

    // Generate a packet and repeat with the same address
    req = yapp_packet::type_id::create("req");
    start_item(req);
    req.randomize();
    tem = req.addr;
    finish_item(req);

    start_item(req);
    req.randomize() with { addr == tem; };
    finish_item(req);

    // Drop objection to starting_phase
    if (starting_phase != null)
      starting_phase.drop_objection(this);
  endtask


///////////////////////////////////////////////
//                                           //
// Payload increment from 0 sequence        //
//                                           //
///////////////////////////////////////////////

class yapp_incr_payload_seq extends sequences;
  `uvm_object_utils(yapp_incr_payload_seq)

  // Constructor for yapp_incr_payload_seq class
  extern function new(string name = "yapp_incr_payload_seq");

  // Task to execute the sequence
  extern task body();
  
endclass

  // Constructor definition
  function yapp_incr_payload_seq::new(string name = "yapp_incr_payload_seq");
    super.new(name);
  endfunction

  // Body task definition
  task yapp_incr_payload_seq::body();
    `uvm_info("yapp_incr_payload_seq", "", UVM_LOW)

    // Raise objection to starting_phase
    if (starting_phase != null)
      starting_phase.raise_objection(this);

    // Generate packets with incrementing payload values
    for (int i = 0; i < 1; i++) begin
      req = yapp_packet::type_id::create("req");
      start_item(req);
      req.randomize() with { foreach (payload[i]) payload[i] == i; };
      finish_item(req);
    end

    // Drop objection to starting_phase
    if (starting_phase != null)
      starting_phase.drop_objection(this);
  endtask


///////////////////////////////////////////////
//                                           //
// 1_1_1 address sequence                   //
//                                           //
///////////////////////////////////////////////

class yapp_111_seq extends sequences;
  `uvm_object_utils(yapp_111_seq)

  // Sequence instance
  yapp_1_seq seq1;

  // Constructor for yapp_111_seq class
  extern function new(string name = "yapp_111_seq");

  // Task to execute the sequence
  extern task body();
  
endclass

  // Constructor definition
  function yapp_111_seq::new(string name = "yapp_111_seq");
    super.new(name);
  endfunction

  // Body task definition
  task yapp_111_seq::body();
    `uvm_info("111", "", UVM_LOW)

    // Create and run yapp_1_seq multiple times
    seq1 = yapp_1_seq::type_id::create("seq1");
    repeat(3)
      `uvm_do(seq1)
  endtask

`endif

