module riscv_regfile (

    output reg [31:0] reg_data_rs1,
    output reg [31:0] reg_data_rs2,

    input clk, rst, // clock and reset

    // from ifetch
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,

    // from controller
    input reg_write_en,

    // from top cpu
    input [31:0] data_to_reg
    
);

reg [31:0] register[0:31];

// register write
always @(negedge clk or posedge rst) begin
    if (rst == 1) begin
        register[0] <= 32'h0000_0000;
        register[1] <= 32'h0000_0000;
        register[2] <= 32'h7fff_ffff;
        register[3] <= 32'h0000_0000;
        register[4] <= 32'h0000_0000;
        register[5] <= 32'h0000_0000;
        register[6] <= 32'h0000_0000;
        register[7] <= 32'h0000_0000;
        register[8] <= 32'h0000_0000;
        register[9] <= 32'h0000_0000;
        register[10] <= 32'h0000_0000;
        register[11] <= 32'h0000_0000;
        register[12] <= 32'h0000_0000;
        register[13] <= 32'h0000_0000;
        register[14] <= 32'h0000_0000;
        register[15] <= 32'h0000_0000;
        register[16] <= 32'h0000_0000;
        register[17] <= 32'h0000_0000;
        register[18] <= 32'h0000_0000;
        register[19] <= 32'h0000_0000;
        register[20] <= 32'h0000_0000;
        register[21] <= 32'h0000_0000;
        register[22] <= 32'h0000_0000;
        register[23] <= 32'h0000_0000;
        register[24] <= 32'h0000_0000;
        register[25] <= 32'h0000_0000;
        register[26] <= 32'h0000_0000;
        register[27] <= 32'h0000_0000;
        register[28] <= 32'h0000_0000;
        register[29] <= 32'h0000_0000;
        register[30] <= 32'h0000_0000;
        register[31] <= 32'h0000_0000;
        register[32] <= 32'h0000_0000;
    end
    else if (reg_write_en == 1 && !(rd == 0)) begin
        register[rd] = data_to_reg;
    end
end

// register read
always @(*) begin
    reg_data_rs1 = register[rs1];
    reg_data_rs2 = register[rs2];
end

endmodule


