// Universidade de Sao Paulo
// MBA em seguranca de dados
//
// Igor Machado
//
// Decision Tree

module header_mux (
	input  [15:0] l3_iph_tot_len,
   input  [3:0]  l3_iph_ihl,
   input  [7:0]  l3_iph_tos,
   input  [12:0] l3_iph_frag_off,
   input  [15:0] l3_iph_id,
   input         l3_iph_df,
	
   input  [15:0] l4_tcph_window,
   input         l4_tcph_syn,
   input         l4_tcph_fin,
   input         l4_tcph_rst,
   input         l4_tcph_ack,
   input  [3:0]  l4_tcph_doff,
	
	input  [3:0]  node_header,
	
	output [15:0] select_header
);

   wire [5:0]   l4_tcph_doff_t4;
   wire [5:0]   l3_iph_ihl_t4;
   wire [5:0]   ip_ihl_m_doff;
   wire [15:0]  l4_tcp_segment_length;
	
   reg  [15:0]  input_header;

	assign l4_tcph_doff_t4       = (l4_tcph_doff << 2);
   assign l3_iph_ihl_t4         = (l3_iph_ihl   << 2);
   assign ip_ihl_m_doff         = (l3_iph_ihl_t4 - l4_tcph_doff_t4);
   assign l4_tcp_segment_length = l3_iph_tot_len - {10'h0,ip_ihl_m_doff};
	
	assign select_header = input_header;

   always @(*)
   begin
      case (node_header)
         4'h0  : input_header = l3_iph_id;
         4'h1  : input_header = {3'h0,(l3_iph_df & l3_iph_frag_off)};
         4'h2  : input_header = l3_iph_tot_len;
         4'h3  : input_header = {8'h0,l3_iph_tos};
         4'h4  : input_header = l4_tcp_segment_length;
         4'h5  : input_header = {10'h0,l4_tcph_doff_t4};
         4'h6  : input_header = {15'h0,l4_tcph_fin};
         4'h7  : input_header = {15'h0,l4_tcph_syn};
         4'h8  : input_header = {15'h0,l4_tcph_rst};
         4'h9  : input_header = l3_iph_id;
         4'hA  : input_header = {15'h0,l4_tcph_ack};
         4'hD  : input_header = l4_tcph_window;
         default:input_header = 16'h0;
      endcase		
   end
endmodule