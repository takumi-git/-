/* 
 A program to simulate the quality of JPEG compression
 Prima, O.D.A.
 */

PImage img, img_gray, img_compressed; //<>//
float[][] dct_buf, new_quant;    // Declare array
int quality = 50;                // Quality of image (default = 50)
PFont f;                          //Declare PFont variable

// Quantization table
int[][] quant = { 
  {16, 12, 14, 14, 18, 24, 49, 72}, 
  {11, 12, 13, 17, 22, 35, 64, 92}, 
  {10, 14, 16, 22, 36, 55, 78, 95}, 
  {16, 19, 24, 29, 56, 64, 87, 98}, 
  {24, 26, 40, 51, 68, 81, 103, 112}, 
  {40, 58, 57, 87, 109, 104, 121, 100}, 
  {51, 60, 69, 80, 103, 113, 120, 103}, 
  {61, 55, 56, 62, 77, 92, 101, 99} };
  //求める配列
float [][]quant1={
 {16, 11, 10, 16, 24, 40, 51, 61},
 {12, 12, 14, 19, 26, 58, 60, 55},
 {14, 13, 16, 24, 40, 57, 69, 56},
 {14, 17, 22, 29, 51, 87, 80, 62},
 {18, 22, 37, 56, 68, 109, 103, 77},
 {24, 35, 55, 64, 81, 104, 113, 92},
 {49, 64, 78, 87, 103, 121, 120, 101},
 {72, 92, 95, 98, 112, 100, 103, 99}};

int threshold = 128; // 2値化の閾値

void setup() {

  // Prepare images
  img = loadImage("lenna.jpg");
  img_gray = new PImage(img.width, img.height);
  img_compressed = new PImage(img.width, img.height);

  // Create Font
  f = createFont("Arial", 16, true); 

  // Create 8x8 arrays
  dct_buf = new float[8][8];
  quant1 = new float[8][8];

  // Create canvas
  surface.setSize(img.width*2, img.height);

  // Convert the input image into a grayscale image
  convert2gray();

  // Compress the input image
  compress();
}

void draw() {
  image(img, 0, 0);
  image(img_compressed, img.width, 0);
  fill(255);
  rect(0, 0, 420, 20);
  textFont(f, 16);                  // Specify font to be used
  fill(0);                         // Specify font color 
  text("Quality: " + quality + " (press up/down arrow to increase/decrease)", 10, 15);   // Display Text
}

// Image compression
void compress() {
  create_quant();
  for (int y=0; y<img.height/8; y++) {
    for (int x=0; x<img.width/8; x++) {
      dct_calculate(x*8, y*8);
      quantize();
      idct(x*8, y*8);
    }
  }
}

// Convert the image to gray
void convert2gray() {
  for (int i = 0; i < img_gray.width*img_gray.height; i++) {
    color pix = img.pixels[i];
    img_gray.pixels[i] = (int)(0.299*red(pix) + 0.587*green(pix) + 0.114*blue(pix));
  }
}

// Create an arbritary quantization matrix
void create_quant()
{
  float a;
  if(quality < 50){
    a = 5000/quality;//
  } else{
      a = 200 - 2 * quality;//
  }
 // Hint: create a new "quant matrix" here!
 for (int y=0;y<8;y++){
   for(int x=0;x<8;x++){
     quant1[y][x] =round((a * quant[x][y] + 50)/100);
   }
 }
}

// DCT
void dct_calculate(int xpos, int ypos)
{
  float Cu, Cv, z;

  for (int v=0; v<8; v++) {
    for (int u=0; u<8; u++) {

      z = 0.0;

      // coefficient
      if (u == 0) Cu = 1.0 / sqrt(2.0); 
      else Cu = 1.0;
      if (v == 0) Cv = 1.0 / sqrt(2.0); 
      else Cv = 1.0;

      for (int y=0; y<8; y++) {
        for (int x=0; x<8; x++) {
          double s, q;
          s = img_gray.pixels[(y+ypos)*img_gray.width + (x+xpos)];
          q = s * cos((float)(2*x+1) * (float)u * PI/16.0) *
            cos((float)(2*y+1) * (float)v * PI/16.0);
          z += q;
        }
      }
      dct_buf[v][u] = 0.25 * Cu * Cv * z;
    }
  }
}

// Quantization using Q-table
void quantize()
{
  for (int y=0; y<8; y++) {
    for (int x=0; x<8; x++) {

      // Hint: replace the "quant matrix" with yours.  
      //       Use the variable "quality" to define the new matrix

      int tmp = (int) (dct_buf[y][x]/quant1[y][x] + 0.5); 
      dct_buf[y][x] = (float)(1.0*tmp*quant1[y][x]);
    }
  }
}

void idct(int xpos, int ypos)
{
  float S, q;
  float Cu, Cv;
  float z;

  for (int y=0; y<8; y++) for (int x=0; x<8; x++)
  {
    z = 0.0;
    for (int v=0; v<8; v++) for (int u=0; u<8; u++)
    {
      // coefficient
      if (u == 0) Cu = 1.0 / sqrt(2.0); 
      else Cu = 1.0;
      if (v == 0) Cv = 1.0 / sqrt(2.0); 
      else Cv = 1.0;

      S = dct_buf[v][u];
      q = Cu * Cv * S *
        cos((float)(2*x+1) * (float)u * PI/16.0) *
        cos((float)(2*y+1) * (float)v * PI/16.0);
      z += q;
    }
    z /= 4.0;
    if (z > 255.0) z = 255.0;
    if (z < 0) z = 0.0;

    img_compressed.set(x+xpos, y+ypos, color(z, z, z));
  }
}

void keyPressed() {

  if (key == CODED) {
    if (keyCode == UP) {
      if (quality <= 90) {
        quality += 10;
        compress();
      }
    } else if (keyCode == DOWN) {
      if (quality >= 10) {
        quality -= 10;
        compress();
      }
    }
  }
}
