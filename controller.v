module controller(zero,phase,opcode,sel,rd,ld_ir,halt,inc_pc,ld_ac,wr,ld_pc,data_e);
input zero;
input [2:0]phase;
input [2:0] opcode;
output reg sel,rd,ld_ir,halt,inc_pc,ld_ac,wr,ld_pc,data_e;
reg ALU_OP;
reg [8:0] out;
always@*
begin
if(opcode==3'b010 || opcode==3'b011 || opcode==3'b100||opcode==3'b101)
	 ALU_OP=1;
else
	 ALU_OP=0;

case(phase)
		0: out=9'b100000000;
		1: out=9'b110000000;
		2: out=9'b111000000;
		3: out=9'b111000000;
		4: out={3'b000,opcode==3'b000,5'b10000};
		5: out={1'b0,ALU_OP,7'b00000000};
		6: out={1'b0,ALU_OP,2'b00,((opcode==3'b001)&&zero),1'b0,opcode==3'b111,1'b0,opcode==3'b110};
		7: out={1'b0,ALU_OP,3'b000,ALU_OP,opcode==3'b111,opcode==3'b110,opcode==3'b110};
endcase
	sel=out[8];
	rd=out[7];
	ld_ir=out[6];
	halt=out[5];
	inc_pc=out[4];
	ld_ac=out[3];
	ld_pc=out[2];
	wr=out[1];
	data_e=out[0];
end
endmodule
