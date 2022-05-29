import os

res_folder = 'inst_table'

inst_list = []
with open(os.path.join(res_folder, 'inst.txt'), 'r') as f:
    for line in f.readlines():
        inst_list.append(line.strip())

for inst in inst_list:
    inst_upper = inst.upper()
    print(f'((inst & `INST_MASK_{inst_upper}) == `INST_PATT_{inst_upper}) ? `INST_ATTR_{inst_upper} :')