module test();
    parameter cycle= 10;
    reg clk, enable, A, B, C, S;
    wire Z;
    top_module s1 (.clk(clk),.enable(enable),.S(S),.A(A),.B(B),.C(C),.Z(Z));
    initial begin
        clk=0;
        enable = 0;
        S=0;
        {A,B,C}=3'h0;
        #(1*cycle)
        enable=1;
        S=1;
        #(1*cycle)
        S=0;
        #(7*cycle)
        enable=0;
        {A,B,C}=3'h0;
        #(1*cycle)
        {A,B,C}=3'h1;
        #(1*cycle)
        {A,B,C}=3'h2;
        #(1*cycle)
        {A,B,C}=3'h3;
        #(1*cycle)
        {A,B,C}=3'h4;
        #(1*cycle)
        {A,B,C}=3'h5;
        #(1*cycle)
        {A,B,C}=3'h6;
        #(1*cycle)
        {A,B,C}=3'h7;
        #(1*cycle)
        #50 $finish;
    end    
    always #(cycle/2) clk=~clk;
    initial
    begin
    //$monitor("%d,%d,%d", ss, mm, hh);
    //$monitor("%d", pm, ena);
    $dumpfile("bit_3_lut_wave.vcd");
    $dumpvars(0, test);
    end
endmodule
