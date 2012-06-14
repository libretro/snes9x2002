#ifdef __cplusplus
extern "C" {
#endif

extern unsigned short int disk_img[];
void Draw16x16Image(unsigned short *Screen, int x, int y, unsigned short *Img);
void Draw16x16Square(unsigned short *Screen, int x, int y, unsigned char r, unsigned char g, unsigned char b);


#ifdef __cplusplus
}
#endif
