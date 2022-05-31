#ifdef _CONSOLE
#include<iostream>
using namespace std;
#define input 0x1926
#define kinput 0b0000000000011111
#define output(x) cout<<hex<<((int)x)<<endl
#define wait 1
#else
#define input *(int*)(0xfffffc00)
#define output(x) *(int*)(0xfffffc04) = x
#define kinput *(int*)(0xfffffc08)
#define wait 0x231860
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
int get_ieee754_signed(unsigned char ch);
int get_ieee754_unsigned(unsigned char ch);
int get_ieee754_sign_val(unsigned char ch);
int getNbits(int start, int end, int raw);

unsigned char arr[4][10];
int n;
int cnt = 0, rnd = 0;

/*
[18:18] write_en
[17:14] idx
[13:12] set
[11:8] ctrl
[7:0] data
*/

int main() {
    n = 4;
    arr[0][0] = 1;
    arr[0][1] = 7;
    arr[0][2] = 2;
    arr[0][3] = 255;

    while (1) {
        cnt++;
        if (cnt >= 0x20000) {
            cnt = 0;
            rnd ^= 1;
        }
        int choice = getNbits(8, 10, input);
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
        else {
            test111();
        }
    }
}

void test000() {
    int w_en = getNbits(18, 18, input);
    int idx = getNbits(13, 16, input);
    int x = getNbits(0, 7, input);
    if (w_en) {
        output(x);
        if (idx == 0b1111) {
            n = x;
        }
        else if (idx < 10) {
            arr[0][idx] = x;
        }
    }
}

void test001() {
    for (int i = 0; i < n; i++) {
        arr[1][i] = arr[0][i];
    }
    unsigned char temp;
    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            if (arr[1][j] > arr[1][j + 1]) {
                temp = arr[1][j];
                arr[1][j] = arr[1][j + 1];
                arr[1][j + 1] = temp;
            }
        }
    }
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < wait; j++) {
            output((i << 16) | arr[1][i]);
        }
    }
}

void test010() {
    for (int i = 0; i < n; i++) {
        arr[2][i] = arr[0][i];
    }
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < wait; j++) {
            output((i << 16) | arr[2][i]);
        }
    }
    for (int i = 0; i < n; i++) {
        if (arr[2][i] & 0b10000000) {
            arr[2][i] = (~(arr[2][i] & 0b01111111)) + 1; // 2's complement
        }
    }
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < wait; j++) {
            output((i << 16) | arr[2][i]);
        }
    }
}

void test011() {
    for (int i = 0; i < n; i++) {
        arr[3][i] = arr[2][i];
    }
    unsigned char temp;
    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            signed char signed_A = (signed char)arr[3][j];
            signed char signed_B = (signed char)arr[3][j + 1];
            if (signed_A > signed_B) {
                temp = arr[3][j];
                arr[3][j] = arr[3][j + 1];
                arr[3][j + 1] = temp;
            }
        }
    }
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < wait; j++) {
            output((i << 16) | arr[3][i]);
        }
    }
}

void test100() {
    int set = getNbits(11, 12, input);
    if (set & 1) { // set == 0b01 || set == 0b11
        output(arr[set][n - 1] - arr[set][0]);
    }
}

void test101() { 
    int set = getNbits(11, 12, input), idx = getNbits(13, 16, input);
    if ((set & 1) && (idx < n)) {
        output(arr[set][idx]);
    }
}

void test110() {
    int set = getNbits(11, 12, input), idx = getNbits(13, 16, input);
    if (set == 0b01) {
        output(get_ieee754_unsigned(arr[set][idx]));
    }
    else if (set & 0b10) { // set == 0b10 || set == 0b11
        output(get_ieee754_signed(arr[set][idx]));
    }
}

void test111() {
    int idx = getNbits(13, 16, input);
    if (rnd) {
        output(get_ieee754_sign_val(arr[0][idx]));
    }
    else {
        output(arr[0][idx]);
    }
}

int get_ieee754_signed(unsigned char ch) {
    if (!ch) return 0;
    if (ch == -128) return 0b110000000; // special judge
    if (ch & 0b10000000) {
        ch = (~ch) + 1;
        return get_ieee754_unsigned(ch) | 0b100000000;
    }
    return get_ieee754_unsigned(ch);
}

int get_ieee754_unsigned(unsigned char ch) {
    if (!ch) return 0;
    int x = 0;
    for (int i = 7; i >= 0; i--) {
        if (ch & (0b1 << i)) {
            x |= ((i + 128) & 0xff); // bias 127, reserved 1
            break;
        }
    }
    return x;
}

int get_ieee754_sign_val(unsigned char ch) {
    if (!ch) return 0;
    int x = 0;
    if (ch & 0b10000000) {
        x |= 0b100000000;
    }
    for (int i = 6; i >= 0; i--) {
        if (ch & (0b1 << i)) {
            x |= ((i + 128) & 0xff); // bias 127, reserved 1
            break;
        }
    }
    return x;
}

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
