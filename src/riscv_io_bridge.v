`include "riscv_defs.v"

module riscv_io_bridge (
    
    output [31:0] data_out

    , output reg [31:0] led 

    , input clk, rst
    , input cache_d_write_en
    , input [`CACHE_D_WRITE_LEN-1 : 0] cache_d_write
    , input [31:0] addr
    , input [31:0] data_to_cache 

    , input [23:0] sw 
    , input [4:0] keyboard

    // UART Programmer Pinouts 
    , input upg_rst_i // UPG reset (Active High) 
    , input upg_clk_i // UPG ram_clk_i (10MHz) 
    , input upg_wen_i // UPG write enable 
    , input [13:0] upg_adr_i // UPG write address 
    , input [31:0] upg_dat_i // UPG write data 
    , input upg_done_i // 1 if programming is finished

);

wire is_io, is_sw, is_led, is_kb;
reg [31:0] data_out_io;
wire [31:0] data_out_cache;

// io reserved: 0xfffffc00 - 0xfffffcff
assign is_io = ((addr & 32'hffffff00) == 32'hfffffc00);
// sw: 0xfffffc01 - 0xfffffc03
assign is_sw = ((addr & 32'hfffffffc) == 32'hfffffc00);
// led: 0xfffffc05 - 0xfffffc07
assign is_led = ((addr & 32'hfffffffc) == 32'hfffffc04);
// kb(keyboard): 0xfffffc0b - 0xfffffc0b
assign is_kb = ((addr & 32'hfffffffc) == 32'hfffffc08);
assign data_out = (is_io == 1) ? data_out_io : data_out_cache;

// read io
always @(*) begin
    if (is_sw) begin
        data_out_io = {8'h00, sw};
    end
    else if (is_led) begin
        data_out_io = led;
    end
    else if (is_kb) begin
        data_out_io = {23'h000000, keyboard};
    end
    else begin
        data_out_io = 32'h00000000;
    end
end

// write io
reg [31:0] data_to_io;
always @(*) begin
    case (cache_d_write)
        `CACHE_D_WRITE_SW: data_to_io = data_to_cache;
        `CACHE_D_WRITE_SH: case (addr[1])
            1'b0: data_to_io = {data_out[31:16], data_to_cache[15:0]};
            1'b1: data_to_io = {data_to_cache[31:16], data_out[15:0]};
        endcase
        `CACHE_D_WRITE_SB: case (addr[1:0])
            2'b00: data_to_io = {data_out[31:8], data_to_cache[7:0]};
            2'b01: data_to_io = {data_out[31:16], data_to_cache[15:8], data_out[7:0]};
            2'b10: data_to_io = {data_out[31:24], data_to_cache[23:16], data_out[15:0]};
            2'b11: data_to_io = {data_to_cache[31:24], data_out[23:0]};
        endcase
    endcase 
end
always @(posedge clk or posedge rst) begin
    if (rst == 1) begin
        led <= 32'h0000_0000;
    end
    else if (cache_d_write_en & is_io) begin
        if (is_led) begin
            led <= data_to_io;
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
    , .cache_d_write(cache_d_write)
    , .addr(addr)
    , .data_to_cache(data_to_cache)
    
    , .upg_rst_i(upg_rst_i)
    , .upg_clk_i(upg_clk_i)
    , .upg_wen_i(upg_wen_i)
    , .upg_adr_i(upg_adr_i)
    , .upg_dat_i(upg_dat_i)
    , .upg_done_i(upg_done_i)
);

endmodule