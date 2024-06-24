/*-----------------------------------------------------------------
File name     : channel_pkg.sv
Description   : This creates a package for the channel OVC
Notes         :
-------------------------------------------------------------------
-----------------------------------------------------------------*/

`ifndef CHANNEL_PKG_SV
`define CHANNEL_PKG_SV

package channel_pkg;

// UVM class library compiled in a package
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "channel.svh"

endpackage : channel_pkg
`endif // CHANNEL_PKG_SV
