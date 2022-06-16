// Universidade de Sao Paulo
// MBA em seguranca de dados
//
// Igor Machado
//
// Decision Tree

module nids (
	
);

memory nodes_memory (
   .clk  (clk),
   .rst  (rst),
	
   .addr0 (fetch_next_addr0),
   .data0 (data0),
	
	.addr1 (fetch_next_addr1),
   .data1 (data1),
	
	.addr2 (fetch_next_addr2),
   .data2 (data2),
	
	.addr3 (fetch_next_addr3),
   .data3 (data3),
	
	.addr4 (fetch_next_addr4),
   .data4 (data4),
	
	.addr5 (fetch_next_addr5),
   .data5 (data5),
	
	.addr6 (fetch_next_addr6),
   .data6 (data6),
);

decision_tree dt0(
	.clk(clk),
	.rst(rst),
	.start(start),
	
	.data(data0),

	.l3_iph_tot_len(l3_iph_tot_len),
	.l3_iph_ihl(l3_iph_ihl),
	.l3_iph_tos(l3_iph_tos),
	.l3_iph_frag_off(l3_iph_frag_off),
	.l3_iph_id(l3_iph_id),
	.l3_iph_df(l3_iph_df),
	
	.l4_window(l4_tcph_window),
	.l4_tcph_syn(l4_tcph_syn),
	.l4_tcph_fin(l4_tcph_fin),
	.l4_tcph_rst(l4_tcph_rst),
	.l4_tcph_ack(l4_tcph_ack),
	.l4_tcph_doff(l4_tcph_doff),
	
	.fetch_next_addr(fetch_next_addr0),
	
	.accept_pkg(accept_pkg),
	.drop_pkg(drop_pkg)
);

decision_tree dt1(
	.clk(clk),
	.rst(rst),
	.start(start),
	
	.data(data1),

	.l3_iph_tot_len(l3_iph_tot_len),
	.l3_iph_ihl(l3_iph_ihl),
	.l3_iph_tos(l3_iph_tos),
	.l3_iph_frag_off(l3_iph_frag_off),
	.l3_iph_id(l3_iph_id),
	.l3_iph_df(l3_iph_df),
	
	.l4_window(l4_tcph_window),
	.l4_tcph_syn(l4_tcph_syn),
	.l4_tcph_fin(l4_tcph_fin),
	.l4_tcph_rst(l4_tcph_rst),
	.l4_tcph_ack(l4_tcph_ack),
	.l4_tcph_doff(l4_tcph_doff),
	
	.fetch_next_addr(fetch_next_addr1),
	
	.accept_pkg(accept_pkg),
	.drop_pkg(drop_pkg)
);

decision_tree dt2(
	.clk(clk),
	.rst(rst),
	.start(start),
	
	.data(data2),

	.l3_iph_tot_len(l3_iph_tot_len),
	.l3_iph_ihl(l3_iph_ihl),
	.l3_iph_tos(l3_iph_tos),
	.l3_iph_frag_off(l3_iph_frag_off),
	.l3_iph_id(l3_iph_id),
	.l3_iph_df(l3_iph_df),
	
	.l4_window(l4_tcph_window),
	.l4_tcph_syn(l4_tcph_syn),
	.l4_tcph_fin(l4_tcph_fin),
	.l4_tcph_rst(l4_tcph_rst),
	.l4_tcph_ack(l4_tcph_ack),
	.l4_tcph_doff(l4_tcph_doff),
	
	.fetch_next_addr(fetch_next_addr2),
	
	.accept_pkg(accept_pkg),
	.drop_pkg(drop_pkg)
);

decision_tree dt3(
	.clk(clk),
	.rst(rst),
	.start(start),
	
	.data(data3),

	.l3_iph_tot_len(l3_iph_tot_len),
	.l3_iph_ihl(l3_iph_ihl),
	.l3_iph_tos(l3_iph_tos),
	.l3_iph_frag_off(l3_iph_frag_off),
	.l3_iph_id(l3_iph_id),
	.l3_iph_df(l3_iph_df),
	
	.l4_window(l4_tcph_window),
	.l4_tcph_syn(l4_tcph_syn),
	.l4_tcph_fin(l4_tcph_fin),
	.l4_tcph_rst(l4_tcph_rst),
	.l4_tcph_ack(l4_tcph_ack),
	.l4_tcph_doff(l4_tcph_doff),
	
	.fetch_next_addr(fetch_next_addr3),
	
	.accept_pkg(accept_pkg),
	.drop_pkg(drop_pkg)
);

decision_tree dt4(
	.clk(clk),
	.rst(rst),
	.start(start),
	
	.data(data4),

	.l3_iph_tot_len(l3_iph_tot_len),
	.l3_iph_ihl(l3_iph_ihl),
	.l3_iph_tos(l3_iph_tos),
	.l3_iph_frag_off(l3_iph_frag_off),
	.l3_iph_id(l3_iph_id),
	.l3_iph_df(l3_iph_df),
	
	.l4_window(l4_tcph_window),
	.l4_tcph_syn(l4_tcph_syn),
	.l4_tcph_fin(l4_tcph_fin),
	.l4_tcph_rst(l4_tcph_rst),
	.l4_tcph_ack(l4_tcph_ack),
	.l4_tcph_doff(l4_tcph_doff),
	
	.fetch_next_addr(fetch_next_addr4),
	
	.accept_pkg(accept_pkg),
	.drop_pkg(drop_pkg)
);

decision_tree dt5(
	.clk(clk),
	.rst(rst),
	.start(start),
	
	.data(data5),

	.l3_iph_tot_len(l3_iph_tot_len),
	.l3_iph_ihl(l3_iph_ihl),
	.l3_iph_tos(l3_iph_tos),
	.l3_iph_frag_off(l3_iph_frag_off),
	.l3_iph_id(l3_iph_id),
	.l3_iph_df(l3_iph_df),
	
	.l4_window(l4_tcph_window),
	.l4_tcph_syn(l4_tcph_syn),
	.l4_tcph_fin(l4_tcph_fin),
	.l4_tcph_rst(l4_tcph_rst),
	.l4_tcph_ack(l4_tcph_ack),
	.l4_tcph_doff(l4_tcph_doff),
	
	.fetch_next_addr(fetch_next_addr5),
	
	.accept_pkg(accept_pkg),
	.drop_pkg(drop_pkg)
);

decision_tree dt6(
	.clk(clk),
	.rst(rst),
	.start(start),
	
	.data(data6),

	.l3_iph_tot_len(l3_iph_tot_len),
	.l3_iph_ihl(l3_iph_ihl),
	.l3_iph_tos(l3_iph_tos),
	.l3_iph_frag_off(l3_iph_frag_off),
	.l3_iph_id(l3_iph_id),
	.l3_iph_df(l3_iph_df),
	
	.l4_window(l4_tcph_window),
	.l4_tcph_syn(l4_tcph_syn),
	.l4_tcph_fin(l4_tcph_fin),
	.l4_tcph_rst(l4_tcph_rst),
	.l4_tcph_ack(l4_tcph_ack),
	.l4_tcph_doff(l4_tcph_doff),
	
	.fetch_next_addr(fetch_next_addr6),
	
	.accept_pkg(accept_pkg),
	.drop_pkg(drop_pkg)
);



endmodule
