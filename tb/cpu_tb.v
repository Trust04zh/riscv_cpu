// testbench for cpu instruction execution
`timescale 1ns / 1ps
module cpu_tb( );

reg raw_clk, rst;

riscv_cpu u_riscv_cpu(
    .raw_clk(raw_clk)
    , .rst(rst)
	, .sw(24'hfff)
	, .start_pg(1'b0)
	, .rx(1'b0)
);

initial raw_clk = 1'b0; 

always #5 raw_clk = ~raw_clk;

initial begin
    rst = 1'b1;
    #50 rst = 1'b0;
end

initial #10000 $finish;

endmodule
