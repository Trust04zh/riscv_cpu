import os
import csv

res_folder = 'inst_table'

VALID_MARK = '1'

attr_list = [
    'PC_UPDATE',
    'CACHE_D_WRITE_EN',
    'CACHE_D_WRITE',
    'CACHE_D_READ',
    'ALU_SRC2',
    'IMM_2_EXTEND',
    'ALU_OP',
    'REG_WRITE_EN',
    'REG_WRITE',
    'INST_FMT',
]

inst_list = []
with open(os.path.join(res_folder, 'inst.txt'), 'r') as f:
    for line in f.readlines():
        inst_list.append(line.strip())
# print(inst_list) 

attr_map = {}
for inst in inst_list:
    attr_map[inst] = {attr : None for attr in attr_list}

for attr_name in attr_list:
    with open(os.path.join(res_folder, f'{attr_name}.csv'), 'r') as f:
        csv_reader = csv.reader(f)
        attr_row = csv_reader.__next__()
        for inst_row in csv_reader:
            attr_map[inst_row[0]].update({attr_row[0]: attr_row[inst_row.index(VALID_MARK)]})

# for attr_per_inst in attr_map.items():
#     print(attr_per_inst)

for inst, attr in attr_map.items():
    print(f"`define INST_ATTR_{inst.upper()} {{{', '.join(map(lambda s: '`' + s, attr.values()))}}}")
