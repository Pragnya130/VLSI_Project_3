// morse_encoder.v  -- memory-free case-based lookup (Vivado-friendly)
`timescale 1ns/1ps

module morse_encoder (
    input  wire [7:0] ascii_in,      // 'A'..'Z' uppercase
    output reg  [5:0] morse_pattern, // bits [len-1:0]
    output reg  [2:0] morse_len,
    output reg        valid
);

    always @(*) begin
        // default outputs
        morse_pattern = 6'b000000;
        morse_len     = 3'd0;
        valid         = 1'b0;

        case (ascii_in)
            "A": begin morse_pattern = 6'b000001; morse_len = 3'd2; valid = 1'b1; end
            "B": begin morse_pattern = 6'b001000; morse_len = 3'd4; valid = 1'b1; end
            "C": begin morse_pattern = 6'b001010; morse_len = 3'd4; valid = 1'b1; end
            "D": begin morse_pattern = 6'b001100; morse_len = 3'd3; valid = 1'b1; end
            "E": begin morse_pattern = 6'b000000; morse_len = 3'd1; valid = 1'b1; end
            "F": begin morse_pattern = 6'b000010; morse_len = 3'd4; valid = 1'b1; end
            "G": begin morse_pattern = 6'b001110; morse_len = 3'd3; valid = 1'b1; end
            "H": begin morse_pattern = 6'b000000; morse_len = 3'd4; valid = 1'b1; end
            "I": begin morse_pattern = 6'b000000; morse_len = 3'd2; valid = 1'b1; end
            "J": begin morse_pattern = 6'b000111; morse_len = 3'd4; valid = 1'b1; end
            "K": begin morse_pattern = 6'b001010; morse_len = 3'd3; valid = 1'b1; end
            "L": begin morse_pattern = 6'b000101; morse_len = 3'd4; valid = 1'b1; end
            "M": begin morse_pattern = 6'b000110; morse_len = 3'd2; valid = 1'b1; end
            "N": begin morse_pattern = 6'b000100; morse_len = 3'd2; valid = 1'b1; end
            "O": begin morse_pattern = 6'b001111; morse_len = 3'd3; valid = 1'b1; end
            "P": begin morse_pattern = 6'b000011; morse_len = 3'd4; valid = 1'b1; end
            "Q": begin morse_pattern = 6'b001101; morse_len = 3'd4; valid = 1'b1; end
            "R": begin morse_pattern = 6'b000001; morse_len = 3'd3; valid = 1'b1; end
            "S": begin morse_pattern = 6'b000000; morse_len = 3'd3; valid = 1'b1; end
            "T": begin morse_pattern = 6'b000001; morse_len = 3'd1; valid = 1'b1; end
            "U": begin morse_pattern = 6'b000000; morse_len = 3'd3; valid = 1'b1; end
            "V": begin morse_pattern = 6'b000001; morse_len = 3'd4; valid = 1'b1; end
            "W": begin morse_pattern = 6'b000011; morse_len = 3'd3; valid = 1'b1; end
            "X": begin morse_pattern = 6'b001001; morse_len = 3'd4; valid = 1'b1; end
            "Y": begin morse_pattern = 6'b001011; morse_len = 3'd4; valid = 1'b1; end
            "Z": begin morse_pattern = 6'b001100; morse_len = 3'd4; valid = 1'b1; end
            default: begin morse_pattern = 6'b000000; morse_len = 3'd0; valid = 1'b0; end
        endcase
    end

endmodule
