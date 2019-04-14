`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/07/2018 02:30:44 PM
// Design Name: 
// Module Name: comparator
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


module comparator (
    input wire FlagN, FlagV, FlagC, bool0,
    output wire comparison
    );

assign comparison = bool0 ? ~FlagC : (FlagN ^ FlagV);
    
endmodule
