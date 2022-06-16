// Universidade de Sao Paulo
// MBA em seguranca de dados
//
// Igor Machado
//
// Decision Tree

module decision_tree (
   input         clk,
   input         rst,
   input         start, // 1-cycle pulse
	
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
		
   output        drop_pkg,
	output        done
);

	wire [31:0]	 data;
	wire [7:0]   fetch_next_addr;

   wire         comparison_result;
	
   wire [15:0]  node_threshold;
   wire [3:0]   node_header;
	
   wire [3:0]   next_node_true;
   wire [7:0]   next_node_false;
	
	wire [15:0]  select_header;

   reg          drop;
   reg          done_analysis;

   reg  [7:0]   next_addr;
	
	reg          running_ff;
   reg  [7:0]   current_node_ff;
	
   memory nodes_memory (
      .clk  (clk),
      .rst  (rst),
		
      .addr (fetch_next_addr),
      .data (data)
   );
	
	header_mux header_mux (
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
		
		.node_header(node_header),
		
		.select_header(select_header)
	);	
   
   assign fetch_next_addr     = (running_ff == 1'b0) ? 8'h0 : next_addr;
   assign comparison_result   = (select_header < node_threshold) ? 1'b1 : 1'b0;
   
   always @(posedge clk or posedge rst)
   begin
      if(rst)
      begin
         current_node_ff      <= 8'h0;
      end
      
      else
      begin
         if (running_ff)
         begin
            current_node_ff   <= next_addr;
         end
      end
   end
	
   assign node_header        = data[31:28];
   assign node_threshold     = data[27:12];
   
   assign next_node_true     = data[11:8];
   assign next_node_false    = data[7:0];
   
   always @(*)
   begin		
      if (node_threshold == 16'hFFFF)
      begin
         done_analysis   = 1'b1;
         drop		       = (next_node_true == 4'h0) ? 1'b1 : 1'b0;
         next_addr       = 8'h0;
      end
			
      else
      begin
		   done_analysis   = 1'b0;
			drop	          = 1'b0;
         next_addr       = (comparison_result == 1'b0) ?  next_node_false : 
			                                               ((next_node_true == 4'h0) ? (current_node_ff + 1'b1) : {4'h0, next_node_true});
      end
   end
	
   always @(posedge clk or posedge rst)
   begin
      if(rst)
      begin
         running_ff <= 1'b0;
      end
		
      else
      begin
         if (start)
         begin
            running_ff <= 1'b1;
         end
			
         else if (done_analysis)
         begin
            running_ff <= 1'b0;
         end
      end
   end
	
	assign drop_pkg = done_analysis & drop;
	assign done		 = done_analysis;
	
endmodule