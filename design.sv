

module SR_latch (
  input wire S,
  input wire R,
  output reg Q,
  output wire Qn
);

  assign Qn = ~Q;

  always @(*) begin
    if (S && !R) Q = 1;
    else if (!S && R) Q = 0;
    // If S=R=1 → Invalid, retain previous Q
  end

endmodule


module JK_FF (
  input wire clk,
  input wire rst,
  input wire J,
  input wire K,
  output wire Qn,
  output wire Qn1
);

  reg Q_internal;
  wire S, R;

  // JK to SR logic
  assign S = J & ~Q_internal;
  assign R = K & Q_internal;

  wire latch_Q, latch_Qn;

  // SR Latch
  SR_latch latch_inst (
    .S(S),
    .R(R),
    .Q(latch_Q),
    .Qn(latch_Qn)
  );

  // Flip-flop behavior on rising edge
  always @(posedge clk or posedge rst) begin
    if (rst)
      Q_internal <= 0;
    else
      Q_internal <= latch_Q;  // Sample latch output
  end

  assign Qn = Q_internal;
  assign Qn1 = ~Q_internal;

endmodule
