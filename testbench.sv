

`timescale 1ns/1ps

module tb_JK_FF;
  reg clk, rst, J, K;
  reg Qn, Qn1;

  JK_FF uut (
    .clk(clk),
    .rst(rst),
    .J(J),
    .K(K),
    .Qn(Qn),
    .Qn1(Qn1)
  );

  initial begin
    $dumpfile("jk_ff.vcd");
    $dumpvars(0, tb_JK_FF);
    clk = 0;
    forever #5 clk = ~clk;  // 10ns clock
  end

  initial begin
    // Reset
    rst = 1; J = 0; K = 0;
    #10 rst = 0;
		Qn = 0; Qn1 = 1;
    // Apply combinations of J and K
    #10 J = 0; K = 0; // Hold
    #10 J = 1; K = 0; // Set
    #10 J = 0; K = 1; // Reset
    #10 J = 1; K = 1; // Toggle
    #10 J = 1; K = 1; // Toggle again
    #10 J = 0; K = 0; // Hold
    #10 rst = 1;       // Reset again
    #10 rst = 0;
    #10 $finish;
  end
initial begin
  $display("Time\tJ K | Qn Qn1");
  $monitor("%0t\t%b %b | %b  %b", $time, J, K, Qn, Qn1);
end
endmodule
