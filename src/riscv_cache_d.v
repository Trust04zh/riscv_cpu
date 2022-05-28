`include "riscv_defs.v"

module riscv_cache_d (

    output [31:0] data_out

    , input clk, rst
    , input cache_d_write_en
    , input [`CACHE_D_WRITE_LEN-1 : 0] cache_d_write
    , input [31:0] addr
    , input data_to_cache
    
    // UART Programmer Pinouts 
    , input upg_rst_i // UPG reset (Active High) 
    , input upg_clk_i // UPG ram_clk_i (10MHz) 
    , input upg_wen_i // UPG write enable 
    , input [13:0] upg_adr_i // UPG write address 
    , input [31:0] upg_dat_i // UPG write data 
    , input upg_done_i // 1 if programming is finished

);

reg [3:0] wea;

always @(posedge clk) begin
    if (cache_d_write_en == 0) begin
        wea = 4'b0000;
    end
    else begin
        case (cache_d_write)
            `CACHE_D_WRITE_SW: wea = 4'b1111;
            `CACHE_D_WRITE_SH: wea = 4'b0011;
            `CACHE_D_WRITE_SB: wea = 4'b0001;
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
    .wea(kickOff ? wea : upg_wen_i), 
    .addra(kickOff ? addr[15:2] : upg_adr_i), 
    .dina(kickOff ? data_to_cache : upg_dat_i) 
    
);

endmodule