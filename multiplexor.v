
module multiplexor(in0,in1,sel,mux_out);
parameter WIDTH=5;
input sel;
output reg[WIDTH-1:0] mux_out;
input wire [WIDTH-1:0] in0,in1;
always @*
begin
	if(sel==0)
		mux_out=in0;
	else
		mux_out=in1;
end
endmodule
