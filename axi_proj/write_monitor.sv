////////////////////////////////////////////////
//                                            //   
//     file_name : write_monitor.sv           //
//                                            // 
//     version   : 1.0                        //
//                                            //
//     notes     : monitor of AXI             //                                        
//                                            // 
////////////////////////////////////////////////


`ifndef WRITE_MONITOR
`define WRITE_MONITOR

class write_monitor extends uvm_monitor;

  // factory registration
  `uvm_component_utils(write_monitor)

  // declaring analysis port
  uvm_analysis_port #(write_seq_item) wm2s;

  uvm_analysis_port #(write_seq_item) wm2s_r;

  uvm_analysis_port #(write_seq_item) wm2s_address;
  
  // to collect the datas
  write_seq_item collect;

  // to collect the datas
  write_seq_item collect_r;
  write_seq_item collect_wa;
  

  // virtual handle declaration
  virtual axi_interface axi_in;


  extern function new(string name = "write_monitor",uvm_component parent = null);

  extern function void build_phase(uvm_phase phase);

  extern task run_phase(uvm_phase phase);

  extern task write_data_collection();

  extern task write_address_collection();

  extern task read_address_collection();

endclass

  /////////////////////////////  CONSTRUCTOR  ///////////////////////////////

  function write_monitor::new(string name = "write_monitor",uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  ////////////////////////////  BUILD_PHASE  /////////////////////////////////

  function void write_monitor::build_phase(uvm_phase phase);
    super.build_phase(phase);
    //getting interface from top
    uvm_config_db #(virtual axi_interface)::get(this,"","vif",axi_in);

    // creating ports
    wm2s          = new("wm2s",this);
    wm2s_r        = new("wm2s_r",this);
    wm2s_address  = new("wm2s_address",this);
  endfunction
  
  ///////////////////////////  RUN PHASE  ////////////////////////////////

  task write_monitor::run_phase(uvm_phase phase);

    // getting datas
    fork	    
      begin
        @(posedge axi_in.clock);
        forever begin

          // creating object for collecting
          collect = write_seq_item::type_id::create("collect");
          collect_wa = write_seq_item::type_id::create("collect_wa");          
          // calling task sequentially
          write_address_collection();
          write_data_collection();
        end
      end

      begin
        forever begin

          // handle for collecting read data
          collect_r = write_seq_item::type_id::create("collect_r");
	
          // calling task to collect read addess data	  
          read_address_collection();
        end
      end

    join
  endtask

  ////////////////////  WRITE DATA CHANNEL  //////////////////////////////

  task write_monitor::write_data_collection();
    int o;

    // fixing the size of array rsepective of length from address
    collect.s_axi_wdata = new[collect.s_axi_awlen+1];
    collect.s_axi_wstrb = new[collect.s_axi_awlen+1];
    @(posedge axi_in.clock)

    // checking for ready and valid for sampling data
    while(!(axi_in.s_axi_wready && axi_in.s_axi_wvalid))
      @(posedge axi_in.clock);

    // until wlast become high we want to sample
    while(!axi_in.s_axi_wlast)
    begin
      if((axi_in.s_axi_wready&&axi_in.s_axi_wvalid))begin
        collect.s_axi_wdata[o] = axi_in.s_axi_wdata;
        collect.s_axi_wstrb[o] = axi_in.s_axi_wstrb;
	collect.s_axi_wlast    = axi_in.s_axi_wlast;
        o++;

//	.........................................................................................................................

	$display("time------------------------->",$time);
        `uvm_info(get_name,"MONITOR ------------------------ WRITE_DATA --------------------------------> SCOREBOARD",UVM_LOW)
        collect.print();
        `uvm_info(get_name,"------------------------------------- END ---------------------------------------",UVM_LOW)

//	..........................................................................................................................

	@(posedge axi_in.clock);

	wm2s.write(collect);
      end
    end

    // after wlast high we want to sample the last transfer
    collect.s_axi_wdata[o] = axi_in.s_axi_wdata;
    collect.s_axi_wstrb[o] = axi_in.s_axi_wstrb;
    collect.s_axi_wlast    = axi_in.s_axi_wlast;

//    ..............................................................................................................................

    $display("time------------------------->",$time);
    `uvm_info(get_name,"MONITOR ------------------------ WRITE_DATA --------------------------------> SCOREBOARD",UVM_LOW)
    collect.print();
    `uvm_info(get_name,"------------------------------------- END ---------------------------------------",UVM_LOW)

//    ................................................................................................................................

    @(posedge axi_in.clock);
    wm2s.write(collect);
    
    // sending to scoreboard
    
  endtask

 ///////////////////////////  WRITE_ADDRESS CHANNEL  ////////////////////////////////
 
    task write_monitor::write_address_collection();
    
      while(axi_in.s_axi_awready === 1'bx && axi_in.s_axi_awvalid === 1'bx)
        @(posedge axi_in.clock);
      
      // checking for valid and ready
      while(!(axi_in.s_axi_awready && axi_in.s_axi_awvalid))
        @(posedge axi_in.clock);
     
      // sampling address data
      collect.s_axi_awid = axi_in.s_axi_awid;
      collect.s_axi_awaddr  = axi_in.s_axi_awaddr;
      collect.s_axi_awlen   = axi_in.s_axi_awlen;
      collect.s_axi_awsize  = axi_in.s_axi_awsize;
      collect.s_axi_awburst = axi_in.s_axi_awburst;

//    ...........................................................................................................................

      $display("time------------------------->",$time);
      `uvm_info(get_name,"MONITOR ------------------------ WRITE_ADDRESS --------------------------------> SCOREBOARD",UVM_LOW)
      collect.print();
      `uvm_info(get_name,"------------------------------------- END ---------------------------------------",UVM_LOW)

//    .............................................................................................................................
   
      wm2s_address.write(collect);
      
    endtask

    /////////////////////////  READ ADDRESS COLLECTION  ///////////////////////////////
    
    task write_monitor::read_address_collection();
      @(posedge axi_in.clock);

      // checking for valid and ready
      while(!(axi_in.s_axi_arready&&axi_in.s_axi_arvalid))
        @(posedge axi_in.clock);

      // collecting address information 
      collect_r.s_axi_arid=axi_in.s_axi_arid;
      collect_r.s_axi_araddr=axi_in.s_axi_araddr;
      collect_r.s_axi_arlen=axi_in.s_axi_arlen;
      collect_r.s_axi_arsize=axi_in.s_axi_arsize;
      collect_r.s_axi_arburst=axi_in.s_axi_arburst;

//    ................................................................................................................................
      
      $display("time------------------------->",$time);
      `uvm_info(get_name,"MONITOR ------------------------ READ_ADDRESS --------------------------------> SCOREBOARD",UVM_LOW)
      collect_r.print();
      `uvm_info(get_name,"------------------------------------- END ---------------------------------------",UVM_LOW)

//      ...............................................................................................................................
      
      // send to scoreboard
      #1;
      wm2s_r.write(collect_r);
    endtask

    `endif
