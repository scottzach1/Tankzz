class Cloud {
 float x, y, size, speed;
 color c;

 Cloud(float speed, color tint) {
  this.speed = speed;

  x = random(-width, width);
  if (speed < 0 && x < 0) x += width;
  y = random(height / 20, height / 4);

  size = random(20, 30);
  float grey = random(120, 150);
  c = color((red(tint)+grey)/2, (green(tint)+grey)/2, (blue(tint)+grey)/2);
 }

 void step() {
  x += speed;

  if (x > width + width/6 && speed > 0) {
      x = -random(width);
      y = random(height / 20, height / 4);
  }
  else if (x < 0 - width/6 && speed < 0) {
      x = width + random(-width, width);
      y = random(height / 20, height / 4);
  }
 }

 void show() {
  rectMode(CENTER);
  noStroke();
  pushMatrix();
    translate(x, y);
      pushMatrix(); // Draw Outline
      scale(1.05);
      fill(0);
      draw();
    popMatrix();
    fill(c);
    draw(); // Draw center
  popMatrix();
  rectMode(CORNER);
  strokeWeight(1);
  stroke(0);
 }

 void draw() {
  ellipse(size, 0, size, size);
  ellipse(-size, 0, size, size);
  ellipse(size - 0.75 * size, -0.1 * size, 1.75 * size, 1.75 * size);
  ellipse(-size / 1.5, -size / 2, size / 1.5, size / 1.5);
  ellipse(-size / 2, size / 2.5, size / 1.5, size / 1.5);
 }
}
