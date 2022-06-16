// Universidade de Sao Paulo
// MBA em seguranca de dados
//
// Igor Machado
//


module nic_connection (
	input				clk,
	input				rst,
	
	// RX
	// from/to GPIO (external)
	input				rx_init,	
	output			rx_ok,
	
	// from/to FPGA (internal)
	output			receiving,
	
	// TX	
	// from/to FPGA (internal)
	input				done,
	input	 [2:0]	drop_pkg,
	
	output [1:0]	byte_offset,
	output [4:0]	word_offset,
	
	// from/to GPIO (external)
	input				tx_ok,

	output			tx_init,
	output [2:0]	tx_drop,
	
	
	// FOR DEBUG PURPOSES ONLY
	output			init_debug,
	output			ok_debug
);
	
	reg				rx_ok_ff;
	reg				receiving_ff;
	
	reg [1:0]		byte_offset_ff;
	reg [4:0]		word_offset_ff;
	
	reg [2:0]		tx_data_ff;
	reg				tx_init_ff;
	
	reg [2:0]		drop_pkg_ff;
	
	always @(posedge clk or posedge rst)
	begin
		if(rst)
		begin
			rx_ok_ff			<= 1'b0;
			receiving_ff	<= 1'b0;
			byte_offset_ff	<=	2'b11;
			word_offset_ff	<= 5'h13;
		end
		
		else
		begin
			if(!rx_ok_ff & rx_init)
			begin
				rx_ok_ff			<= 1'b1;
				byte_offset_ff <= (byte_offset_ff == 2'b11) ? 2'b00 : (byte_offset_ff + 1'b1);
				
				if(byte_offset_ff == 2'b11)
				begin
					word_offset_ff	<= (word_offset_ff == 5'h13) ? 5'h00 : (word_offset_ff + 1'b1);
				end
			end
		
			if(rx_ok_ff & !rx_init & !receiving_ff)
				receiving_ff	<= 1'b1;
				
			if(receiving_ff)
			begin
				rx_ok_ff			<= 1'b0;
				receiving_ff	<= 1'b0;
			end		
		end
	end
	
	assign rx_ok = rx_ok_ff;
	assign byte_offset = byte_offset_ff;
	assign word_offset = word_offset_ff;
	
	always @(posedge clk or posedge rst)
	begin
		if(rst)
		begin
			tx_init_ff	<= 1'b0;
			drop_pkg_ff <= 1'b0;
		end
		
		else
		begin
			if(!tx_ok & !tx_init_ff)
			begin
				tx_init_ff  <= done;
				drop_pkg_ff <= drop_pkg;
			end
		
			if(tx_ok & tx_init_ff)
			begin
				tx_init_ff  <= 1'b0;
			end
		end
	end
	
	assign tx_init = tx_init_ff;
	assign tx_drop = drop_pkg_ff;
	
	assign receiving = receiving_ff;
	
	// FOR DEBUG PURPOSES ONLY
	assign ok_debug = rx_ok_ff;
	assign init_debug = rx_init;
		
endmodule