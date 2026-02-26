`include "packet_adder_item.sv"
class scoreboard;
  mailbox #(packet_adder_item) drv2scb_mbx; // expected value
  mailbox #(packet_adder_item) scb_mbx;     // actual value

  packet_adder_item exp_item_q[$];

  task run();
    $display("T=%0t [SCOREBOARD] starting ...", $time);
    
    fork
      // Thread 1: Get expected items from driver
      forever begin
        packet_adder_item exp_item;
        drv2scb_mbx.get(exp_item);
        
        if (exp_item.in_valid && exp_item.out_ready) begin
          exp_item_q.push_back(exp_item);
        end
      end
      
      // Thread 2: Get actual items from DUTs outputs (monitor)
      forever begin
        packet_adder_item act_item;
        scb_mbx.get(act_item);
        
        if (act_item.out_valid && act_item.out_ready) begin
            packet_adder_item exp_item = exp_item_q.pop_front();
            // Compare
            logic [8:0] exp_sum = (exp_item.in_a + exp_item.in_b);
            if (act_item.out_sum == (exp_item.in_a + exp_item.in_b)) begin
              $display("T=%0t [SCOREBOARD] PASS! Expected: %0h, Actual: %0h", $time, exp_sum, act_item.out_sum);
            end else begin
              $display("T=%0t [SCOREBOARD] FAIL! Expected: %0h, Actual: %0h", $time, exp_sum, act_item.out_sum);
            end        
        end
      end
    join
  endtask
endclass