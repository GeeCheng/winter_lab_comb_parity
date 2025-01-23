module ParityGenerator(
  input  wire [15:0] a_i,
  output reg  [15:0] parity_o
);

  always @(*) begin
    parity_o = a_i[0];
    parity_o = parity_o ^ a_i[1];
    parity_o = parity_o ^ a_i[2];
    parity_o = parity_o ^ a_i[3];
    parity_o = parity_o ^ a_i[4];
    parity_o = parity_o ^ a_i[5];
    parity_o = parity_o ^ a_i[6];
    parity_o = parity_o ^ a_i[7];
    parity_o = parity_o ^ a_i[8];
    parity_o = parity_o ^ a_i[9];
    parity_o = parity_o ^ a_i[10];
    parity_o = parity_o ^ a_i[11];
    parity_o = parity_o ^ a_i[12];
    parity_o = parity_o ^ a_i[13];
    parity_o = parity_o ^ a_i[14];
    parity_o = parity_o ^ a_i[15];
  end

endmodule
