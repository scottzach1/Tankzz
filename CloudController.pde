class CloudController {

 Cloud[] clouds;
 float wind;

 CloudController(int nClouds, color tint) {
  clouds = new Cloud[nClouds];
  this.wind = random(width / 6000.0, width / 2000.0);
  if (random(1.0) < 0.5) wind = -wind; // Coin Toss
  for (int i = 0; i < nClouds; i++) clouds[i] = new Cloud(wind, tint);
}

 void draw() {
  fill(150);
  for (Cloud cloud : clouds) {
   cloud.step();
   cloud.show();
  }
 }

}
