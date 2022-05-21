`include "riscv_defs.v"

module riscv_io_bridge (
    
    output [31:0] data_out

    , output reg [23:0] led 

    , input clk, rst
    , input cache_d_write_en
    , input [`CACHE_D_WRITE_LEN-1 : 0] cache_d_write
    , input [31:0] addr
    , input data_to_cache 

    , input [23:0] sw 

);

wire is_io, is_sw, is_led;
reg [31:0] data_out_io;
wire [31:0] data_out_cache;
reg [31:0] data_to_io;

// io reserved: 0xfffffc00 - 0xfffffcff
assign is_io = ((addr & 32'hfffffc00) == 32'hfffffc00);
// sw: 0xfffffc01 - 0xfffffc03
assign is_sw = ((addr & 32'hfffffffc) == 32'hfffffc00);
// led: 0xfffffc05 - 0xfffffc07
assign is_led = ((addr & 32'hfffffffc) == 32'hfffffc04);
assign data_out = (is_io == 1) ? data_out_io : data_out_cache;

// read io
always @(*) begin
    if (is_sw) begin
        data_out_io = {8'h00, sw};
    end
    else if (is_led) begin
        data_out_io = {8'h00, led};
    end
    else begin
        data_out_io = 32'h00000000;
    end
end

// write io
always @(posedge clk) begin
    if (cache_d_write_en & is_io) begin
        case (cache_d_write)
            `CACHE_D_WRITE_SW: data_to_io = data_to_cache;
            `CACHE_D_WRITE_SH: data_to_io = {data_out[31:16], data_out_cache[15:0]};
            `CACHE_D_WRITE_SB: data_to_io = {data_out[31:8], data_out_cache[7:0]};
        endcase 
        if (is_led) begin
            led <= data_to_io[23:0];
        end
    end
end

riscv_cache_d u_riscv_cache_d(
    // output
    .data_out(data_out_cache)
    // input
    , .clk(clk)
    , .rst(rst)
    , .cache_d_write_en(cache_d_write_en & ~is_io)
    , .addr(addr)
    , .data_to_cache(data_to_cache)
);

endmodule