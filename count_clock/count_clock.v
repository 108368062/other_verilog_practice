//question:https://hdlbits.01xz.net/wiki/Count_clock
module count_clock(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
	wire ssena;
    wire [1:0]mmena;
	wire hhena;
	wire hh_clr;
    assign ssena=(ss[3:0]==4'h9&&ena)?1'b1:1'b0;
	assign mmena[0]=(ss[7:0]==8'h59&&ena)?1'b1:1'b0;
	assign mmena[1]=(mm[3:0]==4'h9&&mmena[0]&&ena)?1'b1:1'b0;
	assign hhena=(ss[7:0]==8'h59&&mm[7:0]==8'h59&&ena)?1'b1:1'b0;
    assign hh_clr=(ss[7:0]==8'h59&&mm[7:0]==8'h59&&hh[7:0]==8'h11);
    always@(posedge clk)
        pm=(reset)?1'b0:(hh_clr)?~pm:pm;
        
    bcd_1_digit ss1 (.clk(clk),.ena(ena),.reset(reset),.q(ss[3:0]),.mode(1'b0));
    bcd_1_digit ss2 (.clk(clk),.ena(ssena),.reset(reset),.q(ss[7:4]),.mode(1'b1));
    bcd_1_digit mm1 (.clk(clk),.ena(mmena[0]),.reset(reset),.q(mm[3:0]),.mode(1'b0));
    bcd_1_digit mm2 (.clk(clk),.ena(mmena[1]),.reset(reset),.q(mm[7:4]),.mode(1'b1));
	//for hour
    bcd_hh_8bit hh0 (.clk(clk),.ena(hhena),.reset(reset),.q(hh[7:0]));
	

endmodule


module bcd_1_digit(
    input clk,
    input reset,
    input ena,
	input mode,//mode 0,0~9,mode1:0~5
    output reg [3:0] q );
     wire cnt_inc0, cnt_clr0;
	 wire cnt_inc1, cnt_clr1;
	//mode 0,0~9,mode1:0~5
    assign cnt_inc0 = q<4'd9&ena&(mode==0);
    assign cnt_clr0 = q==4'd9&ena&(mode==0);
    assign cnt_inc1 = q<4'd5&ena&(mode==1);
    assign cnt_clr1 = q==4'd5&ena&(mode==1);
    always@(posedge clk) begin
        if(reset)
            q<=0;
        else
        begin
            if(cnt_inc0 | cnt_inc1)
                q<=q+4'd1;
            else if(cnt_clr0 | cnt_clr1)
                q<=4'd0;
            else
                q<=q;
        end
    end
endmodule

//for hour use counter
module bcd_hh_8bit(
    input clk,
    input reset,
    input ena,
    output reg [7:0] q);
	reg [3:0]temp;
    wire cnt_inc, cnt_clr;
    assign cnt_inc = temp<4'd11&ena;
    assign cnt_clr = temp==4'd11&ena;
    always@(posedge clk) begin
        if(reset)
            temp<=4'd0;
        else
        begin
            if(cnt_inc)
                temp<=temp+4'd1;
            else if(cnt_clr)
                temp<=4'd0;
            else
                temp<=temp;
        end
    end
    //decode to clock is 1~12
	always@(*)
	case(temp)
    4'd0:q=8'h12;
	4'd1:q=8'h01;
	4'd2:q=8'h02;
	4'd3:q=8'h03;
	4'd4:q=8'h04;
	4'd5:q=8'h05;
	4'd6:q=8'h06;
	4'd7:q=8'h07;
	4'd8:q=8'h08;
	4'd9:q=8'h09;
	4'd10:q=8'h10;
	4'd11:q=8'h11;
	default:
	q=8'h00;
	endcase
endmodule
