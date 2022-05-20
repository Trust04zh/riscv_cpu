`include "riscv_defs.v"

module ifetch(
    
    output [31:0] inst
    , output reg [31:0] pc
    , output reg [31:0] pc_plus_4

    , input clk, rst

    // from ALU
    , input zero

    // from alu
    , input [31:0] alu_result
    
    // from controller
    , input [2:0] pc_update

    
);

reg [31:0] pc_m;

// update module inner pc
always @(posedge clk or posedge rst) begin
    if (rst == 1) 
        pc_m <= 32'h0000_0000;
    case (pc_update)
        `PC_UPDATE_PLUS_4: pc_m <= pc_plus_4;
        `PC_UPDATE_BRANCH_ZERO: pc_m <= (zero == 1) ? (pc + {{20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0}) : pc_plus_4;
        `PC_UPDATE_BRANCH_N_ZERO: pc_m <= (zero == 0) ? (pc + {{20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0}) : pc_plus_4;
        `PC_UPDATE_JUMP: pc_m <= pc + {{12{inst[31]}}, inst[19:12], inst[20], inst[30:21]}; // JAL
        `PC_UPDATE_JR: pc_m <= alu_result; // JALR
    endcase        
end

// update output pc and pc + 4
always @(negedge clk or posedge rst) begin
    if (rst == 1) begin
        pc <= 32'h0000_0000;
        pc_plus_4 <= 32'h0000_0004;
    end
    else begin
        pc <= pc_m;
        pc_plus_4 <= pc_m + 4;
    end
end

riscv_cache_i u_riscv_cache_i(
    // output
    .inst(inst)
    // input
    ,.clk(clk)
    ,.rst(rst)
    ,.addr(pc)
);

endmodule