#!/bin/python3
import sys

padding = 0x4000
# arch is 32, byte width is 8
size = 32 // 8
text = open(sys.argv[1], "rb")
raw_data = []


def write_coe(file, binary):
    f = open(file, "w")
    f.write("memory_initialization_radix=16;\nmemory_initialization_vector=\n")
    for cur in binary[:len(binary)-1]:
        f.write(cur.hex() + ",\n")
    f.write(binary[-1].hex() + ";")
    f.close()


while True:
    data = text.read(size)
    if not data:
        break
    raw_data.append(data[::-1])

text.close()

# double for 2 coe(s)
for i in range(len(raw_data), padding << 1):
    raw_data.append(b"\x00" * size)

write_coe("prgmip32.coe", raw_data[:padding])
write_coe("dmem32.coe", raw_data[padding:])
