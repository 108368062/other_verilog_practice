//description: 4-digit BCD ripple-carry adder.
//version:correct vesion
module bcdadd16 ( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );
    wire d1_of,d2_of,d3_of,d4_of;
    //detect overflow
    assign d1_of = (a[3:0]+b[3:0]+cin) >=5'd10;
    assign d2_of = (a[7:4]+b[7:4]+d1_of) >=5'd10;
    assign d3_of = (a[11:8]+b[11:8]+d2_of) >=5'd10;
    assign d4_of = (a[15:12]+b[15:12]+d3_of) >=5'd10;
    //if overflow minus 10, otherwise add only
    assign sum[3:0] = (d1_of)?(a[3:0]+b[3:0]+cin)-4'd10:(a[3:0]+b[3:0]+cin);
    assign sum[7:4] = (d2_of)?(a[7:4]+b[7:4]+d1_of)-4'd10:(a[7:4]+b[7:4]+d1_of);
    assign sum[11:8] = (d3_of)?(a[11:8]+b[11:8]+d2_of)-4'd10:(a[11:8]+b[11:8]+d2_of);
    assign sum[15:12] = (d4_of)?(a[15:12]+b[15:12]+d3_of)-4'd10:(a[15:12]+b[15:12]+d3_of);
    assign cout = d4_of;
    
endmodule