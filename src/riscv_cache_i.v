module riscv_cache_i (

    output [31:0] inst
    
    , input clk, rst
    , input [31:0] addr
    
    // UART Programmer Pinouts 
    , input upg_rst_i // UPG reset (Active High) 
    , input upg_clk_i // UPG clock (10MHz) 
    , input upg_wen_i // UPG write enable 
    , input[13:0] upg_adr_i // UPG write address 
    , input[31:0] upg_dat_i // UPG write data 
    , input upg_done_i // 1 if program finished 

);

wire kickOff = upg_rst_i | (~upg_rst_i & upg_done_i ); 

ins_ram_32 u_ins_ram_32 ( 
.clka (kickOff ? ~(clk | rst) : upg_clk_i ),  // expected to read at negedge // FIXME: rst for async read
.wea (kickOff ? 1'b0 : upg_wen_i ), 
.addra (kickOff ?addr[15:2] : upg_adr_i ), 
.dina (kickOff ? 32'h00000000 : upg_dat_i ), 
.douta (inst) ); 

endmodule