////////////////////////////////////////////////
//                                            //   
//     file_name : read_monitor.sv            //
//                                            // 
//     version   : 1.0                        //
//                                            //
//     notes     : read_monitor of AXI        //                                        
//                                            // 
////////////////////////////////////////////////



`ifndef READ_MONITOR
`define READ_MONITOR

class read_monitor extends uvm_monitor;

  // factory registration
  `uvm_component_utils(read_monitor)

  // declare analysis port
  uvm_analysis_port #(write_seq_item) rm2s;

  // handle to collect
  write_seq_item collect;

  // interface declaration
  virtual axi_interface axi_in;

  extern function new(string name = "read_monitor",uvm_component parent = null);

  extern task run_phase(uvm_phase phase);

  extern task read_data_collection();

  extern function void build_phase(uvm_phase phase);

endclass

  ////////////////////  CONSTRUCTOR  ///////////////////////
  
  function read_monitor::new(string name = "read_monitor",uvm_component parent = null);
    super.new(name,parent);
  endfunction

  /////////////////////  RUN PHASE  ///////////////////////

  task read_monitor::run_phase(uvm_phase phase);
    forever begin

      // creating new object to store captured value from interface
      collect = write_seq_item::type_id::create("collect",this); 

      // calling method to collect read data   
      read_data_collection();
    end
  endtask

  ////////////////////   READ DATA COLLECTION   ///////////////////

  task read_monitor::read_data_collection();
    @(posedge axi_in.clock);

    while(!(axi_in.s_axi_rvalid&&axi_in.s_axi_rready)) 
      @(posedge axi_in.clock);

    // until last asserted the loop collecting data
    while(!axi_in.s_axi_rlast)begin
      $display("check11",$time);

      // collect data only when valid and ready become high
      if((axi_in.s_axi_rvalid && axi_in.s_axi_rready))begin
        $display("check12",$time);
        collect.s_axi_rid   = axi_in.s_axi_rid;
        collect.s_axi_rdata = axi_in.s_axi_rdata;
        collect.s_axi_rlast = axi_in.s_axi_rlast;

//	...........................................................  REPORT  ........................................................

        $display("time------------------------->",$time);
        `uvm_info(get_name,"MONITOR ------------------------ READ_DATA --------------------------------> SCOREBOARD",UVM_LOW)
        collect.print();
        `uvm_info(get_name,"------------------------------------- END ---------------------------------------",UVM_LOW)

//      .............................................................................................................................

	// send to scoreborad for comparison
        rm2s.write(collect);

        @(posedge axi_in.clock);
      end

      else
        @(posedge axi_in.clock);
    end

    // collecting last transfer data after last get asserted
    while(!(axi_in.s_axi_rvalid&&axi_in.s_axi_rready))
      @(posedge axi_in.clock);
    collect.s_axi_rid   = axi_in.s_axi_rid;
    collect.s_axi_rdata = axi_in.s_axi_rdata;
    collect.s_axi_rlast = axi_in.s_axi_rlast;  

//	...........................................................  REPORT  ........................................................

    $display("time------------------------->",$time);
    `uvm_info(get_name,"MONITOR ------------------------ READ_DATA --------------------------------> SCOREBOARD",UVM_LOW)
    collect.print();
    `uvm_info(get_name,"------------------------------------- END ---------------------------------------",UVM_LOW)

//      .............................................................................................................................

    // sending to scoreboard
    rm2s.write(collect);    
  endtask

  ////////////////////////  BUILD_PHASE  //////////////////////////

  function void read_monitor::build_phase(uvm_phase phase);
    super.build_phase(phase);

    // geting interface from top
    uvm_config_db #(virtual axi_interface)::get(this,"","vif",axi_in);

    // creating rm2s port
    rm2s = new("rm2s",this);
  endfunction

  `endif
 
