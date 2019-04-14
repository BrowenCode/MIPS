`timescale 1ns / 1ps
`default_nettype none
`include "display640x480.vh"

module top #(
    parameter imem_init="imem.mem", 	        // use this line for synthesis/board deployment
//    parameter imem_init="imem_screentest_nopause.mem",  // use this line for simulation/testing
    parameter dmem_init="dmem.mem",          // file to initialize data memory
    parameter smem_init="smem.mem", 	        // file to initialize screen memory
    parameter bmem_init="bmem.mem" 	        // file to initialize bitmap memory
)(
 
    input wire clk, reset,
    input wire ps2_clk, ps2_data,
    output wire hsync, vsync,
    output wire [3:0] red, green, blue,
    output wire [7:0] segments, digitselect,
    output wire audPWM, audEn,
    output wire [15:0] LED,
    
    //Accelerometer signals
    output wire aclSCK,
    output wire aclMOSI,
    input wire aclMISO,
    output wire aclSS
    );

    wire mem_wr;
    wire [31:0] pc, instr, mem_readdata, mem_writedata, mem_addr;
    wire [3:0] charcode;
    wire [10:0] smem_addr;
    wire [31:0] keyb_char;
    wire [`xbits-1:0] x;
    wire [`ybits-1:0] y;
    wire enable = 1'b1;
    wire [11:0] accelTmp;
    wire [31:0] period;
    
    wire [8:0] accelX, accelY;
   
    
    wire clk100, clk50, clk25, clk12;

    clockdivider_Nexys4 clkdv(clk, clk100, clk50, clk25, clk12);   // use this line for synthesis/board deployment
//   assign clk100=clk; assign clk50=clk; assign clk25=clk; assign clk12=clk;  // use this line for simulation/testing
   
    imem #(.Nloc(512), .Dbits(32), .initfile(imem_init)) imem(pc[31:2], instr);
 
    mips mips(clk12, reset, enable, pc, instr, mem_wr, mem_addr, mem_writedata, mem_readdata);
        
    memIO #(.Nloc(16), .Dbits(32), .dmem_init(dmem_init), .smem_init(smem_init)) memIO(clk, mem_wr, mem_addr, mem_readdata, mem_writedata, charcode, smem_addr, keyb_char, accelX, accelY, period, LED);

    vgadisplaydriver display(clk100, charcode, red, green, blue, hsync, vsync, smem_addr, x , y);

    keyboard keyb(clk100, ps2_clk, ps2_data, keyb_char);
    
    display8digit disp(keyb_char, clk100, segments, digitselect);
    
    accelerometer accel(clk100, aclSCK, aclMOSI, aclMISO, aclSS, accelX, accelY, accelTmp);

    montek_sound_Nexys4 sound(clk100, period, audPWM);
    
    assign audEn = 1;
    
endmodule