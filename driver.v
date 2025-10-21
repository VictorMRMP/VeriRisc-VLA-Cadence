module driver#(parameter WIDTH=8)(input data_en,input [WIDTH-1:0] data_in,output reg [WIDTH-1:0] data_out);
always @*
begin
if(data_en==1)
		data_out=data_in;
else
		data_out=8'dz;
end
endmodule
