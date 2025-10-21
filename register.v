module register(data_in,load,clk,data_out,rst);
parameter WIDTH=8;
input [WIDTH-1:0] data_in;
output reg [WIDTH-1:0] data_out;
input load,clk,rst;
always@(posedge clk)
begin
if(load)
	data_out=data_in;
if(rst)
	data_out=8'b00000000;
else
 	data_out<=data_out;
end
endmodule
