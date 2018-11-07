class Terrain {

 float[] ground = new float[width];
 float maxHeight; // Speed up calculations.
 color c;

 Terrain(color tint) { // a, b, c, d are randomly generated seeds for terrain generation.
  float noise = 0.011;
  float a = random(0.10 * height, 0.12 * height); // amplitude
  float b = random(noise);
  float c = random(noise);
  float d = random(noise);

  for (int x = 0; x < width; x++)
   ground[x] = height * 5 / 8 + a * sin(b * x + sin(c * x) + sin(d * x));

  this.c = color(red(tint)/4, green(tint)/4, blue(tint)/4);
 }

 void draw() {
  fill(c);
  beginShape();
  vertex(width, height);
  vertex(0, height);
  for (int x = 0; x < width; x++) vertex(x, ground[x]);
  endShape(CLOSE);
 }

 float getHeight(float x) { // Edge Detection.
  if (x < 0) x = 0;
  if (x > width - 1) x = width - 1;
  return ground[(int) x];
 }

 float getTheta(float x1, float len) {
  float x = x1 - 1; // - 1, check do while
  float distance = 0;
  do { // Keep increasing right side of take until distance between 2 points (in 2d) is equal to length of tank.
   x ++;
   distance = dist(x, getHeight(x), x1, getHeight(x1));
  } while (distance < len);
  float angle = asin((getHeight(x) - getHeight(x1)) / len);
  if (Double.isNaN(angle)) angle = asin((getHeight(x) - getHeight(x1)) / distance);
  return angle;
 }

 void terraform(float x, int blastRadius) {
  int targetX = (int) x;
  float targetY = getHeight(targetX); // have to precalculate (just debug and shoot lol)

  for (int distance = -blastRadius; distance <= blastRadius; distance++) {
   float newHeight = targetY + sqrt(blastRadius * blastRadius - distance * distance);
   if (targetX + distance >= 0 && targetX + distance < width) // within boundaries
    if (ground[targetX + distance] < newHeight) ground[targetX + distance] = newHeight;
  }
 }
}
