`timescale 1ns/1ns
module test();
parameter cycle=10;
parameter run_time=88000;
    reg clk;
    reg reset;
    reg ena;
    wire pm;
    wire [7:0] hh;
    wire [7:0] mm;
    wire [7:0] ss; 

count_clock u1 (.clk(clk),
                .reset(reset),
                .ena(ena),
                .pm(pm),
                .hh(hh),
                .mm(mm),
                .ss(ss) );

initial
begin
    clk=0;
    reset=0;
    ena=0;
    #25 reset = 1;
    #25 reset =0;
    #50 ena =1;
    #(run_time*cycle) $finish;
end  

always #(cycle/2) clk = ~clk;
initial
begin
    //$monitor("%d,%d,%d", ss, mm, hh);
    //$monitor("%d", pm, ena);
    $dumpfile("count_clock_wave.vcd");
    $dumpvars(0, test);
end
endmodule
