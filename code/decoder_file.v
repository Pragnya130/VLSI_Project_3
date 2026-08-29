// morse_decoder.v
`timescale 1ns/1ps

module morse_decoder (
    input  wire [5:0] morse_pattern,   // bits [len-1:0], 0=dot, 1=dash
    input  wire [2:0] morse_len,       // valid range 1..6 (0 = no symbol)
    output reg  [7:0] ascii_out,       // 'A'..'Z' else 0
    output reg        valid
);

    // ROM for Morse patterns
    reg [5:0] rom_pattern [0:25];
    reg [2:0] rom_len     [0:25];

    reg [5:0] mask;
    integer i;

    initial begin
        // A = .-     (01)
        rom_pattern[0]  = 6'b000001; rom_len[0]  = 3'd2; 
        rom_pattern[1]  = 6'b001000; rom_len[1]  = 3'd4; // B
        rom_pattern[2]  = 6'b001010; rom_len[2]  = 3'd4; // C
        rom_pattern[3]  = 6'b001100; rom_len[3]  = 3'd3; // D
        rom_pattern[4]  = 6'b000000; rom_len[4]  = 3'd1; // E
        rom_pattern[5]  = 6'b000010; rom_len[5]  = 3'd4; // F
        rom_pattern[6]  = 6'b001110; rom_len[6]  = 3'd3; // G
        rom_pattern[7]  = 6'b000000; rom_len[7]  = 3'd4; // H
        rom_pattern[8]  = 6'b000000; rom_len[8]  = 3'd2; // I
        rom_pattern[9]  = 6'b000111; rom_len[9]  = 3'd4; // J
        rom_pattern[10] = 6'b001010; rom_len[10] = 3'd3; // K
        rom_pattern[11] = 6'b000101; rom_len[11] = 3'd4; // L
        rom_pattern[12] = 6'b000110; rom_len[12] = 3'd2; // M
        rom_pattern[13] = 6'b000100; rom_len[13] = 3'd2; // N
        rom_pattern[14] = 6'b001111; rom_len[14] = 3'd3; // O
        rom_pattern[15] = 6'b000011; rom_len[15] = 3'd4; // P
        rom_pattern[16] = 6'b001101; rom_len[16] = 3'd4; // Q
        rom_pattern[17] = 6'b000001; rom_len[17] = 3'd3; // R
        rom_pattern[18] = 6'b000000; rom_len[18] = 3'd3; // S
        rom_pattern[19] = 6'b000001; rom_len[19] = 3'd1; // T
        rom_pattern[20] = 6'b000000; rom_len[20] = 3'd3; // U
        rom_pattern[21] = 6'b000001; rom_len[21] = 3'd4; // V
        rom_pattern[22] = 6'b000011; rom_len[22] = 3'd3; // W
        rom_pattern[23] = 6'b001001; rom_len[23] = 3'd4; // X
        rom_pattern[24] = 6'b001011; rom_len[24] = 3'd4; // Y
        rom_pattern[25] = 6'b001100; rom_len[25] = 3'd4; // Z
    end


    // Decode logic using a runtime mask (Verilog-2001 compatible)
    always @(*) begin
        ascii_out = 8'h00;
        valid = 1'b0;
        mask = 6'b000000;

        // create mask that has lower morse_len bits set:
        // mask = 6'b111111 >> (6 - morse_len)  (works for morse_len in 1..6)
        if (morse_len != 0) begin
            mask = (6'b111111 >> (6 - morse_len)); // variable shift is allowed
            for (i = 0; i < 26; i = i + 1) begin
                if (rom_len[i] == morse_len) begin
                    if ((rom_pattern[i] & mask) == (morse_pattern & mask)) begin
                        ascii_out = 8'h41 + i;
                        valid = 1'b1;
                    end
                end
            end
        end
    end

endmodule
