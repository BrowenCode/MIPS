# MIPS
Fully functional MIPS processor with custom ALU. Written in System Verilog. Built onto Artix FPGA. This project was done for Montek Singh's Digital Logic and Design class at UNC Chapel Hill.

The ALU is designed to process an arbitrary MIPS program with the following memory configurations:

.text 0x=00400000

.data 0x10010000

assembly files/final_demo_main.asm is a simple MIPS assembly program to demonstrate processor functionality. It utilizes a memory mapped IO scheme to draw to the monitor and interact with keyboard and produce sound, as well as input from the Artix FPGA built-in accellerometer. 
