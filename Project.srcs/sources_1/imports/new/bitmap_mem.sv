`timescale 1ns / 1ps
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
//
// NOTE:  There should be NO NEED TO MODIFY *ANYTHING* in this template
//        (other than filling in the blanks).
//        You do NOT need to modify any parameters at the top, nor any of
//        the bit widths of address or data.
//
//        Simply use different values for the parameters when the module
//        is instantiated inside its parent.
//
//        Modifying anything here is cause for much headache later on!
//////////////////////////////////////////////////////////////////////////////////

module bitmap_mem #(
   parameter Nloc = 1024,                      // Number of memory locations
   parameter Dbits = 12                     // Number of bits in data
   )(

   input wire clk,
   input wire [9:0] bmem_addr,
   output wire [11:0] color_val
                                             // 2 output ports
   );

   logic [Dbits-1:0] rf [Nloc-1:0];                     // The actual registers where data is stored      
   initial $readmemh("bmem.mem", rf, 0 , Nloc - 1);  
                                   // initial $readmemh(initfile, ..., ..., ...);  
                                   
//   always_ff @(posedge clk)                // Memory write: only when wr==1, and only at posedge clock
//   if(wr)
//     rf[bmem_addr] <= color_val;
   
   assign color_val = rf[bmem_addr];     // First output port

endmodule
