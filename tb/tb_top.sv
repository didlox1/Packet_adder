`include "env.sv"
`include "test.sv"

module tb_top();
bit clk;
always #10 clk = ~clk;

packet_adder_if _if(clk);
packet_adder p0(_if);
test t0;

initial begin
    {clk, _if.rst_n} <= 0;

    // Reset high
    #20 _if.rst_n <= 1;
    t0 = new;
    t0.e0.vif = _if;
    t0.run();

    // To end forever loops
    #50 $finish;
end

initial begin
    $dumpvars;
    $dumpfile ("dump.vcd");
end

endmodule