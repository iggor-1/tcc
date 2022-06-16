// Universidade de Sao Paulo
// MBA em seguranca de dados
//
// Igor Machado
//
// Decision Tree

module buffer(
	input							clk,
	input							rst,
	
	input  [1:0]				byte_offset,	
	input							receiving,
	
	input	 [7:0]				data_in,
	
	input [4:0]					word_offset,
	
	output [31:0]				data_out0,
	output [31:0]				data_out1,
	output [31:0]				data_out2,
	output [31:0]				data_out3,
	output [31:0]				data_out4,
	
	output [31:0]				data_out5,
	output [31:0]				data_out6,
	output [31:0]				data_out7,
	output [31:0]				data_out8,
	output [31:0]				data_out9,
	
	output [31:0]				data_out10,
	output [31:0]				data_out11,
	output [31:0]				data_out12,
	output [31:0]				data_out13,
	output [31:0]				data_out14,
	
	output [31:0]				data_out15,
	output [31:0]				data_out16,
	output [31:0]				data_out17,
	output [31:0]				data_out18,	
	output [31:0]				data_out19
);
	
	reg [31:0]		reg_bank0;
	reg [31:0]		reg_bank1;
	reg [31:0]		reg_bank2;
	reg [31:0]		reg_bank3;
	reg [31:0]		reg_bank4;
	
	reg [31:0]		reg_bank5;
	reg [31:0]		reg_bank6;
	reg [31:0]		reg_bank7;
	reg [31:0]		reg_bank8;
	reg [31:0]		reg_bank9;
	
	reg [31:0]		reg_bank10;
	reg [31:0]		reg_bank11;
	reg [31:0]		reg_bank12;
	reg [31:0]		reg_bank13;
	reg [31:0]		reg_bank14;
	
	reg [31:0]		reg_bank15;
	reg [31:0]		reg_bank16;
	reg [31:0]		reg_bank17;
	reg [31:0]		reg_bank18;
	reg [31:0]		reg_bank19;
	
	always @(posedge clk or posedge rst)
	begin
		if(rst)
		begin
			reg_bank0  <= 32'h00000000;
			reg_bank1  <= 32'h00000000;
			reg_bank2  <= 32'h00000000;
			reg_bank3  <= 32'h00000000;
			reg_bank4  <= 32'h00000000;
			
			reg_bank5  <= 32'h00000000;
			reg_bank6  <= 32'h00000000;
			reg_bank7  <= 32'h00000000;
			reg_bank8  <= 32'h00000000;
			reg_bank9  <= 32'h00000000;
			
			reg_bank10 <= 32'h00000000;
			reg_bank11 <= 32'h00000000;
			reg_bank12 <= 32'h00000000;
			reg_bank13 <= 32'h00000000;
			reg_bank14 <= 32'h00000000;
			
			reg_bank15 <= 32'h00000000;
			reg_bank16 <= 32'h00000000;
			reg_bank17 <= 32'h00000000;
			reg_bank18 <= 32'h00000000;
			reg_bank19 <= 32'h00000000;
		end
		
		else
		begin
			if(receiving & (byte_offset == 2'b00))
			begin
				if(word_offset == 5'h00)
					reg_bank0[31:24]  <= data_in;
				if(word_offset == 5'h01)
					reg_bank1[31:24]  <= data_in;
				if(word_offset == 5'h02)
					reg_bank2[31:24]  <= data_in;
				if(word_offset == 5'h03)
					reg_bank3[31:24]  <= data_in;
				if(word_offset == 5'h04)
					reg_bank4[31:24]  <= data_in;
				if(word_offset == 5'h05)
					reg_bank5[31:24]  <= data_in;
				if(word_offset == 5'h06)
					reg_bank6[31:24]  <= data_in;
				if(word_offset == 5'h07)
					reg_bank7[31:24]  <= data_in;
				if(word_offset == 5'h08)
					reg_bank8[31:24]  <= data_in;
				if(word_offset == 5'h09)
					reg_bank9[31:24]  <= data_in;
				if(word_offset == 5'h0A)
					reg_bank10[31:24]  <= data_in;
				if(word_offset == 5'h0B)
					reg_bank11[31:24]  <= data_in;
				if(word_offset == 5'h0C)
					reg_bank12[31:24]  <= data_in;
				if(word_offset == 5'h0D)
					reg_bank13[31:24]  <= data_in;
				if(word_offset == 5'h0E)
					reg_bank14[31:24]  <= data_in;
				if(word_offset == 5'h0F)
					reg_bank15[31:24]  <= data_in;
				if(word_offset == 5'h10)
					reg_bank16[31:24]  <= data_in;
				if(word_offset == 5'h11)
					reg_bank17[31:24]  <= data_in;
				if(word_offset == 5'h12)
					reg_bank18[31:24]  <= data_in;
				if(word_offset == 5'h13)
					reg_bank19[31:24]  <= data_in;
			end
			
			if(receiving & (byte_offset == 2'b01))
			begin
				if(word_offset == 5'h00)
					reg_bank0[23:16]  <= data_in;
				if(word_offset == 5'h01)
					reg_bank1[23:16]  <= data_in;
				if(word_offset == 5'h02)
					reg_bank2[23:16]  <= data_in;
				if(word_offset == 5'h03)
					reg_bank3[23:16]  <= data_in;
				if(word_offset == 5'h04)
					reg_bank4[23:16]  <= data_in;
				if(word_offset == 5'h05)
					reg_bank5[23:16]  <= data_in;
				if(word_offset == 5'h06)
					reg_bank6[23:16]  <= data_in;
				if(word_offset == 5'h07)
					reg_bank7[23:16]  <= data_in;
				if(word_offset == 5'h08)
					reg_bank8[23:16]  <= data_in;
				if(word_offset == 5'h09)
					reg_bank9[23:16]  <= data_in;
				if(word_offset == 5'h0A)
					reg_bank10[23:16]  <= data_in;
				if(word_offset == 5'h0B)
					reg_bank11[23:16]  <= data_in;
				if(word_offset == 5'h0C)
					reg_bank12[23:16]  <= data_in;
				if(word_offset == 5'h0D)
					reg_bank13[23:16]  <= data_in;
				if(word_offset == 5'h0E)
					reg_bank14[23:16]  <= data_in;
				if(word_offset == 5'h0F)
					reg_bank15[23:16]  <= data_in;
				if(word_offset == 5'h10)
					reg_bank16[23:16]  <= data_in;
				if(word_offset == 5'h11)
					reg_bank17[23:16]  <= data_in;
				if(word_offset == 5'h12)
					reg_bank18[23:16]  <= data_in;
				if(word_offset == 5'h13)
					reg_bank19[23:16]  <= data_in;
			end
			
			if(receiving & (byte_offset == 2'b10))
			begin
				if(word_offset == 5'h00)
					reg_bank0[15:8]  <= data_in;
				if(word_offset == 5'h01)
					reg_bank1[15:8]  <= data_in;
				if(word_offset == 5'h02)
					reg_bank2[15:8]  <= data_in;
				if(word_offset == 5'h03)
					reg_bank3[15:8]  <= data_in;
				if(word_offset == 5'h04)
					reg_bank4[15:8]  <= data_in;
				if(word_offset == 5'h05)
					reg_bank5[15:8]  <= data_in;
				if(word_offset == 5'h06)
					reg_bank6[15:8]  <= data_in;
				if(word_offset == 5'h07)
					reg_bank7[15:8]  <= data_in;
				if(word_offset == 5'h08)
					reg_bank8[15:8]  <= data_in;
				if(word_offset == 5'h09)
					reg_bank9[15:8]  <= data_in;
				if(word_offset == 5'h0A)
					reg_bank10[15:8]  <= data_in;
				if(word_offset == 5'h0B)
					reg_bank11[15:8]  <= data_in;
				if(word_offset == 5'h0C)
					reg_bank12[15:8]  <= data_in;
				if(word_offset == 5'h0D)
					reg_bank13[15:8]  <= data_in;
				if(word_offset == 5'h0E)
					reg_bank14[15:8]  <= data_in;
				if(word_offset == 5'h0F)
					reg_bank15[15:8]  <= data_in;
				if(word_offset == 5'h10)
					reg_bank16[15:8]  <= data_in;
				if(word_offset == 5'h11)
					reg_bank17[15:8]  <= data_in;
				if(word_offset == 5'h12)
					reg_bank18[15:8]  <= data_in;
				if(word_offset == 5'h13)
					reg_bank19[15:8]  <= data_in;
			end
						
			if(receiving & (byte_offset == 2'b11))
			begin
				if(word_offset == 5'h00)
					reg_bank0[7:0]  <= data_in;
				if(word_offset == 5'h01)
					reg_bank1[7:0]  <= data_in;
				if(word_offset == 5'h02)
					reg_bank2[7:0]  <= data_in;
				if(word_offset == 5'h03)
					reg_bank3[7:0]  <= data_in;
				if(word_offset == 5'h04)
					reg_bank4[7:0]  <= data_in;
				if(word_offset == 5'h05)
					reg_bank5[7:0]  <= data_in;
				if(word_offset == 5'h06)
					reg_bank6[7:0]  <= data_in;
				if(word_offset == 5'h07)
					reg_bank7[7:0]  <= data_in;
				if(word_offset == 5'h08)
					reg_bank8[7:0]  <= data_in;
				if(word_offset == 5'h09)
					reg_bank9[7:0]  <= data_in;
				if(word_offset == 5'h0A)
					reg_bank10[7:0]  <= data_in;
				if(word_offset == 5'h0B)
					reg_bank11[7:0]  <= data_in;
				if(word_offset == 5'h0C)
					reg_bank12[7:0]  <= data_in;
				if(word_offset == 5'h0D)
					reg_bank13[7:0]  <= data_in;
				if(word_offset == 5'h0E)
					reg_bank14[7:0]  <= data_in;
				if(word_offset == 5'h0F)
					reg_bank15[7:0]  <= data_in;
				if(word_offset == 5'h10)
					reg_bank16[7:0]  <= data_in;
				if(word_offset == 5'h11)
					reg_bank17[7:0]  <= data_in;
				if(word_offset == 5'h12)
					reg_bank18[7:0]  <= data_in;
				if(word_offset == 5'h13)
					reg_bank19[7:0]  <= data_in;
			end	
		end
	end
	
	assign data_out0 = reg_bank0;
	assign data_out1 = reg_bank1;
	assign data_out2 = reg_bank2;
	assign data_out3 = reg_bank3;
	assign data_out4 = reg_bank4;
	
	assign data_out5 = reg_bank5;
	assign data_out6 = reg_bank6;
	assign data_out7 = reg_bank7;
	assign data_out8 = reg_bank8;
	assign data_out9 = reg_bank9;
	
	assign data_out10 = reg_bank10;
	assign data_out11 = reg_bank11;
	assign data_out12 = reg_bank12;
	assign data_out13 = reg_bank13;
	assign data_out14 = reg_bank14;
	
	assign data_out15 = reg_bank15;
	assign data_out16 = reg_bank16;
	assign data_out17 = reg_bank17;
	assign data_out18 = reg_bank18;
	assign data_out19 = reg_bank19;
	
endmodule
