#define PCx
#ifdef PC
#include<iostream>
using namespace std;
#define input 0b0000000000011111
#define kinput 0b0000000000011111
#define output(x) cout<<x<<endl
#else
#define input *(int*)(0xfffffc00)
#define output(x) *(int*)(0xfffffc04) = x
#define kinput *(int*)(0xfffffc08)
#endif
#define false 0
#define true 1

void test000();
void test001();
void test010();
void test011();
void test100();
void test101();
void test110();
void test111();
int getNbits(int start, int end, int raw);

int A = 0xdeadbeef;
int B = 0xcafebabe;
int flag_not_switch = false;

int main() {
	while (1) {
		int choice = getNbits(16, 18, input);
		if (choice == 0b000) {
			test000();
		}
		else if (choice == 0b001) {
			test001();
		}
		else if (choice == 0b010) {
			test010();
		}
		else if (choice == 0b011) {
			test011();
		}
		else if (choice == 0b100) {
			test100();
		}
		else if (choice == 0b101) {
			test101();
		}
		else if (choice == 0b110) {
			test110();
		}
		else{
			test111();
		}
	}
}

/**
* return bits form start(include) to end(include)
* index start from 0
* e.g. getNbits(16, 18) returns bits {18,17,16}
*/
int getNbits(int start, int end, int raw) {
	int mask = 1;
	for (int i = 0; i < end - start; i++) {
		mask <<= 1;
		mask |= 1;
	}
	for (int i = 0; i < start; i++) {
		mask <<= 1;
	}
	int res = raw & mask;
	res >>= start;
	return res;
}

void test000() {
	int a = input;
	int len = 0;
	while (a) {
		len++;
		a >>= 1;
	}
	a = input;
	while (len-->0) {
		int hi = (a >> len);
		hi &= 1;
		int lo = a & 1;

		if (hi != lo) {
			output(input);
			return;
		}
		a >>= 1;
		len--;
	}
	int res = input;
	res |= 0b10000000000000000;
	output(res);
}

void test001() {
	int k = kinput;
	if (getNbits(0, 15, input)) {
		flag_not_switch = false;
	}
	if (k >> 4 && !flag_not_switch) { // keyboard not pressed
		if (getNbits(19, 19, input)) {
			A = getNbits(0, 15, input);
			output(A);
		}
		else if (getNbits(20, 20, input)) {
			B = getNbits(0, 15, input);
			output(B);
		}
	}
	else if (k >> 4 == 0) { // keyboard
		flag_not_switch = true;
		int offset = getNbits(21, 23, input);
		offset <<= 2;
		int mask = 0xf << offset;
		mask &= A;
		A ^= mask;
		if (getNbits(19, 19, input)) {
			A |= (k << offset);
			output(A);
		}
		else if (getNbits(20, 20, input)) {
			B |= (k << offset);
			output(B);
		}
	}
}

void test010() {
	output((A & B));
}

void test011() {
	output((A | B));
}

void test100() {
	output((A ^ B));
}

void test101() {
	output((A << B));
}

void test110() {
	output(((unsigned int)A >> B));
}

void test111() {
	output((A >> B));
}
