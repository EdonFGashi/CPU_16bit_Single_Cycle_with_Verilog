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
