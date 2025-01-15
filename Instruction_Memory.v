
module InstructionMemory(input[15:0] PC, output[15:0] Instruction);

  reg[7:0] iMem[127:0];

initial $readmemb("instrMemory.mem", iMem);

  assign Instruction = {iMem[PC], iMem[PC+1]};

endmodule
