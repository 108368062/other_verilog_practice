//question:https://hdlbits.01xz.net/wiki/Exams/ece241_2013_q12
module top_module (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output reg Z ); 
    reg [7:0]Q;
    integer i;
    always@(posedge clk) begin
        if(enable) begin
            Q[0]<=S; 
            for (i=0;i<7;i=i+1)
                Q[i+1]<=Q[i];
        end
        else
            Q<=Q;
    end
    always@(*) begin
        case({A,B,C})
            3'h0:Z=Q[0];
            3'h1:Z=Q[1];
            3'h2:Z=Q[2];
            3'h3:Z=Q[3];
            3'h4:Z=Q[4];
            3'h5:Z=Q[5];
            3'h6:Z=Q[6];
            3'h7:Z=Q[7];
        endcase
    end
        
endmodule
