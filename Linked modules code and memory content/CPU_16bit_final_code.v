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

module mux2tek1(
  	input Hyrja0,
    input Hyrja1,
    input S,
  	output Dalja
    );
  
assign Dalja = S ? Hyrja1 : Hyrja0;
endmodule

module mux2ne1(
  	input[1:0] Hyrja0,
    input[1:0] Hyrja1,
    input S,
  	output[1:0] Dalja
    );
  
assign Dalja = S ? Hyrja1 : Hyrja0;
endmodule

module mux2to1(
 	 input[15:0] Hyrja0,
 	 input[15:0] Hyrja1,
    input S,
  	output[15:0] Dalja
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
  
mux2tek1 muxB(B, JoB, BInvert, mB);
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



module InstructionMemory(
  input wire[15:0] PC, 
  output wire[15:0] Instruction);
  
  reg[7:0] iMem[0:127];
  
initial $readmemb("instrMemory.mem", iMem);
  
  assign Instruction = {iMem[PC], iMem[PC+1]};
endmodule


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
  
  //Reseto te gjithe regjistrat ne 0
integer i;
initial 
begin
  for(i=0;i<4;i=i+1)
    Registers[i] <= 16'd0; 
end
  
always @ (posedge Clock)
begin
  if(RegWrite) 
    begin
    	Registers[RD] <= WriteData;
    end
end
  
assign ReadRS = Registers[RS];
assign ReadRT = Registers[RT];
endmodule


module DataMemory(
  input wire[15:0] Adresa, 
  input wire[15:0] WriteData, 
  input wire Clock, 	
  input wire MemWrite, 
  input wire MemRead, 
  output wire[15:0] ReadData);
  

  reg[7:0] dMem[0:127];
  
initial
$readmemb("dataMemory.mem", dMem);
  
  always@(posedge Clock)
  begin
    if(MemWrite) 
      begin
        dMem[Adresa] <= WriteData[15:8];
        dMem[Adresa+1] <= WriteData[7:0];
      end
  end
  
always@(negedge Clock)
begin
$writememb("dataMemory.mem", dMem);
end
  
assign ReadData = {dMem[Adresa],dMem[Adresa+1]};
endmodule


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



///////////////////////BONUS/////////////////////////////////////

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

///////////////////////////////////////////////////////////////




  
  
 ///////////////////////////////////////////////////
  module Datapath(
	input Clock,  //HYRJE NGA CPU - TELI CPU_IN_1
	input RegDst, Branch, MemRead, 
	MemWrite, RegWrite, MemToReg, ALUSrc, //HYRJET NGA CU - TELAT CU_OUT_x
	input [1:0] ALUOp, //HYRJE NGA CU - TELAT CU_OUT_x
    output [3:0] opcode //DALJE PER NE CU - TELI D_OUT_1
	);
  
  reg[15:0] pc_initial;//regjistri PC
    wire [15:0] pc_next, pc2, pcbeq; //TELAT: T1, T2, T3
  wire [15:0] instruction; //TELI T5
  wire [1:0] mux_regfile; //TELI T6
  wire[15:0] readData1, readData2, writeData, //TELAT T7-T9 
  mux_ALU, ALU_Out, Zgjerimi, memToMux, //TELAT T10-T13
  shifter2beq, branchAdderToMux, beqAddress, Set, shiftApoALU, shiftimi; //TELAT T14, T16, T17, T30, T31 
  wire[3:0] ALUOperacioni; //TELI T19
  wire zero, overflow, carryout; // TELAT T20-T22
  wire andMuxBranch; //TELI T23
  
  
  initial
	begin
      pc_initial = 16'd10; //inicializimi fillesat i PC ne adresen 10
	end
  
  always@(posedge Clock)
	begin
      pc_initial <= pc_next; //azhurimi i PC ne cdo teh pozitiv me adresen e ardhshme
	end
  
    //T2 - PC rritet per 2 (ne sistemet 16 biteshe) per te gjitha instruksionet pervec 		BEQ, BNE, JUMP
	assign pc2 = pc_initial + 2; 
  
    //T14 - pergatitja e adreses per kercim ne BEQ (1 bit shtyrje majtas (x2), per te kaluar ne instrukionin e ardhshem)  
    assign shifter2beq = {Zgjerimi[14:0], 1'b0};
  
  
    //Instr mem //inicializimi i IM (PC adresa hyrje, teli instruction dajle (T5))
	InstructionMemory IM(pc_initial, instruction); 
  
    //T6 - Percaktimi nese RD eshte RD (te R-formati) apo RD = RT (te I-formati) - MUX M1     ne foto
  assign mux_regfile = (RegDst == 1'b1) ? instruction[7:6] : instruction[9:8]; 
  
    // T12 - Zgjerimi nga 8 ne 16 bit - 8 bit si MSB dhe pjesa e instruction[7:0] - S1 		ne foto
	assign Zgjerimi = {{8{instruction[7]}}, instruction[7:0]};
  
  	//REGFILE
    //inicializimi i RF (RS, RT, RD, WriteData(T9), ReadRS(T8), ReadRT(T9), RegWrite, Clock)
    RegisterFile RF(instruction[11:10], instruction[9:8], mux_regfile, writeData, readData1, readData2,	RegWrite, Clock); 
  
  	// T10 - Percaktimi nese hyrja e MUX-it M2 para ALU eshte Regjstri 2 i RF apo vlera 	imediate e instruksionit 
	assign mux_ALU = (ALUSrc == 1'b1) ? Zgjerimi : readData2;
  
  
    //inicializimi i ALU Control (opcode, ALUOp, funct, T19)
  ALUControl AC( instruction[15:12], ALUOp, instruction[1:0], ALUOperacioni); 
  
    //inicializimi i ALU (T7, T10, T19[3], T19[2:0], T19[3], T20, T21, T22, T11, SET)
  ALU_16bit ALU16(readData1, mux_ALU, ALUOperacioni[2:0], ALUOperacioni[3], zero, 			overflow, carryout, ALU_Out, Set);
  
  //inicializimi i Data Memory (T11, T8, CU_OUT_x, CU_OUT_x, CPU_IN_1, T13) 
	DataMemory DM(ALU_Out, readData2, Clock, MemWrite, MemRead, memToMux);
  
  //T9 - Teli qe i dergon te dhenat nga MUX - M3 ne Regfile
	assign writeData = (MemToReg == 1'b1) ? memToMux : shiftApoALU;
  
  //T23 - Teli qe del nga porta DE ne pjesen e eperme te fotos (shikon nese plotesohet 	kushti per BEQ
    assign andMuxBranch = zero & Branch & ALUOp[0];
  
  //T17, Teli qe mban adresen ne te cilen do te kercej programi kur kushti BEQ plotesohet
	assign beqAddress = pc2 + shifter2beq; 
  
  //T3 - Teli qe del nga Mux M4 ne foto qe kontrollon nese kemi BEQ apo PC+2
    assign pcbeq = (andMuxBranch == 1'b1) ? beqAddress : pc2;
  
  //T1- Teli qe update-on PC (3 mundesite PC+4, PCBEQ, PCJUMP)
	assign pc_next = pcbeq;
  
  //Teli D_OUT_1 qe i dergohet CU
  assign opcode = instruction[15:12];
    
    
    
    
//////////////////////////////BONUS////////////////////////////////////////////
    
    // shiftuesi(T7, T19, shamt, T31)
    shiftuesi Sh(readData1, ALUOperacioni, instruction[5:2], shiftimi);
    
  
	//T30  
    assign shiftApoALU = (Branch == 1'b1) ? shiftimi : ALU_Out;
///////////////////////////////////////////////////////////////////////////////
  
  endmodule


	//Hyrje ne CPU - CLock CPU_IN_1
	module CPU(input Clock);

	//TELAT E BRENDSHEM TE CPU
      wire [3:0] opcode; //D_OUT_1
      
     //CU_OUT_x
	 wire RegDst, Branch, MemRead, MemWrite, RegWrite, MemToReg, ALUSrc;
     wire [1:0] ALUOp;

      //inicializimi i Datapath    
	Datapath DP
	(Clock,
	RegDst, Branch, MemRead, MemWrite, RegWrite, MemToReg, ALUSrc,
	ALUOp, opcode);
      
      //Inicializimi i COntrol Unit
	ControlUnit CU(
    opcode,
	RegDst,  
	ALUSrc,
    MemToReg,
    RegWrite,
	MemRead, 
	MemWrite, 
	ALUOp,
    Branch
	);


    endmodule

