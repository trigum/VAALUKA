////////////////////////////////////////////////
//                                            //   
//     file_name : axi_top.sv                 //
//                                            // 
//     version   : 1.0                        //
//                                            //
//     notes     : top_module of AXI          //                                        
//                                            // 
////////////////////////////////////////////////


module axi_top();

  import uvm_pkg::*;

  `include "axi_ram.v"

  `include "uvm_macros.svh"

  `include "axi_interface.sv"

  `include "axi_verify.svh"

  // clock signal
  bit clock;

////////////////////////  CLOCK GENERATION  //////////////////////////

  // clock generation using always block
  always
  begin
    clock = 0;
    #5;
    clock = 1;
    #5;
  end


/////////////////////////  INTERFACE INSTANTIATION  /////////////////////////////

  // interface instantiation
  axi_interface #
(
    // Width of data bus in bits
     DATA_WIDTHS ,    
    
    // Width of address bus in bits
     ADDR_WIDTHS ,
    
    // Width of wstrb (width of data bus in words)
     (DATA_WIDTHS/8),
    
    // Width of ID signal
     ID_WIDTHS ,
    
    // Extra pipeline register on output
    PIPELINE_OUTPUTS
)
    // passing clock to interface
    axi_in(clock);

///////////////////////////  DESIGN INSTANTIATION  ////////////////////////////
  
  // design instantiation 
  axi_ram #
(
    // Width of data bus in bits
     DATA_WIDTHS ,

    // Width of address bus in bits
     ADDR_WIDTHS ,

    // Width of wstrb (width of data bus in words)
     (DATA_WIDTHS/8),

    // Width of ID signal
     ID_WIDTHS ,

    // Extra pipeline register on output
    PIPELINE_OUTPUTS
)
    DUT (
	 // universal signal
         clock,
	 axi_in.reset,

	 // write address channel
         axi_in.s_axi_awid,
         axi_in.s_axi_awaddr,
         axi_in.s_axi_awlen,
         axi_in.s_axi_awsize,
         axi_in.s_axi_awburst,
         axi_in.s_axi_awlock,
         axi_in.s_axi_awcache,
         axi_in.s_axi_awprot,
         axi_in.s_axi_awvalid,
         axi_in.s_axi_awready,

	 // write data channel
         axi_in.s_axi_wdata,
         axi_in.s_axi_wstrb,
         axi_in.s_axi_wlast,
         axi_in.s_axi_wvalid,
         axi_in.s_axi_wready,

	 // response chanel
         axi_in.s_axi_bid,
         axi_in.s_axi_bresp,
         axi_in.s_axi_bvalid,
         axi_in.s_axi_bready,

	 // read address channel
         axi_in.s_axi_arid,
         axi_in.s_axi_araddr,
         axi_in.s_axi_arlen,
         axi_in.s_axi_arsize,
         axi_in.s_axi_arburst,
         axi_in.s_axi_arlock,
         axi_in.s_axi_arcache,
         axi_in.s_axi_arprot,
         axi_in.s_axi_arvalid,
         axi_in.s_axi_arready,

	 // read data channel
         axi_in.s_axi_rid,
         axi_in.s_axi_rdata,
         axi_in.s_axi_rresp,
         axi_in.s_axi_rlast,
         axi_in.s_axi_rvalid,
         axi_in.s_axi_rready
 );

/////////////////////////////  INITIAL BLOCK ////////////////////

  //initial block
  initial begin

    // setting interface using config db
    uvm_config_db #(virtual axi_interface)::set(null,"*","vif",axi_in);

    // calling test
    run_test("base_test");
  end

endmodule
