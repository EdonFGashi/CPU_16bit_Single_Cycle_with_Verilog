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
