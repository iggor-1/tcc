`timescale 1 ns/1 ns  // time-unit = 1 ns, precision = 10 ps

module nids_tb;

   reg			clk;
   reg			rst;
	 
	reg			tx_ok;
	
	reg			rx_init;
	reg  [7:0]	data_in;
	
	wire			rx_ok;
	
	wire			tx_init;
	wire [2:0]	tx_drop;
	
	wire [1:0]	byte_offset;
	wire [4:0]	word_offset;
		
	wire			start;
	wire			done;
	wire			drop;
	
	wire			debug0;
	wire			debug1;
	wire			debug2;
	wire			debug3;
	wire			debug4;
	wire			debug5;
	wire			debug6;
	wire			debug7;
	
//	reg [319:0]	pkg0;
//	reg [319:0]	pkg1;
//	reg [319:0]	pkg2;
//	reg [319:0]	pkg3;
	
	reg [7:0]   in_byte;
	
	integer	finding = 0;
	integer			found = 0;
	
	integer		started = 0;
	
	integer i = 0;
	integer j = 0;
	
	integer count_done = 0;
	integer count_drop = 0;
	
	integer end_of_file = 0;
	integer fd, file_is_open;
	
	nids nids	(	.clk(clk),
						.rst(rst),
		
						.tx_ok(tx_ok),
	
						.rx_init(rx_init),
						.data_in(data_in),
	
						.rx_ok(rx_ok),
	
						.tx_init(tx_init),
						.tx_drop(tx_drop),
						
						.byte_offset(byte_offset),
						.word_offset(word_offset),
						
						.start(start),
						.done(done),
						.drop(drop),
						
						.debug0(debug0),
						.debug1(debug1),
						.debug2(debug2),
						.debug3(debug3),
						.debug4(debug4),
						.debug5(debug5),
						.debug6(debug6),
						.debug7(debug7)
					);

	always 
	begin
		clk = 1'b0; 
		#1;

		clk = 1'b1;
		#1;
	end
	
	always @(posedge drop)
	begin
		count_drop = count_drop + 1;
	end
	
	always @(posedge done)
	begin
		count_done = count_done + 1;
	end
	
   initial
	begin	
		fd = $fopen("C:\\Users\\iggor\\OneDrive\\Documentos\\MBA\\datasets\\malicious\\japan\\01_20200902191856.pcap","rb");
		//fd = $fopen("C:\\Users\\iggor\\OneDrive\\Documentos\\MBA\\datasets\\bonafide\\smaller.pcap","rb");
		
		if (fd==0)
		begin
			$display("%m @%0t: Could not open pcap",$time);
			$stop;     
		end
		else
		begin
			$display("%m @%0t: Opened pcap for reading",$time);
			file_is_open = 1'b1;
		end
		
		tx_ok		= 1'b0;
		rx_init	= 1'b0;
		data_in	= 8'h00;	
		in_byte	= 8'h00;	
				
		rst = 1;
		#3;
				
		rst = 0;
		#3;

		if (file_is_open)
		begin
			while (end_of_file == 0) 
			begin
				in_byte = $fgetc(fd);
				
				if($feof(fd))
				begin
					end_of_file = 1;
				end
				
				if(end_of_file == 0)
				begin
					$display("%h",in_byte);
				
					if(found == 0)
					begin
						if(finding == 3)
						begin
							if(in_byte == 'h00)
							begin
								found = 1;
								finding = 4;
							end
							
							else
							begin
								finding = 0;
							end
						end
						
						if(finding == 2)
						begin
							if(in_byte == 'h45)
							begin
								finding = 3;
							end
						
							else
							begin
								finding = 0;
							end
						end
									
						if(finding == 1)
						begin
							if(in_byte == 'h00)
							begin
								finding = 2;
							end
							
							else
							begin
								finding = 0;
							end
						end	
						
						if(finding == 0)
						begin
							if((in_byte == 'h08) )
							begin
								finding = 1;
							end						
						end
					end
					
					if(found == 1)
					begin
						if(finding == 4)
						begin
							$display("start sending packet");
														
							if(started == 1)
							begin							
								if(i<19)
								begin
									rx_init = 1'b1;
									data_in = in_byte;
									#2;
					
									rx_init = 1'b0;
									#4;
									
									i = i+1;
								end
								
								if(i==19)
								begin
									i = 0;
									started = 0;
									found = 0;
									finding = 0;
									$display("sent packet");
								end
							end
							
							
							if(started == 0)
							begin
							
								$display("sendind 4500");
								
								rx_init = 1'b1;
								data_in = 8'h45;
								#2;
					
								rx_init = 1'b0;
								#4;
				
								rx_init = 1'b1;
								data_in = 8'h00;
								#2;
								
								rx_init = 1'b0;
								#4;
							
								started = 1;
								i = i+1;
																
							end
						end
					end
				end
				
				$display("Analyzed packets: %d", count_done);
				$display("Dropped packets: %d", count_drop);
			end
		end
	end
endmodule
