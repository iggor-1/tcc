// Universidade de Sao Paulo
// MBA em seguranca de dados
//
// Igor Machado
//
// Decision Tree

module nids (
	input 			clk,
	input				rst,
	
	input				tx_ok,
	
	input				rx_init,
	input  [7:0]	data_in,
	
	output			rx_ok,
	
	output			tx_init,
	output [2:0]	tx_drop,
	
	
	//DEBUG SIGNALS
	output [1:0]	byte_offset,
	output [4:0]	word_offset,
		
	output			start,
	
	output			done,
	output			drop,
	
	output			debug0,
	output			debug1,
	output			debug2,
	output			debug3,
	output			debug4,
	output			debug5,
	output			debug6,
	output			debug7
	
	
//	output	[319:0] data_to_parser
);

//	wire 				done;
//	wire				start;
	wire				receiving;
	
//	wire				start0;
//	wire				start1;
	
//	wire				drop;
	wire [2:0]		drop_pkg;
	
	wire [7:0]		rx_data;
	
//	wire [4:0]		word_offset;
//	wire [1:0]		byte_offset;
	
	wire [639:0]	data_buffer;
	
	wire [31:0]		data0;
	wire [31:0]		data1;
	wire [31:0]		data2;
	wire [31:0]		data3;
	wire [31:0]		data4;
	
	wire [31:0]		data5;
	wire [31:0]		data6;
	wire [31:0]		data7;
	wire [31:0]		data8;
	wire [31:0]		data9;
	
	wire [31:0]		data10;
	wire [31:0]		data11;
	wire [31:0]		data12;
	wire [31:0]		data13;
	wire [31:0]		data14;
	
	wire [31:0]		data15;
	wire [31:0]		data16;
	wire [31:0]		data17;
	wire [31:0]		data18;
	wire [31:0]		data19;
		
	wire [319:0]	data_to_parser;
	
   wire	[3:0]					l3_iph_version;
   wire	[3:0]					l3_iph_ihl;
   wire	[7:0]					l3_iph_tos;
   wire	[15:0]				l3_iph_tot_len;
	
   wire	[15:0]				l3_iph_id;
   wire							l3_iph_df;
   wire							l3_iph_mf;
   wire	[12:0]				l3_iph_frag_off;
	
   wire	[7:0]					l3_iph_ttl;
   wire	[7:0]					l3_iph_protocol;
   wire	[15:0]				l3_iph_checksum;
	
   wire	[31:0]				l3_iph_source_addr;
   wire	[31:0]				l3_iph_dest_addr;

   wire	[15:0]				l4_tcph_source_port;
   wire	[15:0]				l4_tcph_dest_port;
	
   wire	[31:0]				l4_tcph_seq_number;
   wire	[31:0]				l4_tcph_ack_number;
	
   wire	[3:0]					l4_tcph_doff;
   wire							l4_tcph_urg;
   wire							l4_tcph_ack;
   wire							l4_tcph_psh;
   wire							l4_tcph_rst;
   wire							l4_tcph_syn;
   wire							l4_tcph_fin;
   wire	[15:0]				l4_tcph_window;
	
   wire	[15:0]				l4_tcph_checksum;
   wire	[15:0]				l4_tcph_urg_pointer;
	
	reg			running_a_ff;
	
	reg			start0_ff;
	reg			start1_ff;
	
	reg drop_once_ff;
 	
	always @(posedge clk or posedge rst)
	begin
		if(rst)
		begin
			drop_once_ff  		<= 1'b0;
		end
		
		else
		begin
			if(drop_once_ff == 1'b0)
				drop_once_ff <= |drop_pkg;
		end
	end
 
	
	always @(posedge clk or posedge rst)
	begin
		if(rst)
		begin
			start0_ff  		<= 1'b0;			
			start1_ff		<= 1'b0;
			
			running_a_ff	<= 1'b0;
		end
		
		else
		begin
			if(!start0_ff & !running_a_ff & (byte_offset == 2'h0) & (word_offset == 5'hA))
			begin
				start0_ff   <= 1'b1;
				running_a_ff <= 1'b1;
			end
			
			if(start0_ff)
				start0_ff <= 1'b0;
			
			if(running_a_ff & !start1_ff & (byte_offset == 2'h0) & (word_offset == 5'h0))
			begin
				start1_ff   <= 1'b1;
				running_a_ff <= 1'b0;
			end
				
			if(start1_ff)
				start1_ff <= 1'b0;
				
		end
	end
	
	assign data_buffer = {	data0,  data1,  data2,	data3,
									data4,  data5,  data6,	data7,
									data8,  data9,  data10, data11,
									data12, data13, data14,	data15,
									data16, data17, data18, data19
								};
	
	assign data_to_parser = (running_a_ff) ? data_buffer[639:320] : data_buffer[319:0];
		
	assign start		= start0_ff | start1_ff;
	assign drop_pkg	= {drop, drop, drop};
	
//debug_unit debug


nic_connection nic (
	.clk(clk),
	.rst(rst),
	
	// RX
	.rx_init(rx_init),
	.rx_ok(rx_ok),
	
	.receiving(receiving),
	
	// TX	
	.done(done),
	.drop_pkg(drop_pkg),
		
	.tx_ok(tx_ok),

	.tx_init(tx_init),
	.tx_drop(tx_drop),
	
	.byte_offset(byte_offset),
	.word_offset(word_offset)
);

buffer buffer(
	.clk(clk),
	.rst(rst),
	
	.byte_offset(byte_offset),
	.word_offset(word_offset),
	
	.receiving(receiving),
	
	.data_in(data_in),
	
	.data_out0(data0),
	.data_out1(data1),
	.data_out2(data2),
	.data_out3(data3),
	.data_out4(data4),
	
	.data_out5(data5),
	.data_out6(data6),
	.data_out7(data7),
	.data_out8(data8),
	.data_out9(data9),
	
	.data_out10(data10),
	.data_out11(data11),
	.data_out12(data12),
	.data_out13(data13),
	.data_out14(data14),
	
	.data_out15(data15),
	.data_out16(data16),
	.data_out17(data17),
	.data_out18(data18),
	.data_out19(data19)
);

ipv4_parser parser (
	.data(data_to_parser),
	
	.l3_iph_version(l3_iph_version),
	.l3_iph_ihl(l3_iph_ihl),
	.l3_iph_tos(l3_iph_tos),
	.l3_iph_tot_len(l3_iph_tot_len),
	
	.l3_iph_id(l3_iph_id),
	.l3_iph_df(l3_iph_df),
	.l3_iph_mf(l3_iph_mf),
	.l3_iph_frag_off(l3_iph_frag_off),
	
	.l3_iph_ttl(l3_iph_ttl),
	.l3_iph_protocol(l3_iph_protocol),
	.l3_iph_checksum(l3_iph_checksum),
	
	.l3_iph_source_addr(l3_iph_source_addr),
	.l3_iph_dest_addr(l3_iph_dest_addr),

	.l4_tcph_source_port(l4_tcph_source_port),
	.l4_tcph_dest_port(l4_tcph_dest_port),
	
	.l4_tcph_seq_number(l4_tcph_seq_number),
	.l4_tcph_ack_number(l4_tcph_ack_number),
	
	.l4_tcph_doff(l4_tcph_doff),
	.l4_tcph_urg(l4_tcph_urg),
	.l4_tcph_ack(l4_tcph_ack),
	.l4_tcph_psh(l4_tcph_psh),
	.l4_tcph_rst(l4_tcph_rst),
	.l4_tcph_syn(l4_tcph_syn),
	.l4_tcph_fin(l4_tcph_fin),
	.l4_tcph_window(l4_tcph_window),
	
	.l4_tcph_checksum(l4_tcph_checksum),
	.l4_tcph_urg_pointer(l4_tcph_urg_pointer)
);
	
decision_tree dt0(
	.clk(clk),
	.rst(rst),
	.start(start),

	.l3_iph_tot_len(l3_iph_tot_len),
	.l3_iph_ihl(l3_iph_ihl),
	.l3_iph_tos(l3_iph_tos),
	.l3_iph_frag_off(l3_iph_frag_off),
	.l3_iph_id(l3_iph_id),
	.l3_iph_df(l3_iph_df),
	
	.l4_tcph_window(l4_tcph_window),
	.l4_tcph_syn(l4_tcph_syn),
	.l4_tcph_fin(l4_tcph_fin),
	.l4_tcph_rst(l4_tcph_rst),
	.l4_tcph_ack(l4_tcph_ack),
	.l4_tcph_doff(l4_tcph_doff),
		
	.drop_pkg(drop),
	.done(done)
);

assign debug0 = data_in[7];
assign debug1 = data_in[6];
assign debug2 = data_in[5];
assign debug3 = data_in[4];
assign debug4 = data_in[3];
assign debug5 = data_in[2];
assign debug6 = data_in[1];
assign debug7 = data_in[0];

endmodule
