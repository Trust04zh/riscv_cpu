module riscv_cache_i (

    output [31:0] inst
    
    , input clk, rst
    , input [31:0] addr

);

ins_rom_32 u_ins_rom_32(
    .clka(~(clk | rst)) // expected to read at negedge // FIXME: rst for async read
    , .addra(addr[15:2])
    , .douta(inst)
);

endmodule