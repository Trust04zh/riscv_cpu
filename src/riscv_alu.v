`include "riscv_defs.v"

module riscv_alu (

    output reg [31:0] alu_result
    , output zero

    // from controller
    , input [`ALU_OP_LEN-1 : 0] alu_op

    // from top cpu
    , input [31:0] operand_1
    , input [31:0] operand_2

);

always @(*) begin
    case (alu_op) 
        `ALU_OP_ADD: alu_result = operand_1 + operand_2;
        `ALU_OP_SUB: alu_result = operand_1 - operand_2;
        `ALU_OP_AND: alu_result = operand_1 & operand_2;
        `ALU_OP_OR: alu_result = operand_1 | operand_2;
        `ALU_OP_XOR: alu_result = operand_1 ^ operand_2;
        `ALU_OP_SLL: alu_result = operand_1 << operand_2[4:0];
        `ALU_OP_SRL: alu_result = operand_1 >> operand_2[4:0];
        `ALU_OP_SRA: alu_result = $signed(operand_1) >>> operand_2[4:0];
        `ALU_OP_SLT: alu_result = $signed(operand_1) < $signed(operand_2);
        `ALU_OP_SLTU: alu_result = $unsigned(operand_1) < $unsigned(operand_2);
    endcase
end

assign zero = (alu_result == 0);

endmodule