`timescale 1ns/1ps

module tb_dual_port_ram;

    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 4;

    // Port A signals
    reg                       clk_a;
    reg                       we_a;
    reg [ADDR_WIDTH-1:0]      addr_a;
    reg [DATA_WIDTH-1:0]      data_in_a;
    wire [DATA_WIDTH-1:0]     data_out_a;

    // Port B signals
    reg                       clk_b;
    reg                       we_b;
    reg [ADDR_WIDTH-1:0]      addr_b;
    reg [DATA_WIDTH-1:0]      data_in_b;
    wire [DATA_WIDTH-1:0]     data_out_b;

    // Instantiate DUT
    dual_port_ram #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) dut (
        .clk_a(clk_a),
        .we_a(we_a),
        .addr_a(addr_a),
        .data_in_a(data_in_a),
        .data_out_a(data_out_a),

        .clk_b(clk_b),
        .we_b(we_b),
        .addr_b(addr_b),
        .data_in_b(data_in_b),
        .data_out_b(data_out_b)
    );

    // Clock A: 10 ns period
    initial begin
        clk_a = 0;
        forever #5 clk_a = ~clk_a;
    end

    // Clock B: 14 ns period
    initial begin
        clk_b = 0;
        forever #7 clk_b = ~clk_b;
    end

    // Test procedure
    initial begin

        // Initialize signals
        we_a     = 0;
        addr_a   = 0;
        data_in_a = 0;

        we_b     = 0;
        addr_b   = 0;
        data_in_b = 0;

        #10;

        // ---------------------------------------
        // Test 1: Write using Port A
        // ---------------------------------------
        @(negedge clk_a);

        we_a      = 1;
        addr_a    = 4'd3;
        data_in_a = 8'hAA;

        @(negedge clk_a);

        we_a = 0;

        $display("Test 1: Port A wrote AA to address 3");

        // ---------------------------------------
        // Test 2: Read using Port B
        // ---------------------------------------
        @(negedge clk_b);

        we_b   = 0;
        addr_b = 4'd3;

        @(posedge clk_b);

        #1;

        if (data_out_b == 8'hAA)
            $display("Test 2 PASS: Port B read AA from address 3");
        else
            $display("Test 2 FAIL: Expected AA, got %h",
                     data_out_b);

        // ---------------------------------------
        // Test 3: Write using Port B
        // ---------------------------------------
        @(negedge clk_b);

        we_b      = 1;
        addr_b    = 4'd7;
        data_in_b = 8'h55;

        @(negedge clk_b);

        we_b = 0;

        $display("Test 3: Port B wrote 55 to address 7");

        // ---------------------------------------
        // Test 4: Read using Port A
        // ---------------------------------------
        @(negedge clk_a);

        we_a   = 0;
        addr_a = 4'd7;

        @(posedge clk_a);

        #1;

        if (data_out_a == 8'h55)
            $display("Test 4 PASS: Port A read 55 from address 7");
        else
            $display("Test 4 FAIL: Expected 55, got %h",
                     data_out_a);

        // ---------------------------------------
        // Test 5: Simultaneous operations
        // ---------------------------------------
        @(negedge clk_a);
        @(negedge clk_b);

        we_a      = 1;
        addr_a    = 4'd5;
        data_in_a = 8'hF0;

        we_b      = 1;
        addr_b    = 4'd9;
        data_in_b = 8'h0F;

        @(negedge clk_a);
        we_a = 0;

        @(negedge clk_b);
        we_b = 0;

        $display("Test 5: Simultaneous writes completed");

        // ---------------------------------------
        // Test 6: Read address 5 using Port B
        // ---------------------------------------
        @(negedge clk_b);

        addr_b = 4'd5;

        @(posedge clk_b);

        #1;

        if (data_out_b == 8'hF0)
            $display("Test 6 PASS: Port B read F0 from address 5");
        else
            $display("Test 6 FAIL: Expected F0, got %h",
                     data_out_b);

        // ---------------------------------------
        // Test 7: Read address 9 using Port A
        // ---------------------------------------
        @(negedge clk_a);

        addr_a = 4'd9;

        @(posedge clk_a);

        #1;

        if (data_out_a == 8'h0F)
            $display("Test 7 PASS: Port A read 0F from address 9");
        else
            $display("Test 7 FAIL: Expected 0F, got %h",
                     data_out_a);

        // ---------------------------------------
        // Finish simulation
        // ---------------------------------------
        #20;

        $display("--------------------------------------");
        $display("Dual-Port RAM Testbench Completed");
        $display("--------------------------------------");

        $finish;
    end

endmodule
