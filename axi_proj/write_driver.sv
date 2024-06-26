////////////////////////////////////////////////
//                                            //   
//     file_name : write_driver.sv            //
//                                            // 
//     version   : 1.0                        //
//                                            //
//     notes     : driver of AXI              //           
//                                            // 
////////////////////////////////////////////////

`ifndef WRITE_DRIVER
`define WRITE_DRIVER

class write_driver extends uvm_driver #(write_seq_item);

  // factory registration
  `uvm_component_utils(write_driver)

  // interface handle declaration
  virtual axi_interface axi_in;

  extern function new(string name = "write_driver",uvm_component parent = null);

  extern function void build_phase(uvm_phase phase);

  extern task send_to_dut(write_seq_item t1);

  extern task get_and_drive();

  extern task run_phase(uvm_phase phase);

  extern task write_address_channel(write_seq_item t4);

  extern task write_data_channel(write_seq_item t5);

  extern task read_address_channel(write_seq_item t6);


endclass

   

  ///////////////////////////  CONSTRUCTOR  /////////////////////////

  function write_driver::new(string name = "write_driver",uvm_component parent = null);
    super.new(name,parent);
  endfunction
   
  ///////////////////////////  RUN PHASE  /////////////////////////

  task write_driver::run_phase(uvm_phase phase);
        
     //making below signal default zero
      
    // write address channel
    axi_in.s_axi_awid    = 0;
    axi_in.s_axi_awaddr  = 0;
    axi_in.s_axi_awlen   = 0;
    axi_in.s_axi_awsize  = 0;
    axi_in.s_axi_awburst = 0;
    axi_in.s_axi_awlock  = 0;
    axi_in.s_axi_awcache = 0;
    axi_in.s_axi_awprot  = 0;
    axi_in.s_axi_awvalid = 0;

    // write data channel
    axi_in.s_axi_wdata   = 0;
    axi_in.s_axi_wstrb   = 0;
    axi_in.s_axi_wlast   = 0;
    axi_in.s_axi_wvalid  = 0;

    // response channel
    axi_in.s_axi_bready  = 0;

    // read address channel
    axi_in.s_axi_arid    = 0;
    axi_in.s_axi_araddr  = 0;
    axi_in.s_axi_arlen   = 0;
    axi_in.s_axi_arsize  = 0;
    axi_in.s_axi_arburst = 0;
    axi_in.s_axi_arlock  = 0;
    axi_in.s_axi_arcache = 0;
    axi_in.s_axi_arprot  = 0;
    axi_in.s_axi_arvalid = 0;

    // read data channel
    axi_in.s_axi_rready  = 0;
	 

      
    // calling get and drive
    get_and_drive();
    
  endtask

  ////////////////////////////   GET AND DRIVE [GETING RANDOMIZED HANDLE]  ////////////////

  task write_driver::get_and_drive();
    
    // initialy reseting the design
    repeat(2)begin
      @(negedge axi_in.clock);
      axi_in.reset = 1;
    end
    @(negedge axi_in.clock);
    axi_in.reset = 0;
    
    // geting randomized value
    forever begin
      seq_item_port.get_next_item(req);
      
      //req.print();

      // call send_to_dut which going to drive
      send_to_dut(req);

      seq_item_port.item_done();
    end
  endtask
    
  ////////////////////////////  SEND TO DUT [START THE CHANNEL]  ///////////////////

  task write_driver::send_to_dut(write_seq_item t1);

    if(t1.trans_type == WRITE) begin
	no_of_write++;
    // calling the task with respective of transaction type      
      fork
        write_address_channel(t1);
        write_data_channel(t1);
      join
    end
    if(t1.trans_type == READ) begin
      no_of_read++;
      read_address_channel(t1);
    end
    if(t1.trans_type == WRITE_READ) begin
      no_of_write_read++;
      
      fork
        write_address_channel(t1);
        write_data_channel(t1);
	read_address_channel(t1);
      join
    end

  endtask

///////////////////////  WRITE ADDRESS CHANNEL  ///////////////////////

  task write_driver::write_address_channel(write_seq_item t4);

    // passing stimulus on addess channel
    @(negedge axi_in.clock)
    axi_in.s_axi_bready   <= 1;
    axi_in.s_axi_awid     <= t4.s_axi_awid;
    axi_in.s_axi_awaddr   <= t4.s_axi_awaddr;
    axi_in.s_axi_awlen    <= t4.s_axi_awlen;
    axi_in.s_axi_awsize   <= t4.s_axi_awsize;
    axi_in.s_axi_awburst  <= t4.s_axi_awburst;

    // .............................report.............................
    no_of_transaction++;

    if(t4.s_axi_awburst == 2'b00)
      no_of_fixed++;
    else 
      no_of_incr++;
    if(t4.s_axi_awaddr % (2**t4.s_axi_awsize) != 0)
      no_of_aligned++;
    else
      no_of_unaligned++;
//    ..................................................................

    // making default value for below three    
    axi_in.s_axi_awlock   <= 0;
    axi_in.s_axi_awcache  <= 0;
    axi_in.s_axi_awprot   <= 0;

    axi_in.s_axi_awvalid <= 1;

//    .............................................................................................................................

    $display("time------------------------->",$time);
    
    `uvm_info(get_name,"DRIVER ------------------------ WRITE_ADDRESS --------------------------------> INTERFACE",UVM_LOW)
    t4.print();
    `uvm_info(get_name,"------------------------------------- END ---------------------------------------",UVM_LOW)

//     .............................................................................................................................

    // checking for ready signal to make sure it samples are not
    @(posedge axi_in.clock);
    while(!axi_in.s_axi_awready)
      @(posedge axi_in.clock)    
    #2;
    axi_in.s_axi_awvalid <= 0;
  endtask

///////////////////////   WRITE DATA CHANNEL  ///////////////////////

  task write_driver::write_data_channel(write_seq_item t5);

    // drive stimulus on data channel
    // looping for number of length times
    for(int i=0;i<=t5.s_axi_awlen;i++) begin
      @(negedge axi_in.clock);

      // using array for driving transfers
      axi_in.s_axi_wdata   <= t5.s_axi_wdata[i];
      axi_in.s_axi_wstrb   <= t5.s_axi_wstrb[i];
      
      axi_in.s_axi_wvalid  <= 1;
      
      // for last transfer want to assert last
      if(i == t5.s_axi_awlen)
        axi_in.s_axi_wlast <= 1;
      else
        axi_in.s_axi_wlast <= 0;

//    .....................................................................................................................................

      $display("time------------------------->",$time);
      `uvm_info(get_name,"DRIVER ------------------------ WRITE_DATA --------------------------------> INTERFACE",UVM_LOW)
      t5.print();
      `uvm_info(get_name,"------------------------------------- END ---------------------------------------",UVM_LOW)

//    .....................................................................................................................................

      @(posedge axi_in.clock);

      // waiting for ready
      while(!axi_in.s_axi_wready)
        @(posedge axi_in.clock);
    end   
    #2;
    axi_in.s_axi_wvalid <= 0;
    axi_in.s_axi_wlast  <= 0;
  endtask

  ///////////////////////////  READ_ADDRESS_CHANNEL  /////////////////////////
  
  task write_driver::read_address_channel(write_seq_item t6);
    @(negedge axi_in.clock);

    // driving read address data values
    axi_in.s_axi_rready  <= 1;
    axi_in.s_axi_arid    <= t6.s_axi_arid;
    axi_in.s_axi_araddr  <= t6.s_axi_araddr;
    axi_in.s_axi_arlen   <= t6.s_axi_arlen;
    axi_in.s_axi_arsize  <= t6.s_axi_arsize;
    axi_in.s_axi_arburst <= t6.s_axi_arburst;
    axi_in.s_axi_arlock  <= 0;
    axi_in.s_axi_arcache <= 0;
    axi_in.s_axi_arprot  <= 0;
    axi_in.s_axi_arvalid <= 1;
    no_of_transaction++;
    if(t6.s_axi_arburst==2'b00)
      no_of_fixed++;
    else 
      no_of_incr++;
    
    if(t6.s_axi_araddr%(2**t6.s_axi_arsize)!=0)
      no_of_aligned++;
    else
      no_of_unaligned++;
//    ...................................................................................................................................

    $display("time------------------------->",$time);
    `uvm_info(get_name,"DRIVER ------------------------ READ_ADDRESS --------------------------------> INTERFACE",UVM_LOW)
    t6.print();
    `uvm_info(get_name,"------------------------------------- END ---------------------------------------",UVM_LOW)

//   .....................................................................................................................................
     @(posedge axi_in.clock)

     // checking for ready and valid both high then go for next transfer
     while(!axi_in.s_axi_arready)
       @(posedge axi_in.clock);
     #2;
     axi_in.s_axi_arvalid <= 0;
   endtask

  ////////////////////////  BUILD PHASE  /////////////////////////////////

  function void write_driver::build_phase(uvm_phase phase); 
    uvm_config_db #(virtual axi_interface)::get(this,"","vif",axi_in);
  endfunction

  `endif
