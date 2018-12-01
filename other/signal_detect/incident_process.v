`timescale 1ns / 1ns
module incident_process(
    input clk,rst,
	 
	 input Ch0_alarm,
	 input Ch1_alarm,
	 input Ch2_alarm,
	 input Ch3_alarm,
	 
	 input Ch0_disconnect,
	 input Ch1_disconnect,
	 input Ch2_disconnect,
	 input Ch3_disconnect,
	 
	 input Ch0_trouble,
	 input Ch1_trouble,
	 input Ch2_trouble,
	 input Ch3_trouble,
	 input trouble_detect_over,
	 
	 output reg incident_inform,
	 output reg[7:0]incident_b0,
	 output reg[7:0]incident_b1,
	 output reg[7:0]incident_b2,
	 output reg[7:0]incident_b3
	 
	 );
	 
wire alarm =Ch0_alarm || Ch1_alarm || Ch2_alarm || Ch3_alarm;
wire disconnect = Ch0_disconnect || Ch1_disconnect || Ch2_disconnect || Ch3_disconnect;
wire trouble = Ch0_trouble || Ch1_trouble || Ch2_trouble || Ch3_trouble;
//////////////////////alarm incident
wire pos_Ch0_alarm,neg_Ch0_alarm;
wire pos_Ch1_alarm,neg_Ch1_alarm;
wire pos_Ch2_alarm,neg_Ch2_alarm;
wire pos_Ch3_alarm,neg_Ch3_alarm;

reg Ch0_alarm_r0,Ch0_alarm_r1,Ch0_alarm_r2;
reg Ch1_alarm_r0,Ch1_alarm_r1,Ch1_alarm_r2;
reg Ch2_alarm_r0,Ch2_alarm_r1,Ch2_alarm_r2;
reg Ch3_alarm_r0,Ch3_alarm_r1,Ch3_alarm_r2;

always@(posedge clk)
	begin
		Ch0_alarm_r0<=Ch0_alarm;
		Ch0_alarm_r1<=Ch0_alarm_r0;
		Ch0_alarm_r2<=Ch0_alarm_r1;
		
	   Ch1_alarm_r0<=Ch1_alarm;
		Ch1_alarm_r1<=Ch1_alarm_r0;
		Ch1_alarm_r2<=Ch1_alarm_r1;
		
	   Ch2_alarm_r0<=Ch2_alarm;
		Ch2_alarm_r1<=Ch2_alarm_r0;
		Ch2_alarm_r2<=Ch2_alarm_r1;
		
		Ch3_alarm_r0<=Ch3_alarm;
		Ch3_alarm_r1<=Ch3_alarm_r0;
		Ch3_alarm_r2<=Ch3_alarm_r1;
	end

assign pos_Ch0_alarm=(~Ch0_alarm_r2)&Ch0_alarm_r1;
assign pos_Ch1_alarm=(~Ch1_alarm_r2)&Ch1_alarm_r1;
assign pos_Ch2_alarm=(~Ch2_alarm_r2)&Ch2_alarm_r1;
assign pos_Ch3_alarm=(~Ch3_alarm_r2)&Ch3_alarm_r1;

assign neg_Ch0_alarm=Ch0_alarm_r2&(~Ch0_alarm_r1); 
assign neg_Ch1_alarm=Ch1_alarm_r2&(~Ch1_alarm_r1); 
assign neg_Ch2_alarm=Ch2_alarm_r2&(~Ch2_alarm_r1); 
assign neg_Ch3_alarm=Ch3_alarm_r2&(~Ch3_alarm_r1); 
//////////////////////disconnect incident
wire pos_Ch0_disconnect,neg_Ch0_disconnect;
wire pos_Ch1_disconnect,neg_Ch1_disconnect;
wire pos_Ch2_disconnect,neg_Ch2_disconnect;
wire pos_Ch3_disconnect,neg_Ch3_disconnect;

reg Ch0_disconnect_r0,Ch0_disconnect_r1,Ch0_disconnect_r2;
reg Ch1_disconnect_r0,Ch1_disconnect_r1,Ch1_disconnect_r2;
reg Ch2_disconnect_r0,Ch2_disconnect_r1,Ch2_disconnect_r2;
reg Ch3_disconnect_r0,Ch3_disconnect_r1,Ch3_disconnect_r2;

always@(posedge clk)
	begin
		Ch0_disconnect_r0<=Ch0_disconnect;
		Ch0_disconnect_r1<=Ch0_disconnect_r0;
		Ch0_disconnect_r2<=Ch0_disconnect_r1;
		
	   Ch1_disconnect_r0<=Ch1_disconnect;
		Ch1_disconnect_r1<=Ch1_disconnect_r0;
		Ch1_disconnect_r2<=Ch1_disconnect_r1;
		
	   Ch2_disconnect_r0<=Ch2_disconnect;
		Ch2_disconnect_r1<=Ch2_disconnect_r0;
		Ch2_disconnect_r2<=Ch2_disconnect_r1;
		
		Ch3_disconnect_r0<=Ch3_disconnect;
		Ch3_disconnect_r1<=Ch3_disconnect_r0;
		Ch3_disconnect_r2<=Ch3_disconnect_r1;
	end

assign pos_Ch0_disconnect=(~Ch0_disconnect_r2)&Ch0_disconnect_r1;
assign pos_Ch1_disconnect=(~Ch1_disconnect_r2)&Ch1_disconnect_r1;
assign pos_Ch2_disconnect=(~Ch2_disconnect_r2)&Ch2_disconnect_r1;
assign pos_Ch3_disconnect=(~Ch3_disconnect_r2)&Ch3_disconnect_r1;

assign neg_Ch0_disconnect=Ch0_disconnect_r2&(~Ch0_disconnect_r1); 
assign neg_Ch1_disconnect=Ch1_disconnect_r2&(~Ch1_disconnect_r1); 
assign neg_Ch2_disconnect=Ch2_disconnect_r2&(~Ch2_disconnect_r1); 
assign neg_Ch3_disconnect=Ch3_disconnect_r2&(~Ch3_disconnect_r1); 
//////////////////////trouble incident
wire pos_Ch0_trouble,neg_Ch0_trouble;
wire pos_Ch1_trouble,neg_Ch1_trouble;
wire pos_Ch2_trouble,neg_Ch2_trouble;
wire pos_Ch3_trouble,neg_Ch3_trouble;
wire pos_trouble_detect_over,neg_trouble_detect_over;

reg Ch0_trouble_r0,Ch0_trouble_r1,Ch0_trouble_r2;
reg Ch1_trouble_r0,Ch1_trouble_r1,Ch1_trouble_r2;
reg Ch2_trouble_r0,Ch2_trouble_r1,Ch2_trouble_r2;
reg Ch3_trouble_r0,Ch3_trouble_r1,Ch3_trouble_r2;
reg trouble_detect_over_r0,trouble_detect_over_r1,trouble_detect_over_r2;

always@(posedge clk)
	begin
		Ch0_trouble_r0<=Ch0_trouble;
		Ch0_trouble_r1<=Ch0_trouble_r0;
		Ch0_trouble_r2<=Ch0_trouble_r1;
		
	   Ch1_trouble_r0<=Ch1_trouble;
		Ch1_trouble_r1<=Ch1_trouble_r0;
		Ch1_trouble_r2<=Ch1_trouble_r1;
		
	   Ch2_trouble_r0<=Ch2_trouble;
		Ch2_trouble_r1<=Ch2_trouble_r0;
		Ch2_trouble_r2<=Ch2_trouble_r1;
		
		Ch3_trouble_r0<=Ch3_trouble;
		Ch3_trouble_r1<=Ch3_trouble_r0;
		Ch3_trouble_r2<=Ch3_trouble_r1;
		
		trouble_detect_over_r0<=trouble_detect_over;
		trouble_detect_over_r1<=trouble_detect_over_r0;
		trouble_detect_over_r2<=trouble_detect_over_r1;
	end

assign pos_Ch0_trouble=(~Ch0_trouble_r2)&Ch0_trouble_r1;
assign pos_Ch1_trouble=(~Ch1_trouble_r2)&Ch1_trouble_r1;
assign pos_Ch2_trouble=(~Ch2_trouble_r2)&Ch2_trouble_r1;
assign pos_Ch3_trouble=(~Ch3_trouble_r2)&Ch3_trouble_r1;
assign pos_trouble_detect_over=(~trouble_detect_over_r2)&trouble_detect_over_r1;

assign neg_Ch0_trouble=Ch0_trouble_r2&(~Ch0_trouble_r1); 
assign neg_Ch1_trouble=Ch1_trouble_r2&(~Ch1_trouble_r1); 
assign neg_Ch2_trouble=Ch2_trouble_r2&(~Ch2_trouble_r1); 
assign neg_Ch3_trouble=Ch3_trouble_r2&(~Ch3_trouble_r1); 
//////////////////////trouble incident
always@(posedge clk)
	begin
		if((pos_Ch0_alarm)||(pos_Ch1_alarm)||(pos_Ch2_alarm)||(pos_Ch3_alarm)||
			(neg_Ch0_alarm)||(neg_Ch1_alarm)||(neg_Ch2_alarm)||(neg_Ch3_alarm)||
			(pos_Ch0_disconnect)||(pos_Ch1_disconnect)||(pos_Ch2_disconnect)||(pos_Ch3_disconnect)||
			(neg_Ch0_disconnect)||(neg_Ch1_disconnect)||(neg_Ch2_disconnect)||(neg_Ch3_disconnect)||
			(pos_Ch0_trouble)||(pos_Ch1_trouble)||(pos_Ch2_trouble)||(pos_Ch3_trouble)||
			(neg_Ch0_trouble)||(neg_Ch1_trouble)||(neg_Ch2_trouble)||(neg_Ch3_trouble)||(pos_trouble_detect_over))
			incident_inform<=1;
		else incident_inform<=0;  
		incident_b0<=8'hE0;
		incident_b1<={3'b0,trouble_detect_over,1'b0,alarm,disconnect,trouble};
		incident_b2<={Ch3_disconnect,Ch2_disconnect,Ch1_disconnect,Ch0_disconnect,Ch3_trouble,Ch2_trouble,Ch1_trouble,Ch0_trouble};
		incident_b3<={Ch3_alarm,Ch2_alarm,Ch1_alarm,Ch0_alarm,4'b0};
	end
	
endmodule