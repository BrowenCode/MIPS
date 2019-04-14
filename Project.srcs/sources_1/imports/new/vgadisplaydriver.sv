`timescale 1ns / 1ps
`default_nettype none
`include "display640x480.vh"


module vgadisplaydriver(
    input wire clk,
    input wire [3:0] char_code,
    output wire [3:0] red, green, blue,
    output wire hsync, vsync,
    output wire [10:0] screen_addr,
    output wire [`xbits-1:0] x,
    output wire [`ybits-1:0] y
    );
    
 
    logic [9:0] row, column;
    wire [9:0] bmem_addr = {char_code, y[3:0], x[3:0]};
    wire [11:0] bmem_color;
    wire activevideo;
    
    vgatimer myvgatimer(clk, hsync, vsync, activevideo, x, y);
    bitmap_mem #(.Nloc(1024), .Dbits(12)) bm(clk, bmem_addr, bmem_color);
    
    assign row = y >> 4; 
    assign column = x  >> 4;
    
    assign screen_addr = ((row << 5) + (row << 3)) + column;   
                        
    assign red[3:0] = (activevideo == 1) ? bmem_color[11:8] : 4'b0;
    assign green[3:0] = (activevideo == 1) ?  bmem_color[7:4] : 4'b0;  
    assign blue[3:0] = (activevideo == 1) ? bmem_color[3:0]: 4'b0; 
    
    
endmodule
