`default_nettype none

// Keep I/O fixed for TinyTapeout
module user_module_341173288630747730(
  input [7:0] io_in,
  output [7:0] io_out
);

  // using io_in[0] as clk
  wire clk = io_in[0];

  reg  [6:0] disp;
  reg        disp_dp;

  assign io_out[6:0] = disp;
  assign io_out[7]   = disp_dp;

  wire [6:0] op  = io_in[7:1];
  wire [3:0] imm = io_in[7:4];

  reg [3:0] reg_a = 5'b0000;
  reg [3:0] reg_b = 5'b0000;

  always @(*) begin
    case (reg_a)
      4'b0000 : disp = 7'b0111111;
      4'b0001 : disp = 7'b0000110;
      4'b0010 : disp = 7'b1011011;
      4'b0011 : disp = 7'b1001111;
      4'b0100 : disp = 7'b1100110;
      4'b0101 : disp = 7'b1101101;
      4'b0110 : disp = 7'b1111101;
      4'b0111 : disp = 7'b0000111;
      4'b1000 : disp = 7'b1111111;
      4'b1001 : disp = 7'b1101111;
      4'b1010 : disp = 7'b1110111;
      4'b1011 : disp = 7'b1111100;
      4'b1100 : disp = 7'b0111001;
      4'b1101 : disp = 7'b1011110;
      4'b1110 : disp = 7'b1111001;
      4'b1111 : disp = 7'b1110001;
    endcase
  end

  always @(posedge clk) begin
    case (op)
      7'b100xxxx : {disp_dp, reg_a} <= {1'b0, imm};             // Load A
      7'b101xxxx : {disp_dp, reg_b} <= {1'b0, imm};             // Load B

      7'b00000xx : {disp_dp, reg_a} <= reg_a + reg_b;           // A = A + B
      7'b00001xx : {disp_dp, reg_a} <= reg_a - reg_b;           // A = A - B
      7'b00010xx : {disp_dp, reg_a} <= {1'b0, reg_a & reg_b};   // A = A & B
      7'b00011xx : {disp_dp, reg_a} <= {1'b0, reg_a | reg_b};   // A = A | B
      7'b00100xx : {disp_dp, reg_a} <= {1'b0, reg_a ^ reg_b};   // A = A ^ B
      7'b00101xx : {disp_dp, reg_a} <= {1'b0, ~reg_a};          // A = ~A
      7'b00110xx : {disp_dp, reg_a} <= reg_a << reg_b;          // A = A << B
      7'b00111xx : {disp_dp, reg_a} <= {1'b0, reg_a >> reg_b};  // A = A >> B

      7'b01000xx : {disp_dp, reg_b} <= reg_b + reg_a;           // B = B + A
      7'b01001xx : {disp_dp, reg_b} <= reg_b - reg_a;           // B = B - A
      7'b01010xx : {disp_dp, reg_b} <= {1'b0, reg_b & reg_a};   // B = B & A
      7'b01011xx : {disp_dp, reg_b} <= {1'b0, reg_b | reg_a};   // B = B | A
      7'b01100xx : {disp_dp, reg_b} <= {1'b0, reg_b ^ reg_a};   // B = B ^ A
      7'b01101xx : {disp_dp, reg_b} <= {1'b0, ~reg_b};          // B = ~B
      7'b01110xx : {disp_dp, reg_b} <= reg_b << reg_a;          // B = B << A
      7'b01111xx : {disp_dp, reg_b} <= {1'b0, reg_b >> reg_a};  // B = B >> A
    endcase
  end

endmodule
