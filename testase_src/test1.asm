.text   
0:	fe010113          	addi	sp,sp,-32
   4:	00112e23          	sw	ra,28(sp)
   8:	00812c23          	sw	s0,24(sp)
   c:	02010413          	addi	s0,sp,32
  10:	c0000793          	li	a5,-1024
  14:	0007a783          	lw	a5,0(a5)
  18:	00078613          	mv	a2,a5
  1c:	01200593          	li	a1,18
  20:	01000513          	li	a0,16
  24:	098000ef          	jal	ra,0xbc
  28:	fea42623          	sw	a0,-20(s0)
  2c:	fec42783          	lw	a5,-20(s0)
  30:	00079663          	bnez	a5,0x3c
  34:	148000ef          	jal	ra,0x17c
  38:	fd9ff06f          	j	0x10
  3c:	fec42703          	lw	a4,-20(s0)
  40:	00100793          	li	a5,1
  44:	00f71663          	bne	a4,a5,0x50
  48:	228000ef          	jal	ra,0x270
  4c:	fc5ff06f          	j	0x10
  50:	fec42703          	lw	a4,-20(s0)
  54:	00200793          	li	a5,2
  58:	00f71663          	bne	a4,a5,0x64
  5c:	2e4000ef          	jal	ra,0x340
  60:	fb1ff06f          	j	0x10
  64:	fec42703          	lw	a4,-20(s0)
  68:	00300793          	li	a5,3
  6c:	00f71663          	bne	a4,a5,0x78
  70:	308000ef          	jal	ra,0x378
  74:	f9dff06f          	j	0x10
  78:	fec42703          	lw	a4,-20(s0)
  7c:	00400793          	li	a5,4
  80:	00f71663          	bne	a4,a5,0x8c
  84:	32c000ef          	jal	ra,0x3b0
  88:	f89ff06f          	j	0x10
  8c:	fec42703          	lw	a4,-20(s0)
  90:	00500793          	li	a5,5
  94:	00f71663          	bne	a4,a5,0xa0
  98:	350000ef          	jal	ra,0x3e8
  9c:	f75ff06f          	j	0x10
  a0:	fec42703          	lw	a4,-20(s0)
  a4:	00600793          	li	a5,6
  a8:	00f71663          	bne	a4,a5,0xb4
  ac:	374000ef          	jal	ra,0x420
  b0:	f61ff06f          	j	0x10
  b4:	3a8000ef          	jal	ra,0x45c
  b8:	f59ff06f          	j	0x10
  bc:	fd010113          	addi	sp,sp,-48
  c0:	02812623          	sw	s0,44(sp)
  c4:	03010413          	addi	s0,sp,48
  c8:	fca42e23          	sw	a0,-36(s0)
  cc:	fcb42c23          	sw	a1,-40(s0)
  d0:	fcc42a23          	sw	a2,-44(s0)
  d4:	00100793          	li	a5,1
  d8:	fef42623          	sw	a5,-20(s0)
  dc:	fe042423          	sw	zero,-24(s0)
  e0:	0280006f          	j	0x108
  e4:	fec42783          	lw	a5,-20(s0)
  e8:	00179793          	slli	a5,a5,0x1
  ec:	fef42623          	sw	a5,-20(s0)
  f0:	fec42783          	lw	a5,-20(s0)
  f4:	0017e793          	ori	a5,a5,1
  f8:	fef42623          	sw	a5,-20(s0)
  fc:	fe842783          	lw	a5,-24(s0)
 100:	00178793          	addi	a5,a5,1
 104:	fef42423          	sw	a5,-24(s0)
 108:	fd842703          	lw	a4,-40(s0)
 10c:	fdc42783          	lw	a5,-36(s0)
 110:	40f707b3          	sub	a5,a4,a5
 114:	fe842703          	lw	a4,-24(s0)
 118:	fcf746e3          	blt	a4,a5,0xe4
 11c:	fe042223          	sw	zero,-28(s0)
 120:	01c0006f          	j	0x13c
 124:	fec42783          	lw	a5,-20(s0)
 128:	00179793          	slli	a5,a5,0x1
 12c:	fef42623          	sw	a5,-20(s0)
 130:	fe442783          	lw	a5,-28(s0)
 134:	00178793          	addi	a5,a5,1
 138:	fef42223          	sw	a5,-28(s0)
 13c:	fe442703          	lw	a4,-28(s0)
 140:	fdc42783          	lw	a5,-36(s0)
 144:	fef740e3          	blt	a4,a5,0x124
 148:	fd442703          	lw	a4,-44(s0)
 14c:	fec42783          	lw	a5,-20(s0)
 150:	00f777b3          	and	a5,a4,a5
 154:	fef42023          	sw	a5,-32(s0)
 158:	fdc42783          	lw	a5,-36(s0)
 15c:	fe042703          	lw	a4,-32(s0)
 160:	40f757b3          	sra	a5,a4,a5
 164:	fef42023          	sw	a5,-32(s0)
 168:	fe042783          	lw	a5,-32(s0)
 16c:	00078513          	mv	a0,a5
 170:	02c12403          	lw	s0,44(sp)
 174:	03010113          	addi	sp,sp,48
 178:	00008067          	ret
 17c:	fd010113          	addi	sp,sp,-48
 180:	02812623          	sw	s0,44(sp)
 184:	03010413          	addi	s0,sp,48
 188:	c0000793          	li	a5,-1024
 18c:	0007a783          	lw	a5,0(a5)
 190:	fef42623          	sw	a5,-20(s0)
 194:	fe042423          	sw	zero,-24(s0)
 198:	01c0006f          	j	0x1b4
 19c:	fe842783          	lw	a5,-24(s0)
 1a0:	00178793          	addi	a5,a5,1
 1a4:	fef42423          	sw	a5,-24(s0)
 1a8:	fec42783          	lw	a5,-20(s0)
 1ac:	4017d793          	srai	a5,a5,0x1
 1b0:	fef42623          	sw	a5,-20(s0)
 1b4:	fec42783          	lw	a5,-20(s0)
 1b8:	fe0792e3          	bnez	a5,0x19c
 1bc:	c0000793          	li	a5,-1024
 1c0:	0007a783          	lw	a5,0(a5)
 1c4:	fef42623          	sw	a5,-20(s0)
 1c8:	0640006f          	j	0x22c
 1cc:	fe842783          	lw	a5,-24(s0)
 1d0:	fec42703          	lw	a4,-20(s0)
 1d4:	40f757b3          	sra	a5,a4,a5
 1d8:	fef42023          	sw	a5,-32(s0)
 1dc:	fe042783          	lw	a5,-32(s0)
 1e0:	0017f793          	andi	a5,a5,1
 1e4:	fef42023          	sw	a5,-32(s0)
 1e8:	fec42783          	lw	a5,-20(s0)
 1ec:	0017f793          	andi	a5,a5,1
 1f0:	fcf42e23          	sw	a5,-36(s0)
 1f4:	fe042703          	lw	a4,-32(s0)
 1f8:	fdc42783          	lw	a5,-36(s0)
 1fc:	00f70c63          	beq	a4,a5,0x214
 200:	c0000713          	li	a4,-1024
 204:	c0400793          	li	a5,-1020
 208:	00072703          	lw	a4,0(a4)
 20c:	00e7a023          	sw	a4,0(a5)
 210:	0540006f          	j	0x264
 214:	fec42783          	lw	a5,-20(s0)
 218:	4017d793          	srai	a5,a5,0x1
 21c:	fef42623          	sw	a5,-20(s0)
 220:	fe842783          	lw	a5,-24(s0)
 224:	fff78793          	addi	a5,a5,-1
 228:	fef42423          	sw	a5,-24(s0)
 22c:	fe842783          	lw	a5,-24(s0)
 230:	fff78713          	addi	a4,a5,-1
 234:	fee42423          	sw	a4,-24(s0)
 238:	f8f04ae3          	bgtz	a5,0x1cc
 23c:	c0000793          	li	a5,-1024
 240:	0007a783          	lw	a5,0(a5)
 244:	fef42223          	sw	a5,-28(s0)
 248:	fe442703          	lw	a4,-28(s0)
 24c:	000107b7          	lui	a5,0x10
 250:	00f767b3          	or	a5,a4,a5
 254:	fef42223          	sw	a5,-28(s0)
 258:	c0400793          	li	a5,-1020
 25c:	fe442703          	lw	a4,-28(s0)
 260:	00e7a023          	sw	a4,0(a5) # 0x10000
 264:	02c12403          	lw	s0,44(sp)
 268:	03010113          	addi	sp,sp,48
 26c:	00008067          	ret
 270:	ff010113          	addi	sp,sp,-16
 274:	00112623          	sw	ra,12(sp)
 278:	00812423          	sw	s0,8(sp)
 27c:	01010413          	addi	s0,sp,16
 280:	c0000793          	li	a5,-1024
 284:	0007a783          	lw	a5,0(a5)
 288:	00078613          	mv	a2,a5
 28c:	01300593          	li	a1,19
 290:	01300513          	li	a0,19
 294:	e29ff0ef          	jal	ra,0xbc
 298:	00050793          	mv	a5,a0
 29c:	02078e63          	beqz	a5,0x2d8
 2a0:	c0000793          	li	a5,-1024
 2a4:	0007a783          	lw	a5,0(a5)
 2a8:	00078613          	mv	a2,a5
 2ac:	00f00593          	li	a1,15
 2b0:	00000513          	li	a0,0
 2b4:	e09ff0ef          	jal	ra,0xbc
 2b8:	00050713          	mv	a4,a0
 2bc:	000107b7          	lui	a5,0x10
 2c0:	00e7a023          	sw	a4,0(a5) # 0x10000
 2c4:	c0400793          	li	a5,-1020
 2c8:	00010737          	lui	a4,0x10
 2cc:	00072703          	lw	a4,0(a4) # 0x10000
 2d0:	00e7a023          	sw	a4,0(a5)
 2d4:	0580006f          	j	0x32c
 2d8:	c0000793          	li	a5,-1024
 2dc:	0007a783          	lw	a5,0(a5)
 2e0:	00078613          	mv	a2,a5
 2e4:	01400593          	li	a1,20
 2e8:	01400513          	li	a0,20
 2ec:	dd1ff0ef          	jal	ra,0xbc
 2f0:	00050793          	mv	a5,a0
 2f4:	02078c63          	beqz	a5,0x32c
 2f8:	c0000793          	li	a5,-1024
 2fc:	0007a783          	lw	a5,0(a5)
 300:	00078613          	mv	a2,a5
 304:	00f00593          	li	a1,15
 308:	00000513          	li	a0,0
 30c:	db1ff0ef          	jal	ra,0xbc
 310:	00050713          	mv	a4,a0
 314:	000107b7          	lui	a5,0x10
 318:	00e7a223          	sw	a4,4(a5) # 0x10004
 31c:	c0400793          	li	a5,-1020
 320:	00010737          	lui	a4,0x10
 324:	00472703          	lw	a4,4(a4) # 0x10004
 328:	00e7a023          	sw	a4,0(a5)
 32c:	00000013          	nop
 330:	00c12083          	lw	ra,12(sp)
 334:	00812403          	lw	s0,8(sp)
 338:	01010113          	addi	sp,sp,16
 33c:	00008067          	ret
 340:	ff010113          	addi	sp,sp,-16
 344:	00812623          	sw	s0,12(sp)
 348:	01010413          	addi	s0,sp,16
 34c:	000107b7          	lui	a5,0x10
 350:	0007a683          	lw	a3,0(a5) # 0x10000
 354:	000107b7          	lui	a5,0x10
 358:	0047a703          	lw	a4,4(a5) # 0x10004
 35c:	c0400793          	li	a5,-1020
 360:	00e6f733          	and	a4,a3,a4
 364:	00e7a023          	sw	a4,0(a5)
 368:	00000013          	nop
 36c:	00c12403          	lw	s0,12(sp)
 370:	01010113          	addi	sp,sp,16
 374:	00008067          	ret
 378:	ff010113          	addi	sp,sp,-16
 37c:	00812623          	sw	s0,12(sp)
 380:	01010413          	addi	s0,sp,16
 384:	000107b7          	lui	a5,0x10
 388:	0007a683          	lw	a3,0(a5) # 0x10000
 38c:	000107b7          	lui	a5,0x10
 390:	0047a703          	lw	a4,4(a5) # 0x10004
 394:	c0400793          	li	a5,-1020
 398:	00e6e733          	or	a4,a3,a4
 39c:	00e7a023          	sw	a4,0(a5)
 3a0:	00000013          	nop
 3a4:	00c12403          	lw	s0,12(sp)
 3a8:	01010113          	addi	sp,sp,16
 3ac:	00008067          	ret
 3b0:	ff010113          	addi	sp,sp,-16
 3b4:	00812623          	sw	s0,12(sp)
 3b8:	01010413          	addi	s0,sp,16
 3bc:	000107b7          	lui	a5,0x10
 3c0:	0007a683          	lw	a3,0(a5) # 0x10000
 3c4:	000107b7          	lui	a5,0x10
 3c8:	0047a703          	lw	a4,4(a5) # 0x10004
 3cc:	c0400793          	li	a5,-1020
 3d0:	00e6c733          	xor	a4,a3,a4
 3d4:	00e7a023          	sw	a4,0(a5)
 3d8:	00000013          	nop
 3dc:	00c12403          	lw	s0,12(sp)
 3e0:	01010113          	addi	sp,sp,16
 3e4:	00008067          	ret
 3e8:	ff010113          	addi	sp,sp,-16
 3ec:	00812623          	sw	s0,12(sp)
 3f0:	01010413          	addi	s0,sp,16
 3f4:	000107b7          	lui	a5,0x10
 3f8:	0007a683          	lw	a3,0(a5) # 0x10000
 3fc:	000107b7          	lui	a5,0x10
 400:	0047a703          	lw	a4,4(a5) # 0x10004
 404:	c0400793          	li	a5,-1020
 408:	00e69733          	sll	a4,a3,a4
 40c:	00e7a023          	sw	a4,0(a5)
 410:	00000013          	nop
 414:	00c12403          	lw	s0,12(sp)
 418:	01010113          	addi	sp,sp,16
 41c:	00008067          	ret
 420:	ff010113          	addi	sp,sp,-16
 424:	00812623          	sw	s0,12(sp)
 428:	01010413          	addi	s0,sp,16
 42c:	000107b7          	lui	a5,0x10
 430:	0007a783          	lw	a5,0(a5) # 0x10000
 434:	00078713          	mv	a4,a5
 438:	000107b7          	lui	a5,0x10
 43c:	0047a783          	lw	a5,4(a5) # 0x10004
 440:	00f75733          	srl	a4,a4,a5
 444:	c0400793          	li	a5,-1020
 448:	00e7a023          	sw	a4,0(a5)
 44c:	00000013          	nop
 450:	00c12403          	lw	s0,12(sp)
 454:	01010113          	addi	sp,sp,16
 458:	00008067          	ret
 45c:	ff010113          	addi	sp,sp,-16
 460:	00812623          	sw	s0,12(sp)
 464:	01010413          	addi	s0,sp,16
 468:	000107b7          	lui	a5,0x10
 46c:	0007a683          	lw	a3,0(a5) # 0x10000
 470:	000107b7          	lui	a5,0x10
 474:	0047a703          	lw	a4,4(a5) # 0x10004
 478:	c0400793          	li	a5,-1020
 47c:	40e6d733          	sra	a4,a3,a4
 480:	00e7a023          	sw	a4,0(a5)
 484:	00000013          	nop
 488:	00c12403          	lw	s0,12(sp)
 48c:	01010113          	addi	sp,sp,16
 490:	00008067          	ret
