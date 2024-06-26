////////////////////////////////////////////////
//                                            //   
//     file_name : write_sequence.sv          //
//                                            // 
//     version   : 1.0                        //
//                                            //
//     notes     : sequence of AXI            //                                        
//                                            // 
////////////////////////////////////////////////




///////////////////////////////////////////////
//                                           //
//  increment - write - read - transaction   //
//                                           //
///////////////////////////////////////////////

`ifndef WRITE_SEQUENCE
`define WRITE_SEQUENCE

class write_sequence extends uvm_sequence #(write_seq_item);

  // factory registration
  `uvm_object_utils(write_sequence)
  int tem_addr;
  int upper_limit;
  int lower_limit;
  extern function new(string name = "write_sequence");

  extern task body();

endclass

  ///////////////////////////  CONSTRUCTOR  ////////////////////////

  function write_sequence::new(string name = "write_sequence");
    super.new(name);
  endfunction

  ///////////////////////////  BODY  //////////////////////////////

  task write_sequence::body();
	
    // raising objection
    if(starting_phase != null)
      starting_phase.raise_objection(this);

    // creating object for sequence_item
    req = write_seq_item::type_id::create("req");

    // creating stimulus
    for(int i = 0;i < 20000;i++) begin 
      start_item(req);
      req.randomize();

      // storing address in temp variable
      tem_addr=req.s_axi_awaddr;
      addr=req.s_axi_awaddr;

      // wrap boudries calculation
      upper_limit =  (int'(tem_addr/((2**req.s_axi_awsize)*((req.s_axi_awlen+1)))))* ((2**req.s_axi_awsize)*((req.s_axi_awlen+1))); 
      lower_limit = upper_limit+((2**req.s_axi_awsize)*((req.s_axi_awlen+1)));

      // make all  strobe value as zero
      foreach(req.s_axi_wstrb[i])
        req.s_axi_wstrb[i]=0;

// .................strobe calculation........................

      foreach(req.s_axi_wstrb[i]) begin  
        req.s_axi_wstrb[i][tem_addr[1:0]]=1;
	tem_addr++;
	while(tem_addr%(2**req.s_axi_awsize)!=0)begin
          req.s_axi_wstrb[i][tem_addr[1:0]]=1;
	  tem_addr++;
        end
        if(req.s_axi_awburst==2'b00)
	  tem_addr=req.s_axi_awaddr;
        if(req.s_axi_awburst==2'b10)begin
          if(tem_addr>=lower_limit)
	    tem_addr=upper_limit;
         end
			
      end
// ............................................................
      finish_item(req);
    end

    #4000;
    $display("pass_count",pass);
    $display("fail_count",fail);
    
    // drop objection
    if(starting_phase != null)
      starting_phase.drop_objection(this);
    
  endtask

  `endif


        
       

  

  
