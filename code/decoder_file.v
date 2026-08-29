// morse_decoder.v  --  (8-bit patterns + error detection)
`timescale 1ns/1ps

module morse_decoder (
    input  wire [7:0] morse_pattern,   // expanded from 6 → 8 bits
    input  wire [3:0] morse_len,       // expanded from 3 → 4 bits
    output reg  [7:0] ascii_out,       // 'A'..'Z' else 0
    output reg        valid,
    output reg        error_flag       // NEW: error detection
);

    // ROM for Morse patterns (same patterns as encoder, but in 8 bits)
    reg [7:0] rom_pattern [0:25];
    reg [3:0] rom_len     [0:25];

    reg [7:0] mask;
    integer i;

    initial begin
        rom_pattern[0]  = 8'b00000001; rom_len[0]  = 4'd2; // A
        rom_pattern[1]  = 8'b00100000; rom_len[1]  = 4'd4; // B
        rom_pattern[2]  = 8'b00101000; rom_len[2]  = 4'd4; // C
        rom_pattern[3]  = 8'b00110000; rom_len[3]  = 4'd3; // D
        rom_pattern[4]  = 8'b00000000; rom_len[4]  = 4'd1; // E
        rom_pattern[5]  = 8'b00001000; rom_len[5]  = 4'd4; // F
        rom_pattern[6]  = 8'b00111000; rom_len[6]  = 4'd3; // G
        rom_pattern[7]  = 8'b00000000; rom_len[7]  = 4'd4; // H
        rom_pattern[8]  = 8'b00000000; rom_len[8]  = 4'd2; // I
        rom_pattern[9]  = 8'b00000111; rom_len[9]  = 4'd4; // J
        rom_pattern[10] = 8'b00101000; rom_len[10] = 4'd3; // K
        rom_pattern[11] = 8'b00000101; rom_len[11] = 4'd4; // L
        rom_pattern[12] = 8'b00000011; rom_len[12] = 4'd2; // M
        rom_pattern[13] = 8'b00000010; rom_len[13] = 4'd2; // N
        rom_pattern[14] = 8'b00001111; rom_len[14] = 4'd3; // O
        rom_pattern[15] = 8'b00000011; rom_len[15] = 4'd4; // P
        rom_pattern[16] = 8'b00110100; rom_len[16] = 4'd4; // Q
        rom_pattern[17] = 8'b00000001; rom_len[17] = 4'd3; // R
        rom_pattern[18] = 8'b00000000; rom_len[18] = 4'd3; // S
        rom_pattern[19] = 8'b00000001; rom_len[19] = 4'd1; // T
        rom_pattern[20] = 8'b00000000; rom_len[20] = 4'd3; // U
        rom_pattern[21] = 8'b00000001; rom_len[21] = 4'd4; // V
        rom_pattern[22] = 8'b00000011; rom_len[22] = 4'd3; // W
        rom_pattern[23] = 8'b00100010; rom_len[23] = 4'd4; // X
        rom_pattern[24] = 8'b00101010; rom_len[24] = 4'd4; // Y
        rom_pattern[25] = 8'b00110000; rom_len[25] = 4'd4; // Z
    end


    // Decode logic (same as before but updated)
    always @(*) begin
        ascii_out  = 8'h00;
        valid      = 1'b0;
        error_flag = 1'b0;
        mask       = 8'b00000000;

        if (morse_len != 0) begin
            mask = (8'b11111111 >> (8 - morse_len));  // dynamic mask for 1..8 bits

            for (i = 0; i < 26; i = i + 1) begin
                if (rom_len[i] == morse_len) begin
                    if ((rom_pattern[i] & mask) == (morse_pattern & mask)) begin
                        ascii_out = 8'h41 + i;
                        valid = 1'b1;
                    end
                end
            end
        end

        // --- NEW: Error detection ---
        if (valid == 1'b0)
            error_flag = 1'b1;
    end

endmodule

//6 bits characters to more characters and error detection added
