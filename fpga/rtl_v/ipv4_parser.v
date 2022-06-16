// IPv4 PARSER
// Igor Machado

module ipv4_parser (
   input								startofpacket,
   input								endofpacket,
	
   input		[319:0]				data,
	
   output	[3:0]					l3_iph_version,
   output	[3:0]					l3_iph_ihl,
   output	[7:0]					l3_iph_tos,
   output	[15:0]				l3_iph_tot_len,
	
   output	[15:0]				l3_iph_id,
   output							l3_iph_df,
	output							l3_iph_mf,
   output	[12:0]				l3_iph_frag_off,
	
   output	[7:0]					l3_iph_ttl,
   output	[7:0]					l3_iph_protocol,
   output	[15:0]				l3_iph_checksum,
	
   output	[31:0]				l3_iph_source_addr,
   output	[31:0]				l3_iph_dest_addr,

   output	[15:0]				l4_tcph_source_port,
   output	[15:0]				l4_tcph_dest_port,
	
   output	[31:0]				l4_tcph_seq_number,
   output	[31:0]				l4_tcph_ack_number,
	
   output	[3:0]					l4_tcph_doff,
   output							l4_tcph_urg,
   output							l4_tcph_ack,
	output							l4_tcph_psh,
   output							l4_tcph_rst,
   output							l4_tcph_syn,
   output							l4_tcph_fin,
   output	[15:0]				l4_tcph_window,
	
   output	[15:0]				l4_tcph_checksum,
   output	[15:0]				l4_tcph_urg_pointer
);

   reg		[15:0]				l4_source_port;
   reg		[15:0]				l4_dest_port;
	
   reg		[31:0]				l4_seq_number;
   reg		[31:0]				l4_ack_number;
	
   reg		[3:0]					l4_doff;
   reg								l4_urg;
   reg								l4_ack;
	reg								l4_psh;
   reg								l4_rst;
   reg								l4_syn;
   reg								l4_fin;
   reg		[15:0]				l4_window;
	
   reg		[15:0]				l4_checksum;
   reg		[15:0]				l4_urg_pointer;
	
   assign   l3_iph_version			= data[319:316];
   assign   l3_iph_ihl				= data[315:312];
   assign   l3_iph_tos				= data[311:304];
   assign   l3_iph_tot_len			= data[303:288];
   assign   l3_iph_id				= data[287:272];
	
   assign	l3_iph_df				= data[270];
   assign	l3_iph_mf				= data[269];
	
   assign	l3_iph_frag_off		= data[268:256];
   assign	l3_iph_ttl				= data[255:248];
   assign	l3_iph_protocol		= data[247:240];
   assign	l3_iph_checksum		= data[239:224];
   assign	l3_iph_source_addr	= data[223:192];
   assign	l3_iph_dest_addr		= data[191:160];
	
   always @(*)
   begin
      l4_source_port				= data[159:144];
      l4_dest_port				= data[143:128];
			
      l4_seq_number				= data[127:96];
      l4_ack_number				= data[95:64];
			
      l4_doff						= data[63:60];
      l4_urg						= data[53];
      l4_ack						= data[52];
      l4_psh						= data[51];
      l4_rst						= data[50];
      l4_syn						= data[49];
      l4_fin						= data[48];
      l4_window					= data[47:32];
			
      l4_checksum					= data[31:16];
      l4_urg_pointer				= data[15:0];
   end
	
   assign	l4_tcph_source_port		= l4_source_port;
   assign	l4_tcph_dest_port			= l4_dest_port;
			
   assign	l4_tcph_seq_number		= l4_seq_number;
   assign	l4_tcph_ack_number		= l4_ack_number;
			
   assign	l4_tcph_doff				= l4_doff;
   assign	l4_tcph_urg					= l4_urg;
   assign	l4_tcph_ack					= l4_ack;
   assign	l4_tcph_psh					= l4_psh;
   assign	l4_tcph_rst					= l4_rst;
   assign	l4_tcph_syn					= l4_syn;
   assign	l4_tcph_fin					= l4_fin;
   assign	l4_tcph_window				= l4_window;
			
   assign	l4_tcph_checksum			= l4_checksum;
   assign	l4_tcph_urg_pointer		= l4_urg_pointer;
endmodule
