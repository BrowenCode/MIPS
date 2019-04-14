`timescale 1ns / 1ps
`default_nettype none

module imem #(
   parameter Nloc = 512,  
   parameter Dbits = 32,     
   parameter initfile = "imem.mem"          // Name of file with initial values
   )(
   
   input wire [31:0] pc,
   output wire [31:0] instr
   );
   
   logic [Dbits-1:0] mem [Nloc-1:0];
   initial $readmemh(initfile, mem, 0, Nloc-1); // Initialize memory contents from a file
   
   assign instr = mem[pc[11:0]];
   
endmodule
