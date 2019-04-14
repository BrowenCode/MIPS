`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2018 04:31:48 PM
// Design Name: 
// Module Name: signExtend
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


module signExtend(
    input wire en,
    input wire [15:0] imm,
    output wire [31:0] signImm
    );

assign signImm = en ? {{16{imm[15]}}, imm} : {{16{32'h00}}, imm};
endmodule
