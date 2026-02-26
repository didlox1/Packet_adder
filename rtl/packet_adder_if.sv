interface packet_adder_if #(
    parameter WIDTH = 8,
    parameter LAT = 2
)(input bit clk);
logic rst_n;
logic [WIDTH-1:0] in_a;
logic [WIDTH-1:0] in_b;
logic [WIDTH:0] out_sum;

logic in_ready;
logic in_valid;
logic in_last;

logic out_ready;
logic out_valid;
logic out_last;

modport DUT (
input rst_n, clk,
input in_a, in_b, in_last, in_valid,
input  out_ready,
output in_ready,
output out_sum, out_last, out_valid
);
endinterface //packet_adder_if