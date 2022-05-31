#### notes
两个rst要一起按是因为没生成新的rst信号，设计的原因是方便确认uart烧写情况（因为有自定义txt的情况）   
~~cache_i和cache_d实质上不是cache，而是rom和ram~~
支持uart，cache_i和cache_d现在都不是cache而是ram了  

移位运算移动的位宽取低8位(0-31)  

#### todo

- [ ] correctness verification
  + [x] 测试场景1
  + [ ] 测试场景1交叉验证
  + [ ] 测试场景2
  + [ ] 测试场景2交叉验证
  + [ ] 测试场景3
  + [ ] 测试场景3交叉验证
- [x] 构建risc-v工具链
  + [x] C到asm （本地编译github.com/riscv-collab/riscv-gnu-toolchain）
  + [x] asm到coe （objcopy + 脚本处理）
  + [x] coe到out.txt（UARTCoe_v3.0.exe只识别MIPS指令）
- [ ] 提供RISCV工具链在线服务
- [x] 提供MIPS工具链在线服务
- [x] 支持byte和half io （解决uart和ram的lb冲突问题）
- [x] support multiple io device
  + [x] 7位数码管
  + [x] 小键盘
- [x] support mapped io
- [x] support uart
