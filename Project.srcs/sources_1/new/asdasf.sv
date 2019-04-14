`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2018 10:03:59 PM
// Design Name: 
// Module Name: memIO
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module memIO #(
    parameter Nloc = 16,
    parameter Dbits = 32,
    parameter dmem_init = "dmem_screentest.mem",
    parameter smem_init = "smem_screentest.mem"
    )(
    input wire clk,
    input wire cpu_wr,
    input wire [31:0] mem_addr,
    output wire [31:0] mem_readdata,
    input wire [31:0] mem_writedata,
    output wire [4:0] charcode, //not parameterizing this yet so if I want to increase the number of characters I need to change this manually and smem_readdata
    input wire [10:0] smem_addr,
    
    input wire [31:0] keyb_char
    //input wire [31:0] accel_val,
    
    

    );
      
      wire lights_wr, sound_wr, smem_wr, dmem_wr;
      wire [3:0] smem_readdata;
      wire [31:0] dmem_readdata;
      
      //cpu_readdata gets assigned to smem_readdata or dmem_readdata within the memory_mapper
      memory_mapper memmap(cpu_wr, mem_addr, smem_readdata, dmem_readdata, keyb_char, lights_wr, sound_wr, smem_wr, dmem_wr, mem_readdata); 
      screen_memory #(.initfile(smem_init)) sm(clk, smem_wr, mem_addr[31:2], mem_writedata, smem_addr, charcode, smem_readdata);              
      dmem #(.Nloc(64), .Dbits(32), .initfile(dmem_init)) dmem(clk, dmem_wr, mem_addr[31:2], mem_writedata, dmem_readdata);  
                   // dropped two LSBs from address to data mem to convert byte address to word address
                   
endmodule
