module riscv_regfile(

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

integer i_1;

// register write
always @(negedge clk or posedge rst) begin
    if (rst == 1) begin
        for (i_1 = 0; i_1 < 32; i_1 = i_1 + 1) begin
            register[i_1] <= 32'h0000_0000; 
        end
    end
    else if (reg_write_en == 1) begin
        register[rd] = data_to_reg;
    end
end

// register read
always @(*) begin
    reg_data_rs1 = register[rs1];
    reg_data_rs2 = register[rs2];
end

endmodule


