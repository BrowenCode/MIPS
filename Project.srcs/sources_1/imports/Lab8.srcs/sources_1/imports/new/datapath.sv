`timescale 1ns / 1ps
`default_nettype none


module datapath #(
    parameter Dbits = 32,         // Number of bits in data
    parameter Nloc = 32           // Number of memory locations
)(

    input wire clk,
    input wire reset,
    input wire enable,
    output reg [31:0] pc = 32'h0040_0000,
    input wire [31:0] instr,
    input wire [1:0] pcsel,
    input wire [1:0] wasel,
    input wire sext,
    input wire bsel,
    input wire [1:0] wdsel,
    input wire [4:0] alufn,
    input wire werf,
    input wire [1:0] asel,
    output wire Z,
    output wire [31:0] mem_addr,
    output wire [31:0] mem_writedata,
    input wire [31:0] mem_readdata
    );

    wire [4:0] shamt;
    wire [31:0] pcPlus4;
    wire [31:0] signImm;
    wire [31:0] J, JT, BT;
    wire [4:0] Rs, Rt, Rd;
    wire [31:0] ReadData1, ReadData2;
    wire [31:0] alu_result, aluA, aluB;
    wire [31:0] reg_writeaddr, reg_writedata;
    
    
    always_ff @(posedge clk) begin
        if(enable) begin
            if(reset) pc <= 32'h0040_0000;
            else pc <= (pcsel == 2'b11) ? JT                                        // program counter
                 : (pcsel == 2'b10) ? {pc[31:28], J, 2'b00}
                 : (pcsel == 2'b01) ? BT
                 : pcPlus4;
        end 
    end
    
    assign pcPlus4 = pc + 4; 
    
    assign JT = ReadData1;              //jumps and branches
    assign J = instr[25:0];
    assign BT = pcPlus4 + (signImm << 2);
    
    assign Rs = instr[25:21];                                                   //register file
    assign Rt = instr[20:16];
    assign Rd = instr[15:11];
    assign reg_writeaddr = (wasel == 2'b00) ? Rd : (wasel == 2'b01) 
                                            ? Rt : 31;
                                            
    assign reg_writedata = (wdsel == 2'b00) ? pcPlus4 : (wdsel == 2'b01) 
                                            ? alu_result : mem_readdata;
   
    register_file #(Dbits, Nloc) rf(                    
        clk, werf, Rs, Rt, reg_writeaddr, 
        reg_writedata, ReadData1, ReadData2
        );
    
    signExtend ext(sext, instr[15:0], signImm);         //module for sign extension
     
    assign aluA = (asel == 2'b00) ? ReadData1 : (asel == 2'b01) ? shamt : 16;
    assign aluB = (bsel == 1'b0) ? ReadData2 : signImm;  
    assign mem_addr = alu_result;                           //ALU 
    assign mem_writedata = ReadData2;
    assign shamt = instr[10:6];
   
    ALU #(Dbits) alu(aluA, aluB, alu_result, alufn, Z);
    
    
endmodule