`include "riscv_defs.v"

module riscv_cache_d (

    output [31:0] data_out

    , input clk, rst
    , input cache_d_write_en
    , input [`CACHE_D_WRITE_LEN-1 : 0] cache_d_write
    , input [31:0] addr
    , input [31:0] data_to_cache
    
    // UART Programmer Pinouts 
    , input upg_rst_i // UPG reset (Active High) 
    , input upg_clk_i // UPG ram_clk_i (10MHz) 
    , input upg_wen_i // UPG write enable 
    , input [13:0] upg_adr_i // UPG write address 
    , input [31:0] upg_dat_i // UPG write data 
    , input upg_done_i // 1 if programming is finished

);

reg [3:0] wea;
reg [31:0] data_to_cache_m;

always @(*) begin
    if (cache_d_write_en == 0) begin
        wea = 4'b0000;
    end
    else begin
        case (cache_d_write)
            `CACHE_D_WRITE_SW: begin
                wea = 4'b1111;
                data_to_cache_m = data_to_cache;
            end
            `CACHE_D_WRITE_SH: case (addr[1])
                1'b0: begin
                    wea = 4'b0011;
                    data_to_cache_m = {{16{1'b0}}, data_to_cache[15:0]};
                end
                1'b1: begin
                    wea = 4'b1100;
                    data_to_cache_m = {data_to_cache[15:0], {16{1'b0}}};
                end
            endcase
            `CACHE_D_WRITE_SB: case (addr[1:0])
                2'b00: begin
                    wea = 4'b0001;
                    data_to_cache_m = {{24{1'b0}}, data_to_cache[7:0]};
                end
                2'b01: begin
                    wea = 4'b0010;
                    data_to_cache_m = {{16{1'b0}}, data_to_cache[7:0], {8{1'b0}}};
                end
                2'b10: begin 
                    wea = 4'b0100;
                    data_to_cache_m = {{8{1'b0}}, data_to_cache[7:0], {16{1'b0}}};
                end
                2'b11: begin
                    wea = 4'b1000;
                    data_to_cache_m = {data_to_cache[7:0], {24{1'b0}}};
                end
            endcase
        endcase 
    end
end


// CPU work on normal mode when kickOff is 1. 
// CPU work on Uart communicate mode when kickOff is 0.

wire kickOff = upg_rst_i | (~upg_rst_i & upg_done_i); 

data_ram_32 data_ram_32_i (
    // output
    .douta(data_out),
    // input
    .clka(kickOff ? (clk | rst) : upg_clk_i), // expected to read/write at posedge // FIXME: rst for async read
    .wea(kickOff ? wea : (upg_wen_i?4'b1111:4'b0)), 
    .addra(kickOff ? addr[15:2] : upg_adr_i), 
    .dina(kickOff ? data_to_cache_m : upg_dat_i) 
    
);

endmodule
