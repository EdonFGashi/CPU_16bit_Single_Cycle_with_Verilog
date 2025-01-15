module shiftuesi(
  input [15:0] numri,
  input [3:0] shiftOp,
  input [3:0] shamt,
  output reg[15:0] shiftimi
);
  
  wire signed [15:0] signed_a;
assign signed_a = numri;
  
  always @ (shiftOp)
begin
  
case(shiftOp)
4'b0110:     //SLL
begin
assign shiftimi = numri << shamt;
end

4'b0111:     //SRA
begin
assign shiftimi = signed_a >>> shamt;
end

endcase
  
end
endmodule
