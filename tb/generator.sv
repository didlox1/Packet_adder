`include "packet_adder_item.sv"
class generator;
mailbox #(packet_adder_item) drv_mbx;
event drv_done;
int number = 300;

task run();
    $display("T=%0t [GENERATOR] Number generation started", $time);
    
    for(int i = 0; i<number; i++) begin
        packet_adder_item item = new;
        item.randomize();
        drv_mbx.put(item);
        $display("T=%0t [GENERATOR] Generated number [i = %0d] ", $time, i+1);
        @(drv_done);
    end
    $display("T=%0t [GENERATOR] Number generation is done", $time);
endtask
endclass