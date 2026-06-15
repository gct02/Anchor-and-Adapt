#ifndef _BF_ENC_H_
#define _BF_ENC_H_

/* If you make this 'unsigned int' the pointer variants will work on
 * the Alpha, otherwise they will not.  Strangly using the '8 byte'
 * BF_LONG and the default 'non-pointer' inner loop is the best configuration
 * for the Alpha */
#define BF_LONG unsigned long

#define BF_ROUNDS 16

#define KEYSIZE 5200
#define N 40

#undef n2l
#define n2l(c,l)        (l =((unsigned long)(*((c)++)))<<24L, \
                         l|=((unsigned long)(*((c)++)))<<16L, \
                         l|=((unsigned long)(*((c)++)))<< 8L, \
                         l|=((unsigned long)(*((c)++))))

#undef l2n
#define l2n(l,c)        (*((c)++)=(unsigned char)(((l)>>24L)&0xff), \
                         *((c)++)=(unsigned char)(((l)>>16L)&0xff), \
                         *((c)++)=(unsigned char)(((l)>> 8L)&0xff), \
                         *((c)++)=(unsigned char)(((l)     )&0xff))

#define BF_ENC(LL,R,S,P) \
	LL^=P; \
	LL^=(((	S[        (R>>24L)      ] + \
		S[0x0100+((R>>16L)&0xff)])^ \
		S[0x0200+((R>> 8L)&0xff)])+ \
		S[0x0300+((R     )&0xff)])&0xffffffff;

void BF_set_key (int len, unsigned char *data);
void BF_encrypt (BF_LONG *data);
void BF_cfb64_encrypt (unsigned char *in, unsigned char *out, unsigned char *ivec);

/* Top-level function */
void blowfish_main (unsigned char indata[N], unsigned char outdata[N]);

#endif // _BF_ENC_H_