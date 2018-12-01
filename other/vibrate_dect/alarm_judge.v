module alarm_judge(
    input clk,rst,
	 	 
	 input [15:0]dat_max,dat_min,
	 input dat_limit_en,
	 
	 output reg alarm);
	 

parameter high_threshold =16'ha000;
parameter high_cnt =10;
parameter low_threshold  =16'h4000;
parameter low_cnt  =5;

reg [7:0]high_cnter;	
always@(posedge clk)
	begin
		if(rst)high_cnter<=0;
		else
			begin
				if(pos_dat_limit_en)
					begin
						if((dat_max-dat_min)>=high_threshold)high_cnter<=high_cnter+1;
						else high_cnter<=0;
					end
				else	high_cnter<=high_cnter;
			end
		
	end

reg [7:0]low_cnter;	
always@(posedge clk)
	begin
		if(rst)low_cnter<=0;
		else
			begin
				if(pos_dat_limit_en)
					begin
						if((dat_max-dat_min)>=low_threshold)low_cnter<=low_cnter+1;
						else low_cnter<=0;
					end
				else	low_cnter<=low_cnter;
			end
		
	end
	
always@(posedge clk)
	begin
		if(rst)alarm<=0;
		else 
			begin
				if		 (high_cnter>=high_cnt)alarm<=1;
				else if(low_cnter >=low_cnt )alarm<=1;
				else								  alarm<=alarm;
			end
	end
	
endmodule