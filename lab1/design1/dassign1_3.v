// EEM16 - Logic Design
// Design Assignment #1 - Problem #1.3
// dassign1_3.v
// Verilog template

// You may define any additional modules as necessary
// Do not change the module or port names of the given stubs

/* Arrays for convenience

  | abcdefghijklmnopqrstuvwxyz  <-- letter
__|___________________________
G | 11111111001001111111000111
F | 11001111001100011010101010
E | 11111101011111110100110001
D | 01111010011100100010111111
C | 11010011110011101011110010
B | 10010011110000011001101011
A | 10001110000010011010000101
^-- display segment
~~~

  | GFEDCBA <-- display segment
__|________
a | 1110111
b | 1111100
c | 1011000
d | 1011110
e | 1111001
f | 1110001
g | 1101111
h | 1110110
i | 0000110
j | 0011110
k | 1111000
l | 0111000
m | 0010101
n | 1010100
o | 1011100
p | 1110011
q | 1100111
r | 1010000
s | 1101101
t | 1000110
u | 0111110
v | 0011100
w | 0101010
x | 1001001
y | 1101110
z | 1011011
^-- letter
*/

// Display driver (procedural verilog)
// IMPORTANT: Do not change module or port names
module display_rom (letter, display);
    input   [4:0] letter;
    output  [6:0] display;
    // your code here
    // do not use any delays!

    reg [6:0] tmp;

    always @*
    case (letter)
        5'b00000 : tmp = 7'b1110111;
        5'b00001 : tmp = 7'b1111100;
        5'b00010 : tmp = 7'b1011000; 
        5'b00011 : tmp = 7'b1011110;
        5'b00100 : tmp = 7'b1111001;
        5'b00101 : tmp = 7'b1110001;  
        5'b00110 : tmp = 7'b1101111;
        5'b00111 : tmp = 7'b1110110;
        5'b01000 : tmp = 7'b0000110;
        5'b01001 : tmp = 7'b0011110;
        5'b01010 : tmp = 7'b1111000; 
        5'b01011 : tmp = 7'b0111000;
        5'b01100 : tmp = 7'b0010101;
        5'b01101 : tmp = 7'b1010100;
        5'b01110 : tmp = 7'b1011100;
        5'b01111 : tmp = 7'b1110011;
        5'b10000 : tmp = 7'b1100111;
        5'b10001 : tmp = 7'b1010000;
        5'b10010 : tmp = 7'b1101101; 
        5'b10011 : tmp = 7'b1000110;
        5'b10100 : tmp = 7'b0111110;
        5'b10101 : tmp = 7'b0011100;  
        5'b10110 : tmp = 7'b0101010;
        5'b10111 : tmp = 7'b1001001;
        5'b11000 : tmp = 7'b1101110;
        5'b11001 : tmp = 7'b1011011;
        5'b11010 : tmp = 7'b1000000; 
        5'b11011 : tmp = 7'b1000000;
        5'b11100 : tmp = 7'b1000000;
        5'b11101 : tmp = 7'b1000000;
        5'b11110 : tmp = 7'b1000000;
        5'b11111 : tmp = 7'b1000000;
    endcase  

    assign display = tmp;  

endmodule

module mux32(in, s, out);
    input [31:0] in;
    input [4:0] s;
    output out;

    assign out = (in[31] & ~s[4] & ~s[3] & ~s[2] & ~s[1] & ~s[0]) | (in[30] & ~s[4] & ~s[3] & ~s[2] & ~s[1] & s[0]) | (in[29] & ~s[4] & ~s[3] & ~s[2] & s[1] & ~s[0]) | (in[28] & ~s[4] & ~s[3] & ~s[2] & s[1] & s[0]) | (in[27] & ~s[4] & ~s[3] & s[2] & ~s[1] & ~s[0]) | (in[26] & ~s[4] & ~s[3] & s[2] & ~s[1] & s[0]) | (in[25] & ~s[4] & ~s[3] & s[2] & s[1] & ~s[0]) | (in[24] & ~s[4] & ~s[3] & s[2] & s[1] & s[0]) | (in[23] & ~s[4] & s[3] & ~s[2] & ~s[1] & ~s[0]) | (in[22] & ~s[4] & s[3] & ~s[2] & ~s[1] & s[0]) | (in[21] & ~s[4] & s[3] & ~s[2] & s[1] & ~s[0]) | (in[20] & ~s[4] & s[3] & ~s[2] & s[1] & s[0]) | (in[19] & ~s[4] & s[3] & s[2] & ~s[1] & ~s[0]) | (in[18] & ~s[4] & s[3] & s[2] & ~s[1] & s[0]) | (in[17] & ~s[4] & s[3] & s[2] & s[1] & ~s[0]) | (in[16] & ~s[4] & s[3] & s[2] & s[1] & s[0]) | (in[15] & s[4] & ~s[3] & ~s[2] & ~s[1] & ~s[0]) | (in[14] & s[4] & ~s[3] & ~s[2] & ~s[1] & s[0]) | (in[13] & s[4] & ~s[3] & ~s[2] & s[1] & ~s[0]) | (in[12] & s[4] & ~s[3] & ~s[2] & s[1] & s[0]) | (in[11] & s[4] & ~s[3] & s[2] & ~s[1] & ~s[0]) | (in[10] & s[4] & ~s[3] & s[2] & ~s[1] & s[0]) | (in[9] & s[4] & ~s[3] & s[2] & s[1] & ~s[0]) | (in[8] & s[4] & ~s[3] & s[2] & s[1] & s[0]) | (in[7] & s[4] & s[3] & ~s[2] & ~s[1] & ~s[0]) | (in[6] & s[4] & s[3] & ~s[2] & ~s[1] & s[0]) | (in[5] & s[4] & s[3] & ~s[2] & s[1] & ~s[0]) | (in[4] & s[4] & s[3] & ~s[2] & s[1] & s[0]) | (in[3] & s[4] & s[3] & s[2] & ~s[1] & ~s[0]) | (in[2] & s[4] & s[3] & s[2] & ~s[1] & s[0]) | (in[1] & s[4] & s[3] & s[2] & s[1] & ~s[0]) | (in[0] & s[4] & s[3] & s[2] & s[1] & s[0]);

endmodule

// Display driver (declarative verilog)
// IMPORTANT: Do not change module or port names
module display_mux (letter, g,f,e,d,c,b,a);
    input   [4:0] letter;
    output  g,f,e,d,c,b,a;
    // your code here
    // do not use any delays!

    mux32 mux32_g(32'b11111111001001111111000111111111, letter, g);
    mux32 mux32_f(32'b11001111001100011010101010000000, letter, f);
    mux32 mux32_e(32'b11111101011111110100110001000000, letter, e);
    mux32 mux32_d(32'b01111010011100100010111111000000, letter, d);
    mux32 mux32_c(32'b11010011110011101011110010000000, letter, c);
    mux32 mux32_b(32'b10010011110000011001101011000000, letter, b);
    mux32 mux32_a(32'b10001110000010011010000101000000, letter, a);


endmodule
