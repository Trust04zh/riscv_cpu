`include "riscv_defs.v"

module riscv_controller(

    output [`PC_UPDATE_LEN-1 : 0] pc_update
    , output cache_d_write_en
    , output [`CACHE_D_WRITE_LEN-1 : 0] cache_d_write
    , output [`CACHE_D_READ_LEN-1 : 0] cache_d_read
    , output alu_src2
    , output imm_2_extend
    , output [`ALU_OP_LEN-1 : 0] alu_op
    , output reg_write_en
    , output [`REG_WRITE_LEN-1 : 0] reg_write
    , output [`INST_FMT_LEN-1 : 0] inst_fmt

    , input [31:0] inst

);

assign {pc_update, cache_d_write_en, cache_d_write, cache_d_read, alu_src2, alu_op, reg_write_en, reg_write, inst_fmt} =
        (inst & `INST_MASK_ADD == `INST_PATT_ADD) ? `INST_ATTR_ADD :
        (inst & `INST_MASK_SUB == `INST_PATT_SUB) ? `INST_ATTR_SUB :
        (inst & `INST_MASK_XOR == `INST_PATT_XOR) ? `INST_ATTR_XOR :
        (inst & `INST_MASK_OR == `INST_PATT_OR) ? `INST_ATTR_OR :
        (inst & `INST_MASK_AND == `INST_PATT_AND) ? `INST_ATTR_AND :
        (inst & `INST_MASK_SLL == `INST_PATT_SLL) ? `INST_ATTR_SLL :
        (inst & `INST_MASK_SRL == `INST_PATT_SRL) ? `INST_ATTR_SRL :
        (inst & `INST_MASK_SRA == `INST_PATT_SRA) ? `INST_ATTR_SRA :
        (inst & `INST_MASK_SLT == `INST_PATT_SLT) ? `INST_ATTR_SLT :
        (inst & `INST_MASK_SLTU == `INST_PATT_SLTU) ? `INST_ATTR_SLTU :
        (inst & `INST_MASK_ADDI == `INST_PATT_ADDI) ? `INST_ATTR_ADDI :
        (inst & `INST_MASK_XORI == `INST_PATT_XORI) ? `INST_ATTR_XORI :
        (inst & `INST_MASK_ORI == `INST_PATT_ORI) ? `INST_ATTR_ORI :
        (inst & `INST_MASK_ANDI == `INST_PATT_ANDI) ? `INST_ATTR_ANDI :
        (inst & `INST_MASK_SLLI == `INST_PATT_SLLI) ? `INST_ATTR_SLLI :
        (inst & `INST_MASK_SRLI == `INST_PATT_SRLI) ? `INST_ATTR_SRLI :
        (inst & `INST_MASK_SRAI == `INST_PATT_SRAI) ? `INST_ATTR_SRAI :
        (inst & `INST_MASK_SLTI == `INST_PATT_SLTI) ? `INST_ATTR_SLTI :
        (inst & `INST_MASK_SLTIU == `INST_PATT_SLTIU) ? `INST_ATTR_SLTIU :
        (inst & `INST_MASK_LB == `INST_PATT_LB) ? `INST_ATTR_LB :
        (inst & `INST_MASK_LH == `INST_PATT_LH) ? `INST_ATTR_LH :
        (inst & `INST_MASK_LW == `INST_PATT_LW) ? `INST_ATTR_LW :
        (inst & `INST_MASK_LBU == `INST_PATT_LBU) ? `INST_ATTR_LBU :
        (inst & `INST_MASK_LHU == `INST_PATT_LHU) ? `INST_ATTR_LHU :
        (inst & `INST_MASK_SB == `INST_PATT_SB) ? `INST_ATTR_SB :
        (inst & `INST_MASK_SH == `INST_PATT_SH) ? `INST_ATTR_SH :
        (inst & `INST_MASK_SW == `INST_PATT_SW) ? `INST_ATTR_SW :
        (inst & `INST_MASK_BEQ == `INST_PATT_BEQ) ? `INST_ATTR_BEQ :
        (inst & `INST_MASK_BNE == `INST_PATT_BNE) ? `INST_ATTR_BNE :
        (inst & `INST_MASK_BLT == `INST_PATT_BLT) ? `INST_ATTR_BLT :
        (inst & `INST_MASK_BGE == `INST_PATT_BGE) ? `INST_ATTR_BGE :
        (inst & `INST_MASK_BLTU == `INST_PATT_BLTU) ? `INST_ATTR_BLTU :
        (inst & `INST_MASK_BGEU == `INST_PATT_BGEU) ? `INST_ATTR_BGEU :
        (inst & `INST_MASK_JAL == `INST_PATT_JAL) ? `INST_ATTR_JAL :
        (inst & `INST_MASK_JALR == `INST_PATT_JALR) ? `INST_ATTR_JALR :
        (inst & `INST_MASK_LUI == `INST_PATT_LUI) ? `INST_ATTR_LUI :
        (inst & `INST_MASK_AUIPC == `INST_PATT_AUIPC) ? `INST_ATTR_AUIPC :
        `INST_ATTR_NOP;
    

endmodule