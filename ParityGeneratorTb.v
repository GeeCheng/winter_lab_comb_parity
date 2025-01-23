`timescale 1ns / 1ps
`include "ParityGenerator.v"

module ParityGeneratorTb;

  reg [15:0] a_i;
  wire parity_o;

  ParityGenerator parity_generator(
    .a_i      (a_i     ),
    .parity_o (parity_o)
  );

  integer file = 0;
  integer expected = 0;
  integer status = 0;
  integer error = 0;
  
  initial begin
    $dumpfile("ParityGeneratorTb.vcd");
    $dumpvars(0, ParityGeneratorTb);

    file = $fopen("answer.txt", "r");

    if (file == 0) begin
      $display("Error: could not open ParityGeneratorTb.txt");
      $finish;
    end

    for (integer i = 16'b0000000000000000; i <= 16'b1111111111111111; i = i + 1) begin
      a_i = i;
      status = $fscanf(file, "%d", expected);
      if (status == 1) begin
        #1;
        if (parity_o !== expected) begin
          $display("Error: parity_o = %d, expected = %d", parity_o, expected);
          error = error + 1;
          $finish;
        end
      end else begin
        $display("Error: unexpected status %d", status);
        $finish;
      end
      #1;
    end

    if (error == 0) begin
      $display("Success: all tests passed");
    end else begin
      $display("Error: %d tests failed", error);
    end

  $finish;
  end

endmodule
