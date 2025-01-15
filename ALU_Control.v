module ALUControl(
  input[3:0]  OPCODE, 
  input[1:0] ALUOp, 
  input[1:0] FUNCT, 
  output reg[3:0] Operacioni);
  
  always @ (ALUOp, OPCODE, FUNCT)
begin 
case(ALUOp)
2'b00:
begin
assign Operacioni = 4'b0100;    // LW, SW
end
2'b01:
begin
assign Operacioni = 4'b1100;    //BEQ, BNE
end
2'b10:
begin
	case(OPCODE)
    	4'b0000:
    	begin
			case(FUNCT)
			2'b00:
			begin
			assign Operacioni = 4'b0000;    // AND
			end
		 	2'b01:
			begin
			assign Operacioni = 4'b0010;    // OR
			end
			2'b10:
			begin
			assign Operacioni = 4'b0011;    // XOR
			end
			endcase
		end
		4'b0001:
    	begin
			case(FUNCT)
			2'b00:
			begin
			assign Operacioni = 4'b0100;   //ADD
            end
            2'b01:
    		begin
			assign Operacioni = 4'b1100;   //SUB
			end
			endcase
		end
      	4'b0010:
    	begin
			case(FUNCT)
			2'b00:
			begin
			assign Operacioni = 4'b0110;   //SLL
            end
             2'b01:
			begin
			assign Operacioni = 4'b0111;   //SLR
            end
			endcase
		end
		endcase
end
2'b11:
begin
	case(OPCODE)
    	4'b1001:
    	begin
		assign Operacioni = 4'b0101;    //ADDI
		end
		4'b1010:
    	begin
		assign Operacioni = 4'b1101;    //SUBI
		end
		4'b1011:
    	begin
		assign Operacioni = 4'b1001;    //SLTI
		end
	endcase
end
endcase
end
endmodule

