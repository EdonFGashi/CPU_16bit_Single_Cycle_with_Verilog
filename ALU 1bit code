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
