cd .
PREFIX=test
TOOLCHAIN=/opt/riscv/bin/riscv32-unknown-linux-gnu
${TOOLCHAIN}-gcc -march=rv32i -c ${PREFIX}.c -o ${PREFIX}.o
${TOOLCHAIN}-ld --Ttext 0x0 -Tdata 0x10000 ${PREFIX}.o -o ${PREFIX}.out
${TOOLCHAIN}-objcopy -O binary ${PREFIX}.out ${PREFIX}.bin
python3 convert-pg-coe.py ${PREFIX}.bin
