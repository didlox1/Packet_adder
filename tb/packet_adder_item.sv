`ifndef PACKET_ADDER_ITEM
`define PACKET_ADDER_ITEM
//Used in the monitor/driver/scoreboard movement
class packet_adder_item #(int WIDTH = 8);
rand logic [WIDTH-1:0] in_a;
rand logic [WIDTH-1:0] in_b;
rand logic          in_last;
rand logic          out_ready;
rand logic          in_valid;

logic [WIDTH:0]     out_sum;
logic               out_last;
logic               in_ready;
logic               out_valid;

constraint in_valid_dist {in_valid dist {1:=95, 0:=5};}
constraint out_ready_dist {out_ready dist {1:=95, 0:=5};}

//To print out object's content in different testbench components (driver, monitor, etc)
function void print(string component);
    $display("T=%0t [%s] in_a = %0h, in_b = %0h, in_last = %0b, out_ready = %0b, in_valid = %0b, out_sum_b = %0h, out_last = %0b, in_ready = %0b, out_valid = %0b",  $time, component, in_a, in_b, in_last, out_ready, in_valid, out_sum, out_last, in_ready, out_valid);
endfunction
endclass
`endif