module RegisterFile(
  input[1:0] RS,
  input[1:0] RT,
  input[1:0] RD,
  input[15:0] WriteData,
  output[15:0] ReadRS,
  output[15:0] ReadRT,
input RegWrite,
input Clock);

  reg[15:0] Registers[3:0];

always @ (posedge Clock)
begin
if(RegWrite) Registers[RD] <= WriteData;
end

assign ReadRS = Registers[RS];
assign ReadRT = Registers[RT];

endmodule

