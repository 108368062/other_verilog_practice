`timescale 1ns / 1ns
module test;
    reg [15:0] a, b;
    reg cin;
    wire cout;
    wire [15:0] sum;

    integer i;
    integer err_cnt;
    wire [16:0]bin_sum;
    wire [16:0]bin_golden;
    wire [15:0]a_bin,b_bin;
    parameter cycle=10;//1 case ns
    parameter func_run=30000;//random case times

    bcdadd16 test1 ( .a(a), .b(b),.cin(cin),.cout(cout),.sum(sum));
assign bin_golden = a_bin + b_bin +cin;
assign a_bin = a[3-:4]+a[7-:4]*10+a[11-:4]*100+a[15-:4]*1000;
assign b_bin = b[3-:4]+b[7-:4]*10+b[11-:4]*100+b[15-:4]*1000;
assign bin_sum = sum[3-:4]+sum[7-:4]*10+sum[11-:4]*100+sum[15-:4]*1000+cout*10000;
initial begin
    err_cnt=0;
    #50;
    for (i = 0; i < func_run;i = i + 1) begin
        #cycle
        a[3-:4]= $random%4'd10;
        a[7-:4]= $random%4'd10;
        a[11-:4]= $random%4'd10;
        a[15-:4]= $random%4'd10;
        b[3-:4]= $random%4'd10;
        b[7-:4]= $random%4'd10;
        b[11-:4]= $random%4'd10;
        b[15-:4]= $random%4'd10;
        cin = $random%2;
        #5 if (bin_golden!= bin_sum)  err_cnt=err_cnt+1;
    end
    #10
    a[3-:4]= 4'd5;
    a[7-:4]= 4'd0;
    a[11-:4]= 4'd0;
    a[15-:4]= 4'd0;
    b[3-:4]= 4'd5;
    b[7-:4]= 4'd0;
    b[11-:4]= 4'd0;
    b[15-:4]= 4'd0;
    cin =0;
    #10
    a[3-:4]= 4'd9;
    a[7-:4]= 4'd0;
    a[11-:4]= 4'd0;
    a[15-:4]= 4'd0;
    b[3-:4]= 4'd9;
    b[7-:4]= 4'd0;
    b[11-:4]= 4'd0;
    b[15-:4]= 4'd0;
    cin =0;
    #10
    a[3-:4]= 4'd9;
    a[7-:4]= 4'd9;
    a[11-:4]= 4'd0;
    a[15-:4]= 4'd0;
    b[3-:4]= 4'd9;
    b[7-:4]= 4'd9;
    b[11-:4]= 4'd0;
    b[15-:4]= 4'd0;
    cin =1;
    $display ("total error cnt:%d",err_cnt);
    #100 $finish;
end                

//dump waveform
initial 
begin
    //$fsdbDumpfile("bcd16_wave.fsdb");
    //$fsdbDumpvars();
    $dumpfile("bcd16_wave.vcd");
    $dumpvars;
end

endmodule