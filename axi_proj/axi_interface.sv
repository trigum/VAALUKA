

////////////////////////////////////////////////
//                                            //   
//     file_name : axi_interface.sv           //
//                                            // 
//     version   : 1.0                        //
//                                            //
//     notes     : interface of AXI           //                                        
//                                            // 
////////////////////////////////////////////////

`ifndef AXI_INTERFACE
`define AXI_INTERFACE

interface axi_interface #
(
    // Width of data bus in bits
    parameter DATA_WIDTH = 32,
    
    // Width of address bus in bits
    parameter ADDR_WIDTH = 16,
    
    // Width of wstrb (width of data bus in words)
    parameter STRB_WIDTH = (DATA_WIDTH/8),
    
    // Width of ID signal
    parameter ID_WIDTH = 8,
    
    // Extra pipeline register on output
    parameter PIPELINE_OUTPUT = 0
)
(
    // clock input from top
    input clock
);


    // interface signals which connect design and tb
    // global signal
    logic reset;

    ////////  WRITE ADDRESS CHANNEL  ///////

    logic [ID_WIDTH-1:0]    s_axi_awid;
    logic [ADDR_WIDTH-1:0]  s_axi_awaddr;
    logic [7:0]             s_axi_awlen;
    logic [2:0]             s_axi_awsize;
    logic [1:0]             s_axi_awburst;
    logic                   s_axi_awlock;
    logic [3:0]             s_axi_awcache;
    logic [2:0]             s_axi_awprot;
    logic                   s_axi_awvalid;
    logic                   s_axi_awready;

    ////////  WRITE DATA CHANNEL  ///////

    logic [DATA_WIDTH-1:0]  s_axi_wdata;
    logic [STRB_WIDTH-1:0]  s_axi_wstrb;
    logic                   s_axi_wlast;
    logic                   s_axi_wvalid;
    logic                   s_axi_wready;

    /////////  RESPONSE CHANNEL  ///////

    logic [ID_WIDTH-1:0]    s_axi_bid;
    logic [1:0]             s_axi_bresp;
    logic                   s_axi_bvalid;
    logic                   s_axi_bready;

    ////////  READ ADDRESS CHANNEL  //////

    logic [ID_WIDTH-1:0]    s_axi_arid;
    logic [ADDR_WIDTH-1:0]  s_axi_araddr;
    logic [7:0]             s_axi_arlen;
    logic [2:0]             s_axi_arsize;
    logic [1:0]             s_axi_arburst;
    logic                   s_axi_arlock;
    logic [3:0]             s_axi_arcache;
    logic [2:0]             s_axi_arprot;
    logic                   s_axi_arvalid;
    logic                   s_axi_arready;

    ////////  READ DATA CHANNEL  //////////

    logic [ID_WIDTH-1:0]    s_axi_rid;
    logic [DATA_WIDTH-1:0]  s_axi_rdata;
    logic [1:0]             s_axi_rresp;
    logic                   s_axi_rlast;
    logic                   s_axi_rvalid;
    logic                   s_axi_rready;

endinterface

`endif
