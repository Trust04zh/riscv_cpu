# SUSTech-CS202_CPU_Project

## Features

- [x] Let's hash! sha256手动挖矿 & 自动挖矿 & 哈希爆破
  + [x] 正向hash (POW1)
  + [x] 对比和MIPS的hash速率 （RISCV用时是MIPS的一半，因为指令更少了）
  + [x] 逆算hash (POW2)  
- [x] 构建risc-v工具链
  + [x] C到asm （本地编译github.com/riscv-collab/riscv-gnu-toolchain）
  + [x] asm到coe （objcopy + 脚本处理）
  + [x] coe到out.txt（UARTCoe_v3.0.exe只识别MIPS指令）
- [ ] 提供RISCV工具链在线服务
- [ ] patch [rars](https://github.com/Trust04zh/rars)
- [x] 提供[MIPS工具链在线服务](http://106.52.237.196/ctf_0o7s/cm.php)
- [x] [美化Mars界面，增加若干功能](https://github.com/Trust04zh/mars-enhanced)

- [x] 支持byte和half io （解决uart和ram的lb冲突问题）
- [x] 支持不跨字的内存非对齐访问
- [x] support multiple io device
  + [x] 7位数码管
  + [x] 小键盘
- [x] support mapped io
- [x] support uart

## Problems & fix

一个[RISCV-toolchain-gcc](https://github.com/riscv-collab/riscv-gnu-toolchain)的bug（待确认）

UART支持bute io -> mask
映射地址过高 -> 栈迁移
TOOL-CHAIN (好多问题)
