`timescale 1ns/1ps

module dual_port_ram #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4
)(
    // Port A
    input                       clk_a,
    input                       we_a,
    input  [ADDR_WIDTH-1:0]     addr_a,
    input  [DATA_WIDTH-1:0]     data_in_a,
    output reg [DATA_WIDTH-1:0] data_out_a,

    // Port B
    input                       clk_b,
    input                       we_b,
    input  [ADDR_WIDTH-1:0]     addr_b,
    input  [DATA_WIDTH-1:0]     data_in_b,
    output reg [DATA_WIDTH-1:0] data_out_b
);

    // Memory declaration
    reg [DATA_WIDTH-1:0] memory [0:(1<<ADDR_WIDTH)-1];

    // Port A operation
    always @(posedge clk_a) begin
        if (we_a)
            memory[addr_a] <= data_in_a;

        data_out_a <= memory[addr_a];
    end

    // Port B operation
    always @(posedge clk_b) begin
        if (we_b)
            memory[addr_b] <= data_in_b;

        data_out_b <= memory[addr_b];
    end

endmodule
