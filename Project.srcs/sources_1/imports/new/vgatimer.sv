`timescale 1ns / 1ps
`default_nettype none
`include "display640x480.vh"

module vgatimer(
    input wire clk,
    output wire hsync, vsync, activevideo,
    output wire [`xbits-1:0] x,
    output wire [`ybits-1:0] y
    );
    
    //counting very 2nd and 4th clock ticks for 50 or 25MHz display mode
    logic [1:0] count = 0;
    always_ff @(posedge clk) 
        count <= count + 2'b01;
    
    wire Every2ndTick = (count[0] == 1'b1);
    wire Every4thTick = (count[1:0] == 2'b11);
    
    
    //intializing my xycounter using appropriate clock tick counter
    //xycounter #(`WholeLine, `WholeFrame) xy(clk, Every2ndTick, x, y); //Count at 50MHz
    
    xycounter #(`WholeLine, `WholeFrame) xy(clk, Every4thTick, x, y); //Count at 25MHz
    
    //Generate the monitor sync signals
    
        assign hsync = ~((x >= `hSyncStart) & (x <= `hSyncEnd));  
        assign vsync = ~((y >= `vSyncStart) & (y <= `vSyncEnd));
        assign activevideo = (x < `hVisible) & (y < `vVisible);   
    
    
endmodule
