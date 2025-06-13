module test_mips32;
  reg clk1, clk2;
  integer k;

  // Instantiate the MIPS processor
  pipe_MIPS32 mips(clk1, clk2);

  // Clock generation
  initial begin
    clk1 = 0;
    clk2 = 0;
    mips.HALTED = 0;
    mips.PC = 0;
    mips.TAKEN_BRANCH = 0;

    // Generate two-phase clock
    repeat (20) begin
      #5 clk1 = 1; #5 clk1 = 0;
      #5 clk2 = 1; #5 clk2 = 0;
    end
  end

  // Initialize registers and memory
  initial begin
    for (k = 0; k < 32; k = k + 1)
      mips.Reg[k] = k;

    // Load instructions into memory
    mips.Mem[0] = 32'h2801000a; // ADDI R1, R0, 10
    mips.Mem[1] = 32'h28020014; // ADDI R2, R0, 20
    mips.Mem[2] = 32'h28030019; // ADDI R3, R0, 25
    mips.Mem[3] = 32'h0ce77800; // OR R7, R7, R7 (NOP/dummy)
    mips.Mem[4] = 32'h0ce77800; // OR R7, R7, R7 (NOP/dummy)
    mips.Mem[5] = 32'h00222000; // ADD R4, R1, R2
    mips.Mem[6] = 32'h0ce77800; // OR R7, R7, R7 (NOP/dummy)
    mips.Mem[7] = 32'h00832800; // ADD R5, R4, R3
    mips.Mem[8] = 32'hfc000000; // HLT

    // Wait and display register values
    #280
    for (k = 0; k < 6; k = k + 1)
      $display("R%1d - %2d", k, mips.Reg[k]);
  end

  // Dump waveform
  initial begin
    $dumpfile("mips.vcd");
    $dumpvars(0, test_mips32); // Top-level
    $dumpvars(1, test_mips32.mips); // MIPS internal state

    // Pipeline stage signals
    $dumpvars(2, test_mips32.mips.IF_ID_IR, test_mips32.mips.IF_ID_NPC);
    $dumpvars(2, test_mips32.mips.ID_EX_IR, test_mips32.mips.ID_EX_NPC,
                  test_mips32.mips.ID_EX_A, test_mips32.mips.ID_EX_B,
                  test_mips32.mips.ID_EX_Imm);
    $dumpvars(2, test_mips32.mips.EX_MEM_IR, test_mips32.mips.EX_MEM_ALUOut,
                  test_mips32.mips.EX_MEM_B, test_mips32.mips.EX_MEM_cond);
    $dumpvars(2, test_mips32.mips.MEM_WB_IR, test_mips32.mips.MEM_WB_ALUOut,
                  test_mips32.mips.MEM_WB_LMD);

    // Global control/status
    $dumpvars(2, test_mips32.mips.PC, test_mips32.mips.TAKEN_BRANCH, test_mips32.mips.HALTED);
    $dumpvars(2, test_mips32.mips.Reg); // Register file
    $dumpvars(2, test_mips32.clk1, test_mips32.clk2);

    #300 $finish;
  end
endmodule
