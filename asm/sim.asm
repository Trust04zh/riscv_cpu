
# x8: const 0xdeadbeef
# x9: const 0x19260817
# x18: const map to 0xffffffc0(sw)
# x19: const map to 0xffffffc4(led)
# x20: const map to 0x0(free mem region)
# x5: temp, operation result

# led[31:24] are reserved to be 0

# prerequisite: lui, addi

# li x8, 0xdeadbeef
lui x8, 0xdeadc
addi x8, x8, -273

# li x9, 0x19260817
lui x9, 0x19261
addi x9, x9, -2025

# prerequisite: addi
addi x18, x18, -1024

addi x19, x19, -1020

# li x20, 0x80000000
# lui x20, 0x80000
lui x20, 0xfffff

# prerequisite: sw (io)
sw x8, 0(x19) # save 0x00adbeef to led(io)

# check: lw (io)
sw x8, 0(x19)
lw x5, 0(x19) # load 0x00adbeef
sw x5, 0(x19)

# check: lh (io)
sw x8, 0(x19)
lh x5, 0(x19) # load 0xffffbeef
sw x5, 0(x19)

# check: lb (io)
sw x8, 0(x19)
lb x5, 0(x19) # load 0xffffffef
sw x5, 0(x19)

# check: lhu (io)
sw x8, 0(x19)
lhu x5, 0(x19) # load 0x0000beef
sw x5, 0(x19)

# check: lbu (io)
sw x8, 0(x19)
lbu x5, 0(x19) # load 0x000000ef
sw x5, 0(x19)

# check: sh, sb (io)
addi x5, x0, 0
sw x5, 0(x19) # clear to 0x0
lw x5, 0(x19) # load 0x0
sw x5, 0(x19)

sh x9, 0(x19)
lw x5, 0(x19) # load 0x00000817
sw x5, 0(x19)

addi x5, x0, 0
sw x5, 0(x19) # clear to 0x0
lw x5, 0(x19) # load 0x0
sw x5, 0(x19)

sb x9, 0(x19) 
lw x5, 0(x19) # load 0x00000017
sw x5, 0(x19)

# prerequisite: sw (mem)
sw x8, 0(x20) # save 0xdeadbeef to mem

# check: lw (mem)
lw x5, 0(x20) # load 0xdeadbeef
sw x5, 0(x19)

# check: lh (mem)
lh x5, 0(x20) # load 0xffffbeef
sw x5, 0(x19)

# check: lb (mem)
lb x5, 0(x20) # load 0xffffffef
sw x5, 0(x19)

# check: lhu (mem)
lhu x5, 0(x20) # load 0x0000beef
sw x5, 0(x19)

# check: lbu (mem)
lbu x5, 0(x20) # load 0x000000ef
sw x5, 0(x19)

# check: sh, sb (mem)
addi x5, x0, 0
sw x5, 4(x20) # clear to 0x0
lw x5, 4(x20) # load 0x0
sw x5, 0(x19)

sh x9, 4(x20)
lw x5, 4(x20) # load 0x00000817
sw x5, 0(x19)

addi x5, x0, 0
sw x5, 4(x20) # clear to 0x0
lw x5, 4(x20) # load 0x0
sw x5, 0(x19)

sb x9, 4(x20) 
lw x5, 4(x20) # load 0x00000017
sw x5, 0(x19)

# check: add
add x5, x8, x9 # 0xf7d3c706 
sw x5, 0(x19)

# check: sub
sub x5, x8, x9 # 0xc587b6d8
sw x5, 0(x19)

# check: xor
xor x5, x8, x9 # 0xe78bb6f8
sw x5, 0(x19)

# check: or
or x5, x8, x9 # 0xdfafbeff
sw x5, 0(x19)

# check: and
and x5, x8, x9 # 0x18240807
sw x5, 0(x19)

# check: sll
sll x5, x8, x9 # 0x77800000
sw x5, 0(x19)

# check: srl
srl x5, x8, x9 # 0x000001bd
sw x5, 0(x19)

# check: sra
sra x5, x8, x9 # 0xffffffbd
sw x5, 0(x19)

# check: slt
slt x5, x8, x9 # 1
sw x5, 0(x19)

# check: sltu
sltu x5, x8, x9 # 0
sw x5, 0(x19)

# check: addi
addi x5, x8, 1926 # 0xdeadc675
sw x5, 0(x19)

# check: xori
xori x5, x8, 2047 # 0xdeadb910
sw x5, 0(x19)

# check: ori
ori x5, x8, 1926 # 0xdeadbfef
sw x5, 0(x19)

# check: andi
andi x5, x8, 1926 # 0x00000686
sw x5, 0(x19)

# check: slli
slli x5, x8, 16 # 0xbeef0000
sw x5, 0(x19)

# check: srli
srli x5, x8, 16 # 0x0000dead
sw x5, 0(x19)

# check: srai
srai x5, x8, 16 # 0xffffdead
sw x5, 0(x19)

# check: slti
slti x5, x8, 0 # 1
sw x5, 0(x19)

# check: sltiu
sltiu x5, x8, 0 # 0
sw x5, 0(x19)

# check: auipc
auipc x5, 0 # depends on pc
sw x5, 0(x19)

# check: beq
addi x5, x0, -1
B_BEQ:
addi x5, x5, 1
beq x5, x0, B_BEQ

# check: bne
addi x5, x0, -2
B_BNE:
addi x5, x5, 1
bne x5, x0, B_BNE

# check: blt
addi x5, x0, -2
B_BLT:
addi x5, x5, 1
blt x5, x0, B_BLT

# check: bge
addi x5, x0, 1
B_BGE:
addi x5, x5, -1
bge x5, x0, B_BGE

# check: bltu
addi x5, x0, -2
B_BLTU:
addi x5, x5, 1
bltu x0, x5, B_BLTU

# check: bgeu
addi x5, x0, 1
B_BGEU:
addi x5, x5, -1
bgeu x0, x5, B_BGEU

# check: jal
jal x1, J_JAL
nop
nop
J_JAL:
addi x1, x1, 20 
ret # jump to jalr
nop

# check: jalr
jalr x1, x1, 12
nop
nop
addi x1, x1, 16
ret # jump to the following nop
nop
nop
nop
