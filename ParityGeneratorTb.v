`timescale 1ns / 1ps
`include "ParityGenerator.v"

module ParityGeneratorTb;

  /////////////////////////
  // Signal Declarations //
  /////////////////////////
  reg  [15:0] a_i;
  reg         clk_i;
  wire        parity_o;

  ///////////////////////
  // DUT Instantiation //
  ///////////////////////
  ParityGenerator u_ParityGenerator (
    .a_i      (a_i     ),
    .parity_o (parity_o)
  );

  ////////////////////////////
  // Variables for File I/O //
  ////////////////////////////
  integer file;
  integer expected;
  integer status;
  integer error_count;

  //////////////////////
  // Clock Generation //
  //////////////////////
  initial clk_i = 0;
  always #5 clk_i = ~clk_i; // 10ns clock period


  ////////////////////////
  // Main Test Sequence //
  ////////////////////////
  initial begin

    ///////////////////////////////////////////
    // Open answer file and check for errors //
    ///////////////////////////////////////////
    $dumpfile("ParityGeneratorTb.vcd");
    $dumpvars(0, ParityGeneratorTb);

    file = $fopen("answer.txt", "r");
    if (file == 0) begin
      $display("[ERROR] Could not open answer.txt");
      $finish;
    end

    error_count = 0;

    ///////////////////
    // Test Sequence //
    ///////////////////
    for (integer i = 0; i <= 16'b1111_1111_1111_1111; i = i + 1) begin
      a_i = i;
      status = $fscanf(file, "%d", expected);
      @(posedge clk_i);
      if (status == 1) begin
        if (parity_o !== expected) begin
          $display("[FAIL] Input: %b, parity_o = %b, expected = %b", a_i, parity_o, expected);
          error_count = error_count + 1;
        end
      end else begin
        $display("[ERROR] Unexpected file read status: %d", status);
        $finish;
      end
    end

    //////////////////
    // Test Summary //
    //////////////////
    if (error_count == 0) begin
      $display("[SUCCESS] All tests passed");
    end else begin
      $display("[FAILURE] %d tests failed", error_count);
    end

    $fclose(file);
    $finish;
  end

endmodule
