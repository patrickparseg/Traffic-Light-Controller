`timescale 1ms / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/29/2024 12:20:16 PM
// Design Name: 
// Module Name: testbench
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


module testbench();
    reg clk;
    always #500 clk = ~clk;
    reg walk_button = 0;
    reg sensor = 0;
    reg rst = 0;
    wire [1:0] main_light;
    wire [1:0] side_light;
    wire walk_light;
    
    traffic_controller traf(.clk(clk), .walk_button(walk_button), .sensor(sensor), 
    .rst(rst), .main_light(main_light), .side_light(side_light), .walk_light(walk_light));
    
    initial begin
        clk = 1;
        rst = 0;
        #6000;
        rst = 1;        //check reset during main_green
        #1000;
        rst = 0;        //remove reset
        #5000;
        walk_button = 1;    //check walk button 
        #1000;
        walk_button = 0;    //turn off walkbutton
        #6000;
        sensor = 1;         //check sensor
        #15000;
        sensor = 0;         //turn off sensor
        walk_button = 1;    //turn on walk button
        #1000;
        walk_button = 0;    //turn walk button off
        #17000;
        rst = 1;            //reset
        #1000;
        rst = 0;
        #5000;
        sensor = 1;
        #12000;
        sensor = 0;
        #1000;
        walk_button = 1;        //check walk during side street green
        #1000;
        walk_button = 0;
    end
endmodule
