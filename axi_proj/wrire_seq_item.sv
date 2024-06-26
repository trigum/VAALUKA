////////////////////////////////////////////////
//                                            //   
//     file_name : write_seq_item.sv          //
//                                            // 
//     version   : 1.0                        //
//                                            //
//     notes     : write_seq_item of AXI      //                                        
//                                            // 
////////////////////////////////////////////////

`ifndef SEQ_ITEM
`define SEQ_ITEM

class write_seq_item extends uvm_sequence_item;

  // factory registration

  extern function new(string name = "write_seq_item");

  extern function reports();


  // write address channel
  randc bit [ID_WIDTHS-1:0]    s_axi_awid;
  randc bit [ADDR_WIDTHS-1:0]  s_axi_awaddr;
  randc bit [7:0]              s_axi_awlen;
  randc bit [2:0]              s_axi_awsize;
  randc bit [1:0]              s_axi_awburst;
  randc bit                    s_axi_awlock;
  randc bit [3:0]              s_axi_awcache;
  randc bit [2:0]              s_axi_awprot;
  randc bit                    s_axi_awvalid;
        bit                    s_axi_awready;

  // write data channel	
  randc bit [DATA_WIDTHS-1:0]  s_axi_wdata[];
  randc bit [STRB_WIDTHS-1:0]  s_axi_wstrb[];
  randc bit                    s_axi_wlast;
  randc bit                    s_axi_wvalid;
        bit                    s_axi_wready;

  // response channel
        bit [ID_WIDTHS-1:0]    s_axi_bid;
        bit [1:0]              s_axi_bresp;
        bit                    s_axi_bvalid;
  randc bit                    s_axi_bready;

  // read address channel
  randc bit [ID_WIDTHS-1:0]    s_axi_arid;
  randc bit [ADDR_WIDTHS-1:0]  s_axi_araddr;
  randc bit [7:0]              s_axi_arlen;
  randc bit [2:0]              s_axi_arsize;
  randc bit [1:0]              s_axi_arburst;
  randc bit                    s_axi_arlock;
  randc bit [3:0]              s_axi_arcache;
  randc bit [2:0]              s_axi_arprot;
  randc bit                    s_axi_arvalid;
        bit                    s_axi_arready;

  // read_data channel
        bit [ID_WIDTHS-1:0]    s_axi_rid;
        bit [DATA_WIDTHS-1:0]  s_axi_rdata;
        bit [1:0]              s_axi_rresp;
        bit                    s_axi_rlast;
        bit                    s_axi_rvalid;
        bit                    s_axi_rready;
  // enum to decide write or read
  randc type_of_trans_t	  trans_type;

  // field macros registration  
  `uvm_object_utils_begin(write_seq_item)
    `uvm_field_int(s_axi_awid,UVM_ALL_ON)
    `uvm_field_int(s_axi_awaddr,UVM_ALL_ON)
    `uvm_field_int(s_axi_awlen,UVM_ALL_ON)
    `uvm_field_int(s_axi_awsize,UVM_ALL_ON)
    `uvm_field_int(s_axi_awburst,UVM_ALL_ON)
    `uvm_field_int(s_axi_awlock,UVM_ALL_ON)
    `uvm_field_int(s_axi_awcache,UVM_ALL_ON)
    `uvm_field_int(s_axi_awprot,UVM_ALL_ON)
    `uvm_field_int(s_axi_awvalid,UVM_ALL_ON)
    `uvm_field_int(s_axi_awready,UVM_ALL_ON)
    `uvm_field_array_int(s_axi_wdata,UVM_ALL_ON)
    `uvm_field_array_int(s_axi_wstrb,UVM_ALL_ON)
    `uvm_field_int(s_axi_wlast,UVM_ALL_ON)
    `uvm_field_int(s_axi_wvalid,UVM_ALL_ON)
    `uvm_field_int(s_axi_wready,UVM_ALL_ON)
    `uvm_field_int(s_axi_bid,UVM_ALL_ON)
    `uvm_field_int(s_axi_bresp,UVM_ALL_ON)
    `uvm_field_int(s_axi_bvalid,UVM_ALL_ON)
    `uvm_field_int(s_axi_bready,UVM_ALL_ON)
    `uvm_field_int(s_axi_arid,UVM_ALL_ON)
    `uvm_field_int(s_axi_araddr,UVM_ALL_ON)
    `uvm_field_int(s_axi_arlen,UVM_ALL_ON)
    `uvm_field_int(s_axi_arsize,UVM_ALL_ON)
    `uvm_field_int(s_axi_arburst,UVM_ALL_ON)
    `uvm_field_int(s_axi_arlock,UVM_ALL_ON)
    `uvm_field_int(s_axi_arcache,UVM_ALL_ON)
    `uvm_field_int(s_axi_arprot,UVM_ALL_ON)
    `uvm_field_int(s_axi_arvalid,UVM_ALL_ON)
    `uvm_field_int(s_axi_arready,UVM_ALL_ON)
    `uvm_field_int(s_axi_rid,UVM_ALL_ON)
    `uvm_field_int(s_axi_rdata,UVM_ALL_ON)
    `uvm_field_int(s_axi_rresp,UVM_ALL_ON)
    `uvm_field_int(s_axi_rlast,UVM_ALL_ON)
    `uvm_field_int(s_axi_rvalid,UVM_ALL_ON)
    `uvm_field_int(s_axi_rready,UVM_ALL_ON)
  `uvm_object_utils_end

  /////////////////////  CONSTRAINTS  ///////////////////

  constraint a{s_axi_awsize inside{[1:2]};}
  constraint h{s_axi_arsize inside{[1:2]};}  
  constraint b{s_axi_wdata.size() == s_axi_awlen+1;}
  constraint c{s_axi_wstrb.size() == s_axi_awlen+1;}
  constraint d{s_axi_awlen <16;}
  constraint i{s_axi_arlen <16;}
  //constraint vinay {s_axi_araddr=='d16541;}
  
  //constraint e{s_axi_araddr == s_axi_awaddr && s_axi_arlen == s_axi_awlen && s_axi_arsize == s_axi_awsize;}
  //constraint f{trans_type != WRITE_READ;}
  constraint u{s_axi_awburst inside{[0:1]};}
  constraint t{s_axi_arburst inside{[0:1]};}
  constraint ll{s_axi_araddr<(2**ADDR_WIDTHS)-65;}
  constraint kk{s_axi_awaddr<(2**ADDR_WIDTHS)-65;}

  //constraint j{if(s_axi_arburst==2) s_axi_araddr%(2**s_axi_arsize)==0;}
  //constraint z{if(s_axi_awburst==2) s_axi_awaddr%(2**s_axi_awsize)==0;}
	  
  //constraint g{s_axi_awaddr==2;}
  //constraint gu{s_axi_araddr==2;}
 // constraint hhh{s_axi_araddr != s_axi_awaddr;}


endclass

  /////////////////////  CONSTRUCTOR  ///////////////////

  function write_seq_item::new(string name = "write_seq_item");
    super.new(name);
  endfunction

  function write_seq_item::reports();
    $display(".-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.- REPORT .-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.--.-.-.");
	  
    $display("NO_OF_PASS_COUNT --------------------->",pass);

    $display("NO_OF_FAIL_COUNT --------------------->",fail);

    $display("NO_OF_TRANSACTION -------------------->",no_of_transaction);

    $display("NO_OF_INCREMENT_TRANSACTION ---------->",no_of_incr);

    $display("NO_OF_FIXED_TRANSACTION -------------->",no_of_fixed);

    $display("NO_OF_WRITE_ALONE_TRANSACTION--------->",no_of_write);

    $display("NO_OF_READ_ALONE_TRANSACTION---------->",no_of_read);

    $display("NO_OF_WRITE_READ_TRANSACTION---------->",no_of_write_read);

    $display("NO_OF_ALIGNED_ADDRESS----------------->",no_of_aligned);

    $display("NO_OF_UNALIGNED_ADDRESS--------------->",no_of_unaligned);

    $display(".-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.- END_REPORT .-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.--.-.-.");
          
  endfunction
	  

  `endif
