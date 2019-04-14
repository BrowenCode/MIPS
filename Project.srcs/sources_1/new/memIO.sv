`timescale 1ns / 1ps
`default_nettype none


module memIO #(
    parameter Nloc = 16,
    parameter Dbits = 32,
    parameter dmem_init = "dmem.mem",
    parameter smem_init = "smem.mem"
    )(
    input wire clk,
    input wire mem_wr,
    input wire [31:0] mem_addr,
    output wire [31:0] mem_readdata,
    input wire [31:0] mem_writedata,
    output wire [3:0] charcode, 
    input wire [10:0] smem_addr,
    input wire [31:0] keyb_char,
    input wire [8:0] accelX, accelY,
    output wire [31:0] period,
    output wire [15:0] LED
    );
      
      wire lights_wr, sound_wr, smem_wr, dmem_wr;
      wire [3:0] smem_readdata;
      wire [31:0] dmem_readdata;
      
      logic [31:0] sound, light;
      
      assign mem_readdata = ((mem_addr[17:16] == 2'b11) && (mem_addr[3:2] == 2'b01)) ? {7'b0, accelX, 7'b0, accelY}
                            : ((mem_addr[17:16] == 2'b11) && (mem_addr[3:2] == 2'b00)) ? keyb_char
                            : (mem_addr[17:16] == 2'b10) ? {28'b0 , smem_readdata} 
                            : (mem_addr[17:16] == 2'b01) ? dmem_readdata
                            : 32'b0;
                            
      assign dmem_wr = (mem_wr) && (mem_addr[17:16] == 2'b01) ? 1'b1 : 1'b0;
      assign smem_wr = (mem_wr) && (mem_addr[17:16] == 2'b10) ? 1'b1 : 1'b0;
      assign lights_wr = ((mem_wr) && ((mem_addr[17:16] == 2'b11) && (mem_addr[3:2] == 2'b11))) ? 1'b1 : 1'b0;
      assign sound_wr = ((mem_wr) && ((mem_addr[17:16] == 2'b11) && (mem_addr[3:2] == 2'b10))) ? 1'b1 : 1'b0;
      
      assign period = sound;
      assign LED = light;
      
      always_ff @(posedge clk)
      begin
        if(sound_wr)
            sound <= mem_writedata;
        if(lights_wr)
            light <= mem_writedata;
      end
      
      
      
      smem #(.initfile(smem_init)) smem(.clk(clk), .wr(smem_wr), .cpu_addr(mem_addr[31:2]), .vga_addr(smem_addr), .cpu_writedata(mem_writedata), .vga_charcode(charcode), .cpu_readdata(smem_readdata));            
              
      dmem #(.Nloc(128), .Dbits(32), .initfile(dmem_init)) dmem(clk, dmem_wr, mem_addr[31:2], mem_writedata, dmem_readdata);  
          
      
      
      
                 
endmodule
