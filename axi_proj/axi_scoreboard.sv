////////////////////////////////////////////////
//                                            //   
//     file_name : axi_scoreboard.sv          //
//                                            // 
//     version   : 1.0                        //
//                                            //
//     notes     : scoreboad of AXI           //                                        
//                                            // 
////////////////////////////////////////////////

class axi_scoreboard extends uvm_scoreboard;

  // factory registration
  `uvm_component_utils(axi_scoreboard)

  // analysis imp_port declaration
  `uvm_analysis_imp_decl(_wc)

  `uvm_analysis_imp_decl(_rc)

  `uvm_analysis_imp_decl(_rac)

  `uvm_analysis_imp_decl(_wac)

  uvm_analysis_imp_wc #(write_seq_item,axi_scoreboard) wm2s;
  
  uvm_analysis_imp_rac #(write_seq_item,axi_scoreboard) wm2s_r;
  
  uvm_analysis_imp_rc #(write_seq_item,axi_scoreboard) rm2s;

  uvm_analysis_imp_wac #(write_seq_item,axi_scoreboard) wm2s_address;
  
  // associative memory for storing write data
  bit [7:0]             mem           [2**ADDR_WIDTHS]; //[int];//[4294967295:0];
  
  // temp address for write transaction
  bit [ADDR_WIDTHS-1:0] temp_addr;
  
  // temp address for read transaction
  bit [ADDR_WIDTHS-1:0] temp_addr_r;

  // for reset value for new read transaction
  int                   count;

  // for reset value for new write tansaction
  int                   count_w;

  // for pointing index in write transaction
  int p;
	
  // for wrap calculation to know the boudries for write transaction
  int upper_limit;
  
  int lower_limit;

  // for wrap calculation to know the boudries for read transaction
  int upper_limit_r;
  
  int lower_limit_r;



  // storing read address information
  write_seq_item temp;

  // storing write address information
  write_seq_item temp_waddr;

  extern function new(string name = "axi_scoreboard",uvm_component parent = null);

  extern task write_wc(write_seq_item t1);

  extern task write_rc(write_seq_item t3);

  extern task write_rac(write_seq_item t5);

  extern task write_wac(write_seq_item t6);
  

endclass


  ///////////////////////////  CONSTRUCTOR  //////////////////////////

  function axi_scoreboard::new(string name = "axi_scoreboard",uvm_component parent = null);
    super.new(name,parent);

    // creating object for all below handles
    wm2s           =  new("wm2s",this);
    wm2s_r         =  new("wm2s_r",this);
    rm2s           =  new("rm2s",this);
    wm2s_address   =  new("wm2s_address",this);
  endfunction

  ///////////////////////////  WRITE TRANSACTION COMPARISON  ////////////////////

  task axi_scoreboard::write_wc(write_seq_item t1);
    
    // doing clone here
    write_seq_item t2=new t1;
    //$cast(t2,t1.clone());
    
    if(count_w == 0) 
    begin
      // storing address in temp      
      temp_addr    =  temp_waddr.s_axi_awaddr;

      // to calculate upper and lower limit for wrap
      upper_limit  =  (int'(temp_addr/((2**temp_waddr.s_axi_awsize)*((temp_waddr.s_axi_awlen+1)))))* ((2**temp_waddr.s_axi_awsize)*((temp_waddr.s_axi_awlen+1))); 
      lower_limit  =  upper_limit+((2**temp_waddr.s_axi_awsize)*((temp_waddr.s_axi_awlen+1)));

      p=0;
      count_w++;
    end 
    
//    .........................................................  WRITING LOGIC  ...................................................................

      // point out the bytes in transfer 
      for(int j = 0;j < 2**temp_waddr.s_axi_awsize;j++)begin
	
	// in the respective location when strob is one it store that byte
	// in memory otherwise it just increment address
        if(t2.s_axi_wstrb[p][temp_addr[1:0]] == 1)
          mem[temp_addr] <= t2.s_axi_wdata[p][temp_addr[1:0]*8+:8];
  $display("llllllllllllllllllllllllllllll",t2.s_axi_wdata[p][temp_addr[1:0]*8+:8]);

//      .........................................................  REPORTING  .........................................................
  
        `uvm_info(get_name,"------------------ WRITING_IN_MEM ------------------------",UVM_LOW)

	$display("time--------------->",$time);

        `uvm_info(get_name,$sformatf("strobe %b ||||||| whole_data %h",t2.s_axi_wstrb[p],t2.s_axi_wdata[p]),UVM_LOW)

//        `uvm_info(get_name,$sformatf("address  %d <<<---------data %h",temp_addr,mem[temp_addr]),UVM_LOW)
        $display("address  %d <<<---------data %h",temp_addr,mem[temp_addr]);
       

	 `uvm_info(get_name,"------------------------ END ---------------------------",UVM_LOW)

//	...............................................................................................................................

        temp_addr++;

        // if address reaches the aligned it break the loop and go for next
	// transfer
	if(temp_addr % (2**temp_waddr.s_axi_awsize) == 0)begin
	
	  // resetting the temp in last transfer
          if(t2.s_axi_wlast == 1)
	  begin
	    count_w = 0;
	    `uvm_info(get_name,"--------------- LAST_WRITE_TRANSFER SO GET RESETED --------------",UVM_LOW)
            temp_addr = 0;
            p = 0;
	  end
	  
	  break;

        end
      end
      
      // for pointing next index
      p++;
  
      // changing address respective of burst type
      if(temp_waddr.s_axi_awburst == 2'b00)
        temp_addr = temp_waddr.s_axi_awaddr;
      if(temp_waddr.s_axi_awburst == 2'b10)
      begin
        if(temp_addr >= lower_limit)
          temp_addr = upper_limit;
      end
//    ............................................................................................................................................................    

  endtask

  /////////////////////////////  READ DATA CHANNEL  ////////////////////////////

  task axi_scoreboard::write_rc(write_seq_item t3);

    // cloning here
    write_seq_item t4 =new t3 ;
    //$cast(t4,t3.clone());


    // this to do address storing one time in a transaction
    if(count == 0)begin
      count++;

      // storing address in temp
      temp_addr_r   = temp.s_axi_araddr;

      // calculate lower and upper limit for wrap 
      upper_limit_r = (int'(temp_addr_r/((2**temp.s_axi_arsize)*((temp.s_axi_arlen+1)))))* ((2**temp.s_axi_arsize)*((temp.s_axi_arlen+1))); 
      lower_limit_r = upper_limit_r+((2**temp.s_axi_arsize)*((temp.s_axi_arlen+1)));
    end

//  .......................................................................... COMPARE LOGIC  .................................................................

    // this loop for pointing bytes in tansfer
    for (int i = 0;i < 2**temp.s_axi_arsize;i++)
    begin
      // the rdata is compare with stored wdata in asociative array
      if(mem[temp_addr_r] == t4.s_axi_rdata[temp_addr_r[1:0]*8+:8])
      begin

//	.............................................................  REPORT  ....................................................

        `uvm_info(get_name,"------------------------------------------ COMPARE -----------------------------------",UVM_LOW)

	$display("time------->",$time);

        `uvm_info(get_name,$sformatf("ADDRESS GOING TO COMPARE = %d",temp_addr_r),UVM_LOW)

        `uvm_info(get_name,$sformatf("REF MEM VALUE  %h,======== %h DUT RDATA VALUE",mem[temp_addr_r],t4.s_axi_rdata[temp_addr_r[1:0]*8+:8]),UVM_LOW)

	`uvm_info(get_name,"<><><><><><><><><><><><><><><>< PASSED PASSED ><><><><><><><><><><><><><><><><><>",UVM_LOW)

        pass++;

	`uvm_info(get_name,"------------------------------------------ END -----------------------------------",UVM_LOW)


      end

      else begin

        `uvm_info(get_name,"------------------------------------------ COMPARE -----------------------------------",UVM_LOW)
	      
	$display("time------->",$time);
	      
        `uvm_info(get_name,$sformatf("ADDRESS GOING TO COMPARE = %d",temp_addr_r),UVM_LOW)
	      
        `uvm_info(get_name,$sformatf("REF MEM VALUE  %h,======== %h DUT RDATA VALUE",mem[temp_addr_r],t4.s_axi_rdata[temp_addr_r[1:0]*8+:8]),UVM_LOW)

	`uvm_info(get_name,"{}{}{}}{}{}{}}{{}{}{}{}{}{}}{}{} FAILED FAILED {}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}",UVM_LOW)
      
	fail++;
	  
	`uvm_info(get_name,"------------------------------------------ END -----------------------------------",UVM_LOW)
	       
      end
//       ..............................................................................................................................

      // address increment for each transfer
      temp_addr_r++;
      
      // this logic is to break when i compplete all bytes in transfer
      if(temp_addr_r%2**temp.s_axi_arsize == 0)begin

	// when last high it reset all temp for next transaction
        if(t4.s_axi_rlast)begin
	  temp_addr_r = 0;
          `uvm_info(get_name,"--------------- LAST_READ_TRANSFER SO GET RESETED --------------",UVM_LOW)
          count       = 0;
        end

        break;

      end
    end
    if(temp.s_axi_arburst==2'b00)
      temp_addr_r=temp.s_axi_araddr;
    if(temp.s_axi_arburst==2'b10)begin
      if(temp_addr_r>=lower_limit_r)
        temp_addr_r=upper_limit_r;
      end
//    ....................................................................................................................................................................
  endtask

  //////////////////////////  READ ADDRESS CHANNEL ////////////////////////

  task axi_scoreboard::write_rac(write_seq_item t5);
    
    // it copy the address data to temp for read transaction
    temp = new t5;
  endtask

  ////////////////////////  WRITE ADDRESS CHANNEL  ////////////////////////
  
  task axi_scoreboard::write_wac(write_seq_item t6);

    // copy the write address info in temp
    temp_waddr = new t6;
  endtask
