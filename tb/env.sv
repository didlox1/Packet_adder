`include "packet_adder_item.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class env;
  driver d0; 		// Driver handle
  monitor m0; 		// Monitor handle
  generator g0; 		// Generator Handle
  scoreboard s0;

  mailbox #(packet_adder_item)	drv_mbx; 
  mailbox #(packet_adder_item)	drv2scb_mbx;
  mailbox #(packet_adder_item)	scb_mbx; 
  event 	drv_done; 

  virtual packet_adder_if vif;

  function new();
    d0 = new;
    m0 = new;
    g0 = new;
    s0 = new;
    
    drv_mbx = new();
    scb_mbx = new();
    drv2scb_mbx = new(); 

    d0.drv_mbx = drv_mbx;
    g0.drv_mbx = drv_mbx;
    m0.scb_mbx = scb_mbx;
    s0.scb_mbx = scb_mbx;

    s0.drv2scb_mbx = drv2scb_mbx;
    d0.drv2scb_mbx = drv2scb_mbx;

    d0.drv_done = drv_done;
    g0.drv_done = drv_done;
  endfunction

  virtual task run();
    d0._if = vif;
    m0._if = vif;

    fork
      d0.run();
      m0.run();
      g0.run();
      s0.run();
    join_any
  endtask
endclass