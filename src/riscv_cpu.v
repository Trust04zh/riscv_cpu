`include "riscv_defs.v"

module riscv_cpu(

    input raw_clk, rst,

    // io device
    input [23:0]sw,
    output [23:0]led,
    
    input start_pg,
    input rx,
    output tx,
    
    output [7:0] segment_tube,
    output [7:0] segment_en

);

reg[31:0] debug_clk;
always @(posedge raw_clk)debug_clk=debug_clk+1;
wire clk;
assign clk=debug_clk[24];
// from clk_wiz
wire clk_debug_slow;
clk_wiz u_clk_wiz (
    .clk_in1(raw_clk)//.clk_in1(raw_clk)
    , .clk_out1(clk_debug_slow)
);

// from ifetch
wire [31:0] inst;
wire [31:0] pc, pc_plus_4;

// from regfile
wire [31:0] reg_data_rs1;
wire [31:0] reg_data_rs2;

// from controller
wire [`PC_UPDATE_LEN-1 : 0] pc_update;
wire cache_d_write_en;
wire [`CACHE_D_WRITE_LEN-1 : 0] cache_d_write;
wire [`CACHE_D_READ_LEN-1 : 0] cache_d_read;
wire alu_src2;
wire imm_2_extend;
wire [`ALU_OP_LEN-1 : 0] alu_op;
wire reg_write_en;
wire [`REG_WRITE_LEN-1 : 0] reg_write;
wire [`INST_FMT_LEN-1 : 0] inst_fmt;

// from ALU
wire [31:0] alu_result;
wire zero;

// from io bridge
wire [31:0] cache_d_data_m;

// for 7 segnemt tube
reg[31:0] low_clk;
always @(posedge raw_clk)low_clk=low_clk+1;//inst
x_optput_7segment seg(.clk(low_clk[16]),.rst(rst),.in({pc_update, cache_d_write_en, cache_d_write, cache_d_read, alu_src2, alu_op, reg_write_en, reg_write, inst_fmt}),.segment_led(segment_tube),.seg_en(segment_en));

reg [31:0] cache_d_data;
always @(*) begin
    case (cache_d_read)
        `CACHE_D_READ_LW: cache_d_data = cache_d_data_m;
        `CACHE_D_READ_LH: cache_d_data = {{16{cache_d_data_m[15]}}, cache_d_data_m[15:0]};
        `CACHE_D_READ_LHU: cache_d_data = {{16{1'b0}}, cache_d_data_m[15:0]};
        `CACHE_D_READ_LB: cache_d_data = {{24{cache_d_data_m[15]}}, cache_d_data_m[7:0]};
        `CACHE_D_READ_LBU: cache_d_data = {{24{1'b0}}, cache_d_data_m[7:0]};
    endcase
end

//for uart
wire upg_clk_w; 
wire upg_wen_w; 
wire[14:0] upg_adr_w; 
wire[31:0] upg_dat_w; 
wire upg_done_w;
wire spg_bufg; 
BUFG U1(.I(start_pg), .O(spg_bufg)); // de-twitter
reg upg_rst;  // Generate UART Programmer reset signal 
always @ (posedge raw_clk) 
begin 
    if (spg_bufg) 
        upg_rst = 0; 
    if (rst) 
        upg_rst = 1; 
end
wire do_rst = rst | !upg_rst;

uart_bmpg_0 uart(.upg_clk_i(clk),.upg_rst_i(upg_rst),.upg_rx_i(rx),
.upg_clk_o(upg_clk_w),.upg_wen_o(upg_wen_w),.upg_adr_o(upg_adr_w),
.upg_dat_o(upg_dat_w),.upg_done_o(upg_done_w),.upg_tx_o(tx));

ifetch u_ifetch(
    // output
    .inst(inst)
    , .pc(pc)
    , .pc_plus_4(pc_plus_4)
    // input
    , .clk(clk)
    , .rst(rst)
    , .zero(zero)
    , .alu_result(alu_result)
    , .pc_update(pc_update)
    // uart
    ,.upg_rst_i(upg_rst)
    ,.upg_clk_i(upg_clk_w)
    ,.upg_wen_i(upg_wen_w&!upg_adr_w[14])
    ,.upg_adr_i(upg_adr_w)
    ,.upg_dat_i(upg_dat_w)
    ,.upg_done_i(upg_done_w)
);

// parse instruction 
wire [6:0] opcode = inst[6:0];
wire [4:0] rd = inst[11:7];
wire [2:0] funct3 = inst[14:12];
wire [4:0] rs1 = inst[19:15];
wire [4:0] rs2 = inst[24:20];
wire [6:0] funct7 = inst[31:25];
wire [4:0] imm_5 = inst[11:7];
wire [11:0] imm_12_i = inst[31:20]; // imm_12_i
wire [11:0] imm_12_s = {inst[31:25], inst[11:7]}; // imm_12_s
// imm_12_b only used in ifetch
wire [11:0] imm_12 = (inst_fmt == `INST_FMT_I) ? imm_12_i : imm_12_s;
wire [19:0] imm_20_u = {inst[31:12]}; // imm_20_u
// imm_20_j only used in ifetch
// wire [19:0] imm_20 = imm_20_u;

// choosing data to regfile
reg [31:0] data_to_reg; 
always @(*) begin
    case (reg_write)
        `REG_WRITE_ALU: data_to_reg = alu_result;
        `REG_WRITE_MEM: data_to_reg = cache_d_data;
        `REG_WRITE_PC: data_to_reg = pc;
        `REG_WRITE_LUI: data_to_reg = imm_20_u << 12;
        `REG_WRITE_AUIPC: data_to_reg = imm_20_u << 12 + pc;
    endcase
end

riscv_regfile u_riscv_regfile(
    // output
    .reg_data_rs1(reg_data_rs1)
    , .reg_data_rs2(reg_data_rs2)
    // input
    , .clk(clk)
    , .rst(rst)
    , .rs1(rs1)
    , .rs2(rs2)
    , .rd(rd)
    , .reg_write_en(reg_write_en)
    , .data_to_reg(data_to_reg)
);

riscv_controller u_riscv_controller(
    // output
    .pc_update(pc_update)
    , .cache_d_write_en(cache_d_write_en)
    , .cache_d_write(cache_d_write)
    , .cache_d_read(cache_d_read)
    , .alu_src2(alu_src2)
    , .imm_2_extend(imm_2_extend)
    , .alu_op(alu_op)
    , .reg_write_en(reg_write_en)
    , .reg_write(reg_write)
    , .inst_fmt(inst_fmt)
    // input
    , .inst(inst)
);

reg [31:0] imm_extended;
always @(*) begin
    case (imm_2_extend)
        `IMM_2_EXTEND_12: imm_extended = {{20{inst[31]}}, imm_12};
        `IMM_2_EXTEND_5: imm_extended = imm_5; // imm_extended[31:5] is don't care
    endcase
end

wire [31:0] operand_1;
reg [31:0] operand_2;
assign operand_1 = reg_data_rs1;
always @(*) begin
    case (alu_src2)
        `ALU_SRC2_RS2: operand_2 = reg_data_rs2;
        `ALU_SRC2_IMM: operand_2 = imm_extended;
    endcase
end

riscv_alu u_riscv_alu(
    // output
    .alu_result(alu_result)
    , .zero(zero)
    // input
    , .alu_op(alu_op)
    , .operand_1(operand_1)
    , .operand_2(operand_2)
);

riscv_io_bridge u_riscv_io_bridge(
    // output
    .data_out(cache_d_data_m)
    , .led(led)
    // input
    , .clk(clk)
    , .rst(rst)
    , .cache_d_write(cache_d_write)
    , .cache_d_write_en(cache_d_write_en & !rst) // FIXME: rst for async write control
    , .addr(alu_result)
    , .data_to_cache(reg_data_rs2)
    , .sw(sw)
    // uart
    ,.upg_rst_i(upg_rst)
    ,.upg_clk_i(upg_clk_w)
    ,.upg_wen_i(upg_wen_w&upg_adr_w[14])
    ,.upg_adr_i(upg_adr_w)
    ,.upg_dat_i(upg_dat_w)
    ,.upg_done_i(upg_done_w)

);


endmodule