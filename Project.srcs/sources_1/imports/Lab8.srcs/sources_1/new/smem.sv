`timescale 1ns / 1ps
`default_nettype none

module smem #(
    parameter initfile = "smem.mem",
    parameter Nloc = 1200,
    parameter Dbits = 32
)(
    input wire clk, wr,
    input wire [10:0] cpu_addr,
    input wire [10:0] vga_addr,
    input wire [10:0] cpu_writedata,
    output wire [3:0] vga_charcode,
    output wire [31:0] cpu_readdata
    );

    logic [Dbits-1:0] mem [Nloc-1:0];
    initial $readmemb(initfile, mem, 0, Nloc - 1);
   
    always_ff @(posedge clk)
        if(wr)
            mem[cpu_addr] <= cpu_writedata; 
           
  
    // Returns the charcode which indexes bitmap memory
    assign cpu_readdata = mem[cpu_addr];
    assign vga_charcode = mem[vga_addr];
    
endmodule