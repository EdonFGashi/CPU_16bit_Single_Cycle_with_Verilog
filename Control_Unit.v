module ControlUnit(
    input [3:0] OPCODE,
    output reg RegDst,
    output reg ALUSrc,
    output reg MemToReg,
    output reg RegWrite,
    output reg MemRead,
    output reg MemWrite,
    output reg [1:0] ALUOp,
    output reg Branch
    );

always @ (OPCODE)
begin
  
case(OPCODE)
4'b0000:     //AND, OR, XOR
begin
assign RegDst = 1'b1;
assign ALUSrc = 1'b0;
assign MemToReg = 1'b0;
assign RegWrite = 1'b1;
assign MemRead = 1'b0;
assign MemWrite = 1'b0;
assign ALUOp = 2'b10;
assign Branch = 1'b0;
end

4'b0001:     //ADD, SUB
begin
assign RegDst = 1'b1;
assign ALUSrc = 1'b0;
assign MemToReg = 1'b0;
assign RegWrite = 1'b1;
assign MemRead = 1'b0;
assign MemWrite = 1'b0;
assign ALUOp = 2'b10;
assign Branch = 1'b0;
end

4'b1001:     //ADDI
begin
assign RegDst = 1'b0;
assign ALUSrc = 1'b1;
assign MemToReg = 1'b0;
assign RegWrite = 1'b1;
assign MemRead = 1'b0;
assign MemWrite = 1'b0;
assign ALUOp = 2'b11;
assign Branch = 1'b0;
end

4'b1010:     //SUBI
begin
assign RegDst = 1'b0;
assign ALUSrc = 1'b1;
assign MemToReg = 1'b0;
assign RegWrite = 1'b1;
assign MemRead = 1'b0;
assign MemWrite = 1'b0;
assign ALUOp = 2'b11;
assign Branch = 1'b0;
end

4'b1011:     //SLTI
begin
assign RegDst = 1'b0;
assign ALUSrc = 1'b1;
assign MemToReg = 1'b0;
assign RegWrite = 1'b1;
assign MemRead = 1'b0;
assign MemWrite = 1'b0;
assign ALUOp = 2'b11;
assign Branch = 1'b0;
end

4'b1100:     //LW
begin
assign RegDst = 1'b0;
assign ALUSrc = 1'b1;
assign MemToReg = 1'b1;
assign RegWrite = 1'b1;
assign MemRead = 1'b1;
assign MemWrite = 1'b0;
assign ALUOp = 2'b00;
assign Branch = 1'b0;
end

4'b1101:     //SW
begin
assign RegDst = 1'b0;
assign ALUSrc = 1'b1;
assign MemToReg = 1'b0;
assign RegWrite = 1'b0;
assign MemRead = 1'b0;
assign MemWrite = 1'b1;
assign ALUOp = 2'b00;
assign Branch = 1'b0;
end

4'b1111:     //BEQ
begin
assign RegDst = 1'b0;
assign ALUSrc = 1'b0;
assign MemToReg = 1'b0;
assign RegWrite = 1'b0;
assign MemRead = 1'b0;
assign MemWrite = 1'b0;
assign ALUOp = 2'b01;
assign Branch = 1'b1;
end

4'b1110:     //BNE
begin
assign RegDst = 1'b0;
assign ALUSrc = 1'b0;
assign MemToReg = 1'b0;
assign RegWrite = 1'b0;
assign MemRead = 1'b0;
assign MemWrite = 1'b0;
assign ALUOp = 2'b01;
assign Branch = 1'b0;
end
  
4'b0010:       //SLL, SRA
begin
assign RegDst = 1'b1;
assign ALUSrc = 1'b0;
assign MemToReg = 1'b0;
assign RegWrite = 1'b1;
assign MemRead = 1'b0;
assign MemWrite = 1'b0;
assign ALUOp = 2'b10;
assign Branch = 1'b1;
end
endcase
  
end
endmodule
