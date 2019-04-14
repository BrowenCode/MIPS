//////////////////////////////////////////////////////////////////////////////////
//
// Montek Singh
// 10/6/2018
//
//////////////////////////////////////////////////////////////////////////////////

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


module register_file #(
   parameter Nloc = 32,                      // Number of memory locations
   parameter Dbits = 32                      // Number of bits in data
)(

   input wire clock,
   input wire wr,                            // WriteEnable:  if wr==1, data is written into mem
   input wire [$clog2(Nloc)-1 : 0] ReadAddr1, ReadAddr2, WriteAddr, 	
                                             // 3 addresses, two for reading and one for writing
   input wire [Dbits-1 : 0] WriteData,       // Data for writing into memory (if wr==1)
   output wire [Dbits-1 : 0] ReadData1, ReadData2
                                             // 2 output ports
   );

   logic [...] rf [...];                     // The actual registers where data is stored
                                             // initial $readmemh(initfile, ..., ..., ...);  
                                             // Usually no need to initialize register file

   always_ff @(posedge clock)                // Memory write: only when wr==1, and only at posedge clock
      if(wr)
         rf[...] <= ...;

   // MODIFY the two lines below so if register 0 is being read, then the output
   // is 0 regardless of the actual value stored in register 0
   
   assign ReadData1 = ... ? ... rf[...];     // First output port
   assign ReadData2 = ... ? ... rf[...];     // Second output port
   
endmodule