module ParityGenerator(
  input wire [15:0] a_i,
  output reg parity_o = 0
);

  /////////////////////////
  // Combinational Logic //
  /////////////////////////
  always @(*) begin
    parity_o = a_i[0] ^ a_i[1] ^ a_i[2] ^ a_i[3] ^
               a_i[4] ^ a_i[5] ^ a_i[6] ^ a_i[7] ^
               a_i[8] ^ a_i[9] ^ a_i[10] ^ a_i[11] ^
               a_i[12] ^ a_i[13] ^ a_i[14] ^ a_i[15];
  end

endmodule
