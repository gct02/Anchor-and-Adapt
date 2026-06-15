`timescale 1 ps / 1 ps

module adpcm_main_tb;

    parameter SIZE = 100;
    parameter CLK_PERIOD = 8000; // Target clock

    // Testbench Signals
    reg ap_clk;
    reg ap_rst;
    reg ap_start;
    wire ap_done;
    wire ap_idle;
    wire ap_ready;

    // in_data Interface
    wire [6:0]  in_data_address0;
    wire        in_data_ce0;
    reg  [31:0] in_data_q0;
    wire [6:0]  in_data_address1;
    wire        in_data_ce1;
    reg  [31:0] in_data_q1;

    // encoded Interface
    wire [5:0]  encoded_address0;
    wire        encoded_ce0;
    wire        encoded_we0;
    wire [31:0] encoded_d0;
    reg  [31:0] encoded_q0;

    // decoded Interface
    wire [6:0]  decoded_address0;
    wire        decoded_ce0;
    wire        decoded_we0;
    wire [31:0] decoded_d0;
    wire [6:0]  decoded_address1;
    wire        decoded_ce1;
    wire        decoded_we1;
    wire [31:0] decoded_d1;

    // Memory Models
    reg [31:0] in_data_mem[0:SIZE-1];
    reg [31:0] encoded_mem[0:SIZE/2-1];
    reg [31:0] decoded_mem[0:SIZE-1];

    // Instantiate the DUT
    bd_0 DUT (
        .ap_clk(ap_clk),
        .ap_rst(ap_rst),
        .ap_ctrl_start(ap_start),
        .ap_ctrl_done(ap_done),
        .ap_ctrl_idle(ap_idle),
        .ap_ctrl_ready(ap_ready),
        .in_data_address0(in_data_address0),
        .in_data_ce0(in_data_ce0),
        .in_data_q0(in_data_q0),
        .in_data_address1(in_data_address1),
        .in_data_ce1(in_data_ce1),
        .in_data_q1(in_data_q1),
        .encoded_address0(encoded_address0),
        .encoded_ce0(encoded_ce0),
        .encoded_we0(encoded_we0),
        .encoded_d0(encoded_d0),
        .encoded_q0(encoded_q0),
        .decoded_address0(decoded_address0),
        .decoded_ce0(decoded_ce0),
        .decoded_we0(decoded_we0),
        .decoded_d0(decoded_d0),
        .decoded_address1(decoded_address1),
        .decoded_ce1(decoded_ce1),
        .decoded_we1(decoded_we1),
        .decoded_d1(decoded_d1)
    );

    // Clock Generation
    always #(CLK_PERIOD/2) ap_clk = ~ap_clk;

    // Memory Read/Write Logic
    always @(posedge ap_clk) begin
        if (in_data_ce0 == 1) begin
            in_data_q0 <= in_data_mem[in_data_address0];
        end
        if (in_data_ce1 == 1) begin
            in_data_q1 <= in_data_mem[in_data_address1];
        end
        
        if (encoded_ce0 == 1) begin
            if (encoded_we0 == 1) begin
                encoded_mem[encoded_address0] <= encoded_d0;
            end
            encoded_q0 <= encoded_mem[encoded_address0];
        end

        if (decoded_ce0 == 1) begin
            if (decoded_we0 == 1) begin
                decoded_mem[decoded_address0] <= decoded_d0;
            end
        end
        
        if (decoded_ce1 == 1) begin
            if (decoded_we1 == 1) begin
                decoded_mem[decoded_address1] <= decoded_d1;
            end
        end
    end

    // Main Simulation Sequence
    initial begin
        ap_clk = 0;
        ap_rst = 1;
        ap_start = 0;

        in_data_mem[0 ] = 32'h44; in_data_mem[1 ] = 32'h44; in_data_mem[2 ] = 32'h44; in_data_mem[3 ] = 32'h44; in_data_mem[4 ] = 32'h44;
        in_data_mem[5 ] = 32'h44; in_data_mem[6 ] = 32'h44; in_data_mem[7 ] = 32'h44; in_data_mem[8 ] = 32'h44; in_data_mem[9 ] = 32'h44;
        in_data_mem[10] = 32'h44; in_data_mem[11] = 32'h44; in_data_mem[12] = 32'h44; in_data_mem[13] = 32'h44; in_data_mem[14] = 32'h44;
        in_data_mem[15] = 32'h44; in_data_mem[16] = 32'h44; in_data_mem[17] = 32'h43; in_data_mem[18] = 32'h43; in_data_mem[19] = 32'h43;
        in_data_mem[20] = 32'h43; in_data_mem[21] = 32'h43; in_data_mem[22] = 32'h43; in_data_mem[23] = 32'h43; in_data_mem[24] = 32'h42;
        in_data_mem[25] = 32'h42; in_data_mem[26] = 32'h42; in_data_mem[27] = 32'h42; in_data_mem[28] = 32'h42; in_data_mem[29] = 32'h42;
        in_data_mem[30] = 32'h41; in_data_mem[31] = 32'h41; in_data_mem[32] = 32'h41; in_data_mem[33] = 32'h41; in_data_mem[34] = 32'h41;
        in_data_mem[35] = 32'h40; in_data_mem[36] = 32'h40; in_data_mem[37] = 32'h40; in_data_mem[38] = 32'h40; in_data_mem[39] = 32'h40;
        in_data_mem[40] = 32'h40; in_data_mem[41] = 32'h40; in_data_mem[42] = 32'h40; in_data_mem[43] = 32'h3f; in_data_mem[44] = 32'h3f;
        in_data_mem[45] = 32'h3f; in_data_mem[46] = 32'h3f; in_data_mem[47] = 32'h3f; in_data_mem[48] = 32'h3e; in_data_mem[49] = 32'h3e;
        in_data_mem[50] = 32'h3e; in_data_mem[51] = 32'h3e; in_data_mem[52] = 32'h3e; in_data_mem[53] = 32'h3e; in_data_mem[54] = 32'h3d;
        in_data_mem[55] = 32'h3d; in_data_mem[56] = 32'h3d; in_data_mem[57] = 32'h3d; in_data_mem[58] = 32'h3d; in_data_mem[59] = 32'h3d;
        in_data_mem[60] = 32'h3c; in_data_mem[61] = 32'h3c; in_data_mem[62] = 32'h3c; in_data_mem[63] = 32'h3c; in_data_mem[64] = 32'h3c;
        in_data_mem[65] = 32'h3c; in_data_mem[66] = 32'h3c; in_data_mem[67] = 32'h3c; in_data_mem[68] = 32'h3c; in_data_mem[69] = 32'h3b;
        in_data_mem[70] = 32'h3b; in_data_mem[71] = 32'h3b; in_data_mem[72] = 32'h3b; in_data_mem[73] = 32'h3b; in_data_mem[74] = 32'h3b;
        in_data_mem[75] = 32'h3b; in_data_mem[76] = 32'h3b; in_data_mem[77] = 32'h3b; in_data_mem[78] = 32'h3b; in_data_mem[79] = 32'h3b;
        in_data_mem[80] = 32'h3b; in_data_mem[81] = 32'h3b; in_data_mem[82] = 32'h3b; in_data_mem[83] = 32'h3b; in_data_mem[84] = 32'h3b;
        in_data_mem[85] = 32'h3b; in_data_mem[86] = 32'h3b; in_data_mem[87] = 32'h3b; in_data_mem[88] = 32'h3b; in_data_mem[89] = 32'h3b;
        in_data_mem[90] = 32'h3b; in_data_mem[91] = 32'h3b; in_data_mem[92] = 32'h3c; in_data_mem[93] = 32'h3c; in_data_mem[94] = 32'h3c;
        in_data_mem[95] = 32'h3c; in_data_mem[96] = 32'h3c; in_data_mem[97] = 32'h3c; in_data_mem[98] = 32'h3c; in_data_mem[99] = 32'h3c;

        #10000;
        ap_rst = 0;
        #10000;
        ap_start = 1;
        #100000;
        ap_start = 0;

        wait (ap_done == 1);
        $display("ADPCM kernel processing finished.");
        
        display_results;

        #10000;
        $finish;
    end

    task display_results;
        integer i;
        begin
            $display("\nEncoded Data:");
            for (i = 0; i < SIZE/2; i = i + 1) begin
                $display("encoded_mem[%0d] = %h", i, encoded_mem[i]);
            end

            $display("\nDecoded Data:");
            for (i = 0; i < SIZE; i = i + 1) begin
                $display("decoded_mem[%0d] = %h", i, decoded_mem[i]);
            end
        end
    endtask

endmodule