//////////////////////////////////////////////////////////////////////////////////
//
// Montek Singh
// 9/12/2017 
//
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`default_nettype none
`include "display10x4.vh"

module vgadisplaydriver(
    input wire clk,
    output wire [3:0] red, green, blue,
    output wire hsync, vsync
    );

   wire [`xbits-1:0] x;
   wire [`ybits-1:0] y;
   wire activevideo;

   vgatimer myvgatimer(clk, hsync, vsync, activevideo, x, y);
   
   assign red[3:0]   = (activevideo == 1) ? x[3:0] : 4'b0;
   assign green[3:0] = (activevideo == 1) ? {x[2:1],y[1:0]} : 4'b0;
   assign blue[3:0]  = (activevideo == 1) ? {y[2:0],1'b0} : 4'b0;

endmodule
