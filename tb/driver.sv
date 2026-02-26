`include "packet_adder_item.sv"
class driver;
virtual packet_adder_if _if;
event drv_done;
mailbox #(packet_adder_item) drv_mbx;
mailbox #(packet_adder_item) drv2scb_mbx; //for comparison

task run();
    $display ("T=%0t [DRIVER] starting ...", $time);
    forever begin
        packet_adder_item item;
        @(posedge _if.clk);
        $display ("T=%0t [DRIVER] waiting for item ...", $time);

        drv_mbx.get(item);
        
        // drive
        _if.in_a      <= item.in_a;
        _if.in_b      <= item.in_b;
        _if.in_last   <= item.in_last;
        _if.out_ready <= item.out_ready;
        _if.in_valid <= item.in_valid;
        item.print("DRIVER");

        drv2scb_mbx.put(item);
        // trigger event
        ->drv_done;
    end
endtask
endclass