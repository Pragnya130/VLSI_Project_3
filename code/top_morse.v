// top_morse.v
`timescale 1ns/1ps
module top_morse (
    input  wire        mode,        // 0 = morse->ascii (decode), 1 = ascii->morse (encode)
    input  wire [5:0]  morse_in,    // only valid when mode=0
    input  wire [2:0]  morse_in_len,
    input  wire [7:0]  ascii_in,    // only valid when mode=1
    output wire [7:0]  ascii_out,
    output wire        decode_valid,
    output wire [5:0]  morse_out,
    output wire [2:0]  morse_out_len,
    output wire        encode_valid
);
    morse_decoder dec (
        .morse_pattern(morse_in),
        .morse_len(morse_in_len),
        .ascii_out(ascii_out),
        .valid(decode_valid)
    );

    morse_encoder enc (
        .ascii_in(ascii_in),
        .morse_pattern(morse_out),
        .morse_len(morse_out_len),
        .valid(encode_valid)
    );

    // Note: top simply wires both directions. Use `mode` externally to choose outputs you care about.
endmodule
