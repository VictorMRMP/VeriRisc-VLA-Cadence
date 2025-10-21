module alu#(parameter WIDTH=8)(input [WIDTH-1:0] in_a, in_b,input [2:0] opcode,output reg [WIDTH-1:0] alu_out,output reg a_is_zero);

always @*
begin
a_is_zero= !in_a ? 1'b1 : 1'b0;

if((opcode==3'b0)||(opcode==3'b001)||(opcode==3'b110)||(opcode==3'b111))
	alu_out=in_a;
if(opcode==3'b010)
	alu_out=in_a+in_b;
if(opcode==3'b011)
	alu_out=in_a&in_b;
if(opcode==3'b100)
	alu_out=in_a^in_b;
if(opcode==3'b101)
	alu_out=in_b;

end
endmodule

