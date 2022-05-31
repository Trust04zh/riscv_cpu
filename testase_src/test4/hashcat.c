#ifdef _CONSOLE
#include<iostream>
using namespace std;
#define input 0x1926
#define kinput 0b0000000000011111
#define output(x) cout<<hex<<(x)<<endl
#define wait 1
#else
#define input *(int*)(0xfffffc00)
#define output(x) *(int*)(0xfffffc04) = x
#define kinput *(int*)(0xfffffc08)
#define wait 0x231860
#endif
#define false 0
#define true 1


#define SHFR(x, n) (((x) >> (n)))
#define ROTR(x, n) (((x) >> (n)) | ((x) << ((sizeof(x) << 3) - (n))))
#define ROTL(x, n) (((x) << (n)) | ((x) >> ((sizeof(x) << 3) - (n))))
#define CHX(x, y, z) (((x) &  (y)) ^ (~(x) & (z)))
#define MAJ(x, y, z) (((x) &  (y)) ^ ( (x) & (z)) ^ ((y) & (z)))
#define BSIG0(x) (ROTR(x,  2) ^ ROTR(x, 13) ^ ROTR(x, 22))
#define BSIG1(x) (ROTR(x,  6) ^ ROTR(x, 11) ^ ROTR(x, 25))
#define SSIG0(x) (ROTR(x,  7) ^ ROTR(x, 18) ^ SHFR(x,  3))
#define SSIG1(x) (ROTR(x, 17) ^ ROTR(x, 19) ^ SHFR(x, 10))

int main() {
    while (1) {
        int goal = input;
        for (unsigned int current = 0;; current++) {
            unsigned int k[64];
            k[0] = 1116352408;
            k[1] = 1899447441;
            k[2] = 3049323471;
            k[3] = 3921009573;
            k[4] = 961987163;
            k[5] = 1508970993;
            k[6] = 2453635748;
            k[7] = 2870763221;
            k[8] = 3624381080;
            k[9] = 310598401;
            k[10] = 607225278;
            k[11] = 1426881987;
            k[12] = 1925078388;
            k[13] = 2162078206;
            k[14] = 2614888103;
            k[15] = 3248222580;
            k[16] = 3835390401;
            k[17] = 4022224774;
            k[18] = 264347078;
            k[19] = 604807628;
            k[20] = 770255983;
            k[21] = 1249150122;
            k[22] = 1555081692;
            k[23] = 1996064986;
            k[24] = 2554220882;
            k[25] = 2821834349;
            k[26] = 2952996808;
            k[27] = 3210313671;
            k[28] = 3336571891;
            k[29] = 3584528711;
            k[30] = 113926993;
            k[31] = 338241895;
            k[32] = 666307205;
            k[33] = 773529912;
            k[34] = 1294757372;
            k[35] = 1396182291;
            k[36] = 1695183700;
            k[37] = 1986661051;
            k[38] = 2177026350;
            k[39] = 2456956037;
            k[40] = 2730485921;
            k[41] = 2820302411;
            k[42] = 3259730800;
            k[43] = 3345764771;
            k[44] = 3516065817;
            k[45] = 3600352804;
            k[46] = 4094571909;
            k[47] = 275423344;
            k[48] = 430227734;
            k[49] = 506948616;
            k[50] = 659060556;
            k[51] = 883997877;
            k[52] = 958139571;
            k[53] = 1322822218;
            k[54] = 1537002063;
            k[55] = 1747873779;
            k[56] = 1955562222;
            k[57] = 2024104815;
            k[58] = 2227730452;
            k[59] = 2361852424;
            k[60] = 2428436474;
            k[61] = 2756734187;
            k[62] = 3204031479;
            k[63] = 3329325298;
            unsigned int w[64];
            unsigned int a0, b1, c2, d3, e4, f5, g6, h7;
            unsigned int t1, t2;

            //{ "xxxx876DCFB05CB167A524953EB" }
            w[0] = current;
            w[1] = 0x38373644;
            w[2] = 0x43464230;
            w[3] = 0x35434231;
            w[4] = 0x36374135;
            w[5] = 0x32343935;
            w[6] = 0x33454280;
            int i = 0;
            for (i = 7; i < 15; i++) {
                w[i] = 0;
            }
            w[15] = 216;
            for (i = 16; i < 64; i++) {
                w[i] = SSIG1(w[i - 2]) + w[i - 7] + SSIG0(w[i - 15]) + w[i - 16];
            }

            unsigned int h[8];
            h[0] = 0x6a09e667;
            h[1] = 0xbb67ae85;
            h[2] = 0x3c6ef372;
            h[3] = 0xa54ff53a;
            h[4] = 0x510e527f;
            h[5] = 0x9b05688c;
            h[6] = 0x1f83d9ab;
            h[7] = 0x5be0cd19;
            a0 = h[0];
            b1 = h[1];
            c2 = h[2];
            d3 = h[3];
            e4 = h[4];
            f5 = h[5];
            g6 = h[6];
            h7 = h[7];

            for (i = 0; i < 64; i++) {
                t1 = h7 + BSIG1(e4) + CHX(e4, f5, g6) + k[i] + w[i];
                t2 = BSIG0(a0) + MAJ(a0, b1, c2);

                h7 = g6;
                g6 = f5;
                f5 = e4;
                e4 = d3 + t1;
                d3 = c2;
                c2 = b1;
                b1 = a0;
                a0 = t1 + t2;
            }

            h[0] += a0;
            h[1] += b1;
            h[2] += c2;
            h[3] += d3;
            h[4] += e4;
            h[5] += f5;
            h[6] += g6;
            h[7] += h7;
            if ((h[0] >> 16) == goal) {
                output(current);
                break;
            }
        }
    }
}