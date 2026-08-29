// top_morse.v
`timescale 1ns/1ps
module top_morse (
    input  wire        mode,        // 0 = decode, 1 = encode
    input  wire [5:0]  morse_in,
    input  wire [2:0]  morse_in_len,
    input  wire [7:0]  ascii_in,

    output wire [7:0]  ascii_out,
    output wire        decode_valid,

    output wire [5:0]  morse_out,
    output wire [2:0]  morse_out_len,
    output wire        encode_valid
);

    // Internal wires
    wire [7:0] dec_ascii;
    wire       dec_valid;

    wire [5:0] enc_morse;
    wire [2:0] enc_len;
    wire       enc_valid;

    // Decoder block
    morse_decoder dec (
        .morse_pattern(morse_in),
        .morse_len(morse_in_len),
        .ascii_out(dec_ascii),
        .valid(dec_valid)
    );

    // Encoder block
    morse_encoder enc (
        .ascii_in(ascii_in),
        .morse_pattern(enc_morse),
        .morse_len(enc_len),
        .valid(enc_valid)
    );

    // -----------------------------
    // OUTPUT SELECTION USING MODE
    // -----------------------------

    // When mode = 0 -> decoder output
    assign ascii_out     = (mode == 0) ? dec_ascii  : 8'd0;
    assign decode_valid  = (mode == 0) ? dec_valid  : 1'b0;

    // When mode = 1 -> encoder output
    assign morse_out     = (mode == 1) ? enc_morse  : 6'd0;
    assign morse_out_len = (mode == 1) ? enc_len    : 3'd0;
    assign encode_valid  = (mode == 1) ? enc_valid  : 1'b0;

endmodule
