#!/usr/bin/env python    # -*- coding: utf-8 -*
import subprocess
import sys
import re

if len(sys.argv) < 2:
    print("Usage: python cm.py input_file")
    exit()

clang = subprocess.Popen(["clang",
                          "-momit-leaf-frame-pointer",  # 优化$fp
                          "-modd-spreg",  # 允许汇编使用奇数浮点协处理器
                          "-mdouble-float",  # -msingle-float来兼容mars的一些需求，默认是double
                          # "-fomit-frame-pointer",
                          "-target",
                          "mipsel", sys.argv[1], "-S", "-o", "-"], stdout=subprocess.PIPE)
res = clang.stdout.read().decode('utf-8')

# 这里会出现上边lui一个寄存器，但是下边lw或者add了另一个寄存器 %lo(label)(%hi)，最终la到的是下边的寄存器
res = re.sub(r"\n\s+lui\s+\$\d\d?, %hi.*\n(\s+)\S+(\s+)(\$\d\d?).*%lo\((\S+?)\).*\n",
             r"\n\g<1>la\g<2>\g<3>, \g<4>\n", res)  # use 'la $reg, label' rather %hi/%lo(label)
res = re.sub("asciz", "asciiz", res)  # use '.asciiz' rather 'asciz'
res = re.sub(r"\s\.section\s*(.ro)?data.*\n", ".data\n", res)  # use '.data' replace '.section .rodata...'
res = re.sub(r"(\s*)c\.[u|o](\S+)\.(\S\s+)", r"\g<1>c.\g<2>.\g<3>", res)  # use '.data' replace '.section .rodata...'
res = re.sub(r"\.4byte", ".word", res)
res = re.sub('#.*', "", res)  # remove all notes

allow = '.align.ascii.asciiz.byte.data.double.eqv.extern.float.globl.half.kdata.ktext.space.text.word'.split(".")

r = res.split('\n')[1:]
res = ".text\n_start:\n\tla $ra,_start+12\n\tj main\n\tli $v0,10\n\tsyscall\n" if "main:" in res else ""
for line in r:
    match = re.match(r"\s+\.(\S+).*", line)
    if match is None or match.group().strip().split("\t")[0][1:] in allow:
        res += line + "\n"

res = re.sub(r"\n\s*\n", "\n", res)
res = res.replace("main", "__main")  # OJ的mars设置了sm参数, 会强制从main开始执行, 重命名来避免错过__start
print(res)
