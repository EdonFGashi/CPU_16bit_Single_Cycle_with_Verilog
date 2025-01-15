
module Mbledhesi_1bit(
    input A,
    input B,
    input CIN,
    output SUM,
    output COUT
    );
    
assign SUM = CIN ^ A ^ B;
assign COUT = CIN & A | CIN & B | A & B;
    
endmodule

module mux2ne1(
    input Hyrja0,
    input Hyrja1,
    input S,
    output Dalja
    );
    
assign Dalja = S ? Hyrja1 : Hyrja0;

endmodule

module mux8to1 (
  input Hyrja0,
  input Hyrja1,
  input Hyrja2,
  input Hyrja3,
  input Hyrja4,
  input Hyrja5,
  input Hyrja6,
  input Hyrja7,
  input [2:0] S,
  output Dalja
);

assign Dalja = (S == 3'b000) ? Hyrja0 :
                (S == 3'b001) ? Hyrja1 :
                (S == 3'b010) ? Hyrja2 :
                (S == 3'b011) ? Hyrja3 :
                (S == 3'b100) ? Hyrja4 :
                (S == 3'b101) ? Hyrja5 :
                (S == 3'b110) ? Hyrja6 : Hyrja7; 

endmodule

module ALU_1bit(
    input A,
    input B,
    input LESS,
    input CIN,
    input BInvert,
  	input [2:0] Operation,
    output Result,
    output COUT,
  	output Set
    );

wire JoB, mB, Dhe, Ose, Xor, Mbledhesi;

assign JoB = ~B;

mux2ne1 muxB(B, JoB, BInvert, mB);

assign Dhe = A & mB;
assign Ose = A | mB;
assign Xor = A ^  mB;

Mbledhesi_1bit Adder(A, mB, CIN, Mbledhesi, COUT);
assign Set = Mbledhesi;

  mux8to1 muxALU(Dhe,LESS, Ose, Xor, Mbledhesi, Mbledhesi, Mbledhesi, Mbledhesi, Operation, Result);
   
endmodule


module ALU_16bit(
  input [15:0] A,
  input [15:0] B,
  input [2:0] ALUOp,
  input BNegate,
  output Zero,
  output Overflow,
  output CarryOut,
  output [15:0] Result,
  output [15:0] Seti
    );

  wire [14:0] COUT;    
  ALU_1bit ALU0(A[0], B[0], Seti[15], BNegate, BNegate, ALUOp, Result[0], COUT[0], Seti[0]);
  ALU_1bit ALU1(A[1], B[1], 0, COUT[0], BNegate, ALUOp, Result[1], COUT[1], Seti[1]);
  ALU_1bit ALU2(A[2], B[2], 0, COUT[1], BNegate, ALUOp, Result[2], COUT[2], Seti[2]);
  ALU_1bit ALU3(A[3], B[3], 0, COUT[2], BNegate, ALUOp, Result[3], COUT[3], Seti[3]);
  ALU_1bit ALU4(A[4], B[4], 0, COUT[3], BNegate, ALUOp, Result[4], COUT[4], Seti[4]);
  ALU_1bit ALU5(A[5], B[5], 0, COUT[4], BNegate, ALUOp, Result[5], COUT[5], Seti[5]);
  ALU_1bit ALU6(A[6], B[6], 0, COUT[5], BNegate, ALUOp, Result[6], COUT[6], Seti[6]);
  ALU_1bit ALU7(A[7], B[7], 0, COUT[6], BNegate, ALUOp, Result[7], COUT[7], Seti[7]);
  ALU_1bit ALU8(A[8], B[8], 0, COUT[7], BNegate, ALUOp, Result[8], COUT[8], Seti[8]);
  ALU_1bit ALU9(A[9], B[9], 0, COUT[8], BNegate, ALUOp, Result[9], COUT[9], Seti[9]);
  ALU_1bit ALU10(A[10], B[10], 0, COUT[9], BNegate, ALUOp, Result[10], COUT[10], Seti[10]);
  ALU_1bit ALU11(A[11], B[11], 0, COUT[10], BNegate, ALUOp, Result[11], COUT[11], Seti[11]);
  ALU_1bit ALU12(A[12], B[12], 0, COUT[11], BNegate, ALUOp, Result[12], COUT[12], Seti[12]);
  ALU_1bit ALU13(A[13], B[13], 0, COUT[12], BNegate, ALUOp, Result[13], COUT[13], Seti[13]);
  ALU_1bit ALU14(A[14], B[14], 0, COUT[13], BNegate, ALUOp, Result[14], COUT[14], Seti[14]);
  
  ALU_1bit ALU15(A[15], B[15], 0, COUT[14], BNegate, ALUOp, Result[15], CarryOut, Seti[15]);

assign Zero = ~(Result[0] | Result[1] | 
                Result[2] | Result[3] | 
                Result[4] | Result[5] | 
                Result[6] | Result[7] | 
                Result[8] | Result[9] | 
                Result[10] | Result[11] | 
                Result[12] | Result[13] | 
                Result[14] | Result[15]);  

  assign Overflow = COUT[14] ^ CarryOut;
  
  

endmodule
