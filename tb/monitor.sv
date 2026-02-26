`include "packet_adder_item.sv"
class monitor;
virtual packet_adder_if _if;

mailbox #(packet_adder_item) scb_mbx;

task run();
    $display ("T=%0t [MONITOR] starting ...", $time);
    forever begin
        packet_adder_item item = new;
        @(posedge _if.clk); 
        
        // Sample input data
        item.in_a    = _if.in_a;
        item.in_b    = _if.in_b;
        item.in_last = _if.in_last;
        item.out_ready = _if.out_ready;
        item.in_valid = _if.in_valid;
        // Sample output data
        item.out_sum = _if.out_sum;
        item.out_last = _if.out_last;
        item.in_ready = _if.in_ready;
        item.out_valid = _if.out_valid;
        item.print("MONITOR");
        scb_mbx.put(item);
    end
endtask
endclass