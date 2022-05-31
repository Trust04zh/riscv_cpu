#### notes
~~cache_i和cache_d实质上不是cache，而是rom和ram~~
支持uart，cache_i和cache_d现在都不是cache而是ram了  

移位运算移动的位宽取低8位(0-31)  

#### todo

- [] correctness verification
  + [Y] 测试场景1
  + [] 测试场景1交叉验证
  + [] 测试场景2
  + [] 测试场景2交叉验证
  + [] 测试场景3
  + [] 测试场景3交叉验证
- [Y] 构建risc-v工具链
  + [Y] C到asm （本地编译github.com/riscv-collab/riscv-gnu-toolchain）
  + [Y] asm到coe （objcopy + 脚本处理）
  + [Y] coe到out.txt（UARTCoe_v3.0.exe只识别MIPS指令）
- [] 提供RISCV工具链在线服务
- [Y] 提供MIPS工具链在线服务
- [Y] 支持byte和half io （解决uart和ram的lb冲突问题）
- [Y] support multiple io device
  + [Y] 7位数码管
  + [Y] 小键盘
- [Y] support mapped io
- [Y] support uart
