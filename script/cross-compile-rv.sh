cd .
PREFIX=test
TOOLCHAIN=/opt/riscv/bin/riscv32-unknown-linux-gnu
# python3 corss-compile-to-asm.py ${PREFIX}.c > ${PREFIX}.asm
${TOOLCHAIN}-gcc -c ${PREFIX}.c -o ${PREFIX}.o
${TOOLCHAIN}-ld --Ttext 0x0 -Tdata 0x10000 -nostdlib ${PREFIX}.o -o ${PREFIX}.out
${TOOLCHAIN}-strip -R .reginfo ${PREFIX}.out
${TOOLCHAIN}-strip -R .riscv.abiflags ${PREFIX}.out
${TOOLCHAIN}-strip -R .gnu.attributes ${PREFIX}.out
${TOOLCHAIN}-objcopy -O binary ${PREFIX}.out ${PREFIX}.bin
python3 convert-pg-coe.py ${PREFIX}.bin