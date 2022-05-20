`include "riscv_defs.v"

module riscv_cache_d(

    output reg [31:0] data_out

    , input clk, rst
    , input cache_d_write_en
    , input [`CACHE_D_WRITE_LEN-1 : 0] cache_d_write
    , input [31:0] addr
    , input data_to_cache

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

data_ram_32 data_ram_32_i (
    // output
    .douta(data_out),
    // input
    .clka(clk | rst), // expected to read/write at posedge // FIXME: rst for async read
    .wea(wea), 
    .addra(addr[15:2]), 
    .dina(data_to_cache) 
    
);

endmodule