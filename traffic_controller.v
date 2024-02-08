//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/29/2024 12:15:51 PM
// Design Name: 
// Module Name: traffic_controller
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


module traffic_controller(
    input clk,
    input walk_button,
    input sensor,
    input rst,
    output reg [1:0] main_light,
    output reg [1:0] side_light,
    output walk_light
    );
    
    parameter SIZE = 3;
    parameter GREEN = 2'b10, YELLOW = 2'b01, RED = 2'b00;
    parameter main_green = 3'b000, main_yellow = 3'b001, side_green = 3'b010, side_yellow = 3'b011, all_red = 3'b100;
    
    reg [SIZE-1:0] state = main_green;
    reg [SIZE-1:0] next_state;
    
    integer count = 0;
    integer walk_on = 0;
    integer walk_light = 0;
    integer main_target = 12;
    integer side_target = 6;

    //State Control
    always @(posedge clk) begin
        if (rst == 1) begin
            count = 0;
            state <= main_green;
        end
        else if (walk_button == 1) begin
            walk_on = 1;
        end
    end
    
    //OUTPUTS
    always @(posedge clk) begin
        if (rst == 1) begin
            main_light <= GREEN;
            side_light <= RED;
            count = count + 1;
        end
        else begin
            case(state)
                main_green: begin
                    main_light <= GREEN;
                    side_light <= RED;
                    count = count + 1;
                    if (count == 6) begin
                        if (sensor == 1) begin
                            main_target = 9;
                        end
                    end
                    if (count == main_target) begin
                        state <= main_yellow;
                        count = 0;
                        main_target = 12;
                    end
                end
                main_yellow: begin
                    main_light <= YELLOW;
                    side_light <= RED;
                    count = count + 1;
                    if (count == 2) begin
                        if (walk_on == 1) begin
                            count = 0;
                            state <= all_red;
                        end
                        else begin
                            state <= side_green;
                            count = 0;
                        end
                    end
                end  
                side_green: begin
                    side_light <= GREEN;
                    main_light <= RED;
                    count = count + 1;
                    walk_light = 0;
                    if (count == 6) begin
                        if (sensor == 1) begin
                            side_target = 9;
                        end
                    end
                    if (count == side_target) begin
                        state <= side_yellow;
                        count = 0;
                        side_target = 6;
                    end
                end
                side_yellow: begin
                    side_light <= YELLOW;
                    main_light <= RED;
                    count = count + 1;
                    if (count == 2) begin
                        state <= main_green;
                        count = 0;
                    end
                end
                all_red: begin
                    side_light <= RED;
                    main_light <= RED;
                    count = count + 1;
                    walk_on = 0;
                    walk_light = 1;
                    if (count == 3) begin
                        state <= side_green;
                        count = 0;
                    end
                end
            endcase
          end
        end

    
endmodule
