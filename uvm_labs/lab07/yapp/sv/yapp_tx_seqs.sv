

/*-----------------------------------------------------------------
File name     : yapp_tx_seqs.sv
Description   : this file is to generate stimulus 
Notes         : 
-------------------------------------------------------------------
-----------------------------------------------------------------*/

//------------------------------------------------------------------------------
//
// yapp_tx_seqs
//
//------------------------------------------------------------------------------

//
`ifndef SEQUENCE
`define SEQUENCE

/////////////////////
//                 //
//  base sequence  //
//                 //
/////////////////////

class sequences extends uvm_sequence #(yapp_packet);
  `uvm_object_utils(sequences)
   
  extern function new(string name = "sequences");

  extern task body();
  
endclass

  // constructor 

  function sequences::new(string name = "sequences");
    super.new(name);
  endfunction
    
  // body task

  task sequences::body();
    if(starting_phase!=null)
      starting_phase.raise_objection(this);
    for(int i=0;i<15;i++)
    begin
      req=yapp_packet::type_id::create("req");
      start_item(req);
      req.randomize();
      finish_item(req);
    end
    if(starting_phase!=null)    
      starting_phase.drop_objection(this);
  endtask


/////////////////////
//                 //
// 0_1_2  sequence //
//                 //
/////////////////////

class yapp_012_seq extends sequences;
  `uvm_object_utils(yapp_012_seq)
  
  extern function new(string name="yapp_012_seq");
  
  extern task body();
  
endclass  
  
  // constructor

  function yapp_012_seq::new(string name="yapp_012_seq");
    super.new(name);
  endfunction
  
  // body task

  task yapp_012_seq::body();
    if(starting_phase!=null)
      starting_phase.raise_objection(this);
    `uvm_info("012","",UVM_LOW)
    for(int i=0; i<3;i++)
    begin
      req=yapp_packet::type_id::create("req");
      start_item(req);
      req.randomize()with{addr==i;};
      finish_item(req);
    end
    if(starting_phase!=null)
      starting_phase.drop_objection(this);
  endtask

/////////////////////
//                 //
// 1  sequence     //
//                 //
/////////////////////

class yapp_1_seq extends sequences;
  
  `uvm_object_utils(yapp_1_seq)
 
  extern function new(string name="yapp_1_seq");
  
  extern task body();
  
endclass 

  //constructor

  function yapp_1_seq::new(string name="yapp_1_seq");
    super.new(name);
  endfunction

  // body task

  task yapp_1_seq::body();
    `uvm_info("1","",UVM_LOW)
    if(starting_phase!=null)
      starting_phase.raise_objection(this);
    req=yapp_packet::type_id::create("req");
    start_item(req);
    req.randomize()with{addr==1;};
    finish_item(req);
    if(starting_phase!=null)
      starting_phase.drop_objection(this);
  endtask

///////////////////////////////////////////////
//                                           //
// repeat_with same random address  sequence //
//                                           //
///////////////////////////////////////////////

class yapp_repeat_addr_seq extends sequences;

  `uvm_object_utils(yapp_repeat_addr_seq)
  
  int tem;
  
  extern function new(string name="yapp_repeat_addr_seq");
  
  extern task body();
   
endclass 

  // constructor

  function yapp_repeat_addr_seq::new(string name="yapp_repeat_addr_seq");
    super.new(name);
  endfunction
    
  // body task

  task yapp_repeat_addr_seq::body();
    `uvm_info("yapp_repeat_addr_seq","",UVM_LOW)
    if(starting_phase!=null)
      starting_phase.raise_objection(this);
    req=yapp_packet::type_id::create("req");
    start_item(req);
    req.randomize();
    tem=req.addr;
    finish_item(req);
    start_item(req);
    req.randomize()with{addr==tem;};
    finish_item(req);
    if(starting_phase!=null)
      starting_phase.drop_objection(this);
  endtask


///////////////////////////////////////////////
//                                           //
// payload increment from 0  sequence        //
//                                           //
///////////////////////////////////////////////

class yapp_incr_payload_seq extends sequences;
  `uvm_object_utils(yapp_incr_payload_seq)
  
  extern function new(string name="yapp_incr_payload_seq");
  
  extern task body();
  
endclass  
 
  // constructor
 
  function yapp_incr_payload_seq::new(string name="yapp_incr_payload_seq");
    super.new(name);
  endfunction
  // body task

  task yapp_incr_payload_seq::body();
    `uvm_info("yapp_incr_payload_seq","",UVM_LOW)
    if(starting_phase!=null)	    
      starting_phase.raise_objection(this);
    for(int i=0; i<1;i++)
    begin
      req=yapp_packet::type_id::create("req");
      start_item(req);
      req.randomize()with{foreach(payload[i])
      payload[i]==i;};
      finish_item(req);
    end
    if(starting_phase!=null)	    
      starting_phase.drop_objection(this);
  endtask

///////////////////////////////////////////////
//                                           //
//       1_1_1   address  sequence           //
//                                           //
///////////////////////////////////////////////

class yapp_111_seq extends sequences;
  
  `uvm_object_utils(yapp_111_seq)
  
  yapp_1_seq seq1;

  extern function new(string name="yapp_111_seq");

  extern task body();
 
endclass
  
  // constructor

  function yapp_111_seq::new(string name="yapp_111_seq");
    super.new(name);
  endfunction

  // task body

  task yapp_111_seq::body();
    `uvm_info("111","",UVM_LOW)
    seq1 = yapp_1_seq::type_id::create("seq1");
    repeat(3)
      `uvm_do(seq1)
  endtask



`endif


