`include "riscv_defs.v"

module riscv_cache_d(

    output reg [31:0] data_out

    , input clk, rst
    , input cache_d_write_en
    , input [`CACHE_D_WRITE_LEN-1 : 0] cache_d_write
    , input [31:0] addr
    , input data_to_cache

);

reg [31:0] data_to_cache_m;
always @(posedge clk) begin
    case (cache_d_write)
        `CACHE_D_WRITE_SW: data_to_cache_m <= data_to_cache;
        // `CACHE_D_WRITE_SH: data_to_cache_m <= {data_out[31:16], data_to_cache[]};
        // TODO: support sh, sb
    endcase 
end

data_ram_32 data_ram_32_i (
    // output
    .douta(data_out),
    // input
    .clka(clk | rst), // expected to read/write at posedge // FIXME: rst for async read
    .wea(cache_d_write_en & !rst), // FIXME: rst for async write control
    .addra(addr[15:2]), 
    .dina(data_to_cache_m) 
    
);

endmodule