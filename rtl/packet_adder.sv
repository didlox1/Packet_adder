module packet_adder (packet_adder_if.DUT _if);
  // Simple LAT-stage "valid + payload" shift register.

  logic                 valid_pipe [_if.LAT:0];
  logic [_if.WIDTH:0]   sum_pipe [_if.LAT:0];
  logic                 last_pipe[_if.LAT:0];

  // For the backpressure mechanism (stop shifting of the pipeline)
  assign _if.in_ready = _if.out_ready;

  // Outputs
  assign _if.out_valid = valid_pipe[_if.LAT];
  assign _if.out_sum   = sum_pipe[_if.LAT];
  assign _if.out_last  = last_pipe[_if.LAT];

  integer i;
  always_ff @(posedge _if.clk or negedge _if.rst_n) begin
    if (!_if.rst_n) begin
      for (i = 0; i <= _if.LAT; i++) begin
        valid_pipe[i] <= 1'b0;
        sum_pipe[i]   <= '0;
        last_pipe[i]  <= 1'b0;
      end
    end else if (_if.out_ready) begin
      for (i = _if.LAT; i > 0; i--) begin        
        valid_pipe[i]  <= valid_pipe[i-1];
        sum_pipe[i]    <= sum_pipe[i-1];
        last_pipe[i]   <= last_pipe[i-1];
      end

      valid_pipe[0]  <= _if.in_valid;
      sum_pipe[0]    <= _if.in_a + _if.in_b;
      last_pipe[0]   <= _if.in_last;
    end
  end
endmodule