// morse_encoder.v  --  bits + error detection
`timescale 1ns/1ps

module morse_encoder (
    input  wire [7:0] ascii_in,          // 'A'..'Z' uppercase
    output reg  [7:0] morse_pattern,     // expanded from 6 bits → 8 bits
    output reg  [3:0] morse_len,         // expanded from 3 bits → 4 bits
    output reg        valid,
    output reg        error_flag         // NEW: indicates invalid ASCII
);

    always @(*) begin
        // default outputs
        morse_pattern = 8'b00000000;
        morse_len     = 4'd0;
        valid         = 1'b0;
        error_flag    = 1'b0;

        case (ascii_in)
            "A": begin morse_pattern = 8'b00000001; morse_len = 4'd2; valid = 1'b1; end
            "B": begin morse_pattern = 8'b00100000; morse_len = 4'd4; valid = 1'b1; end
            "C": begin morse_pattern = 8'b00101000; morse_len = 4'd4; valid = 1'b1; end
            "D": begin morse_pattern = 8'b00110000; morse_len = 4'd3; valid = 1'b1; end
            "E": begin morse_pattern = 8'b00000000; morse_len = 4'd1; valid = 1'b1; end
            "F": begin morse_pattern = 8'b00001000; morse_len = 4'd4; valid = 1'b1; end
            "G": begin morse_pattern = 8'b00111000; morse_len = 4'd3; valid = 1'b1; end
            "H": begin morse_pattern = 8'b00000000; morse_len = 4'd4; valid = 1'b1; end
            "I": begin morse_pattern = 8'b00000000; morse_len = 4'd2; valid = 1'b1; end
            "J": begin morse_pattern = 8'b00000111; morse_len = 4'd4; valid = 1'b1; end
            "K": begin morse_pattern = 8'b00101000; morse_len = 4'd3; valid = 1'b1; end
            "L": begin morse_pattern = 8'b00000101; morse_len = 4'd4; valid = 1'b1; end
            "M": begin morse_pattern = 8'b00000011; morse_len = 4'd2; valid = 1'b1; end
            "N": begin morse_pattern = 8'b00000010; morse_len = 4'd2; valid = 1'b1; end
            "O": begin morse_pattern = 8'b00001111; morse_len = 4'd3; valid = 1'b1; end
            "P": begin morse_pattern = 8'b00000011; morse_len = 4'd4; valid = 1'b1; end
            "Q": begin morse_pattern = 8'b00110100; morse_len = 4'd4; valid = 1'b1; end
            "R": begin morse_pattern = 8'b00000001; morse_len = 4'd3; valid = 1'b1; end
            "S": begin morse_pattern = 8'b00000000; morse_len = 4'd3; valid = 1'b1; end
            "T": begin morse_pattern = 8'b00000001; morse_len = 4'd1; valid = 1'b1; end
            "U": begin morse_pattern = 8'b00000000; morse_len = 4'd3; valid = 1'b1; end
            "V": begin morse_pattern = 8'b00000001; morse_len = 4'd4; valid = 1'b1; end
            "W": begin morse_pattern = 8'b00000011; morse_len = 4'd3; valid = 1'b1; end
            "X": begin morse_pattern = 8'b00100010; morse_len = 4'd4; valid = 1'b1; end
            "Y": begin morse_pattern = 8'b00101010; morse_len = 4'd4; valid = 1'b1; end
            "Z": begin morse_pattern = 8'b00110000; morse_len = 4'd4; valid = 1'b1; end

            default: begin
                valid      = 1'b0;
                error_flag = 1'b1;   // NEW: invalid ASCII detected
            end
        endcase
    end

endmodule


//includede 6 bits ASCI characters to more number of cahracters and error flag added
