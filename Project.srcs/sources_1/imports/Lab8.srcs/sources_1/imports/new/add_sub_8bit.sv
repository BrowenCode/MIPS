`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/05/2018 02:06:18 PM
// Design Name: 
// Module Name: add_sub_8bit
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


module addsub #(parameter N=32) (
    input wire [N-1:0] A, B,
    input wire Subtract,
    output wire [N-1:0] Result,
    output wire FlagN, FlagC, FlagV
    );
    
    wire [N-1:0] ToBornottoB = {N{Subtract}} ^ B;
    adder #(N) add(A, ToBornottoB, Subtract, Result, FlagN, FlagC, FlagV);
    
endmodule
