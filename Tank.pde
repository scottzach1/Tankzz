class Tank {
 PVector position, turretPosition;
 float angle, maxAngle, turretAngle, power, maxPower, fuel;
 float len, hei;
 color c;
 boolean alive;

 Terrain terrain;
 Health health;
 Shell shell;

 Tank(color c, color tint, Terrain terrain, float x, Shell shell, boolean left) {
  this.position = new PVector(x, terrain.getHeight(x));
  this.terrain = terrain;
  this.shell = shell;
  this.c = color((red(c)*2+red(tint))/3, (green(c)*2+green(tint))/3, (blue(c)*2+blue(tint))/3);
  alive = true;
  health = new Health(6, left);
  len = 0.03 * width;
  hei = 0.02 * height;
  power = 0.005 * width;
  maxPower = 1.5 * power;
  fuel = 100;
  turretAngle = -PI / 2;
  maxAngle = PI / 2.25; // 80 degree incline
 }

 void checkPosition() {
  position.y = terrain.getHeight(position.x);
  angle = terrain.getTheta(position.x, len);
 }

 void showActive() {
  stroke(0);
  strokeWeight(3);
  float middle = position.x + cos(angle) * (len / 2);
  float bottom = position.y - 4 * hei;
  line(middle, bottom, middle, position.y - 6 * hei);
  line(middle, bottom, middle - hei / 2, bottom - hei / 2);
  line(middle, bottom, middle + hei / 2, bottom - hei / 2);

  stroke(0);
  strokeWeight(1);
 }

 void drawActive(color tint) {
  // DRAW FUEL GUAGE
  tint = color((red(tint)+255)/1.5, (green(tint)+255)/1.5, (blue(tint)+255)/1.5);
  rectMode(CORNER);
  fill(tint);
  rect(height / 40, height + height / 40 - height / 10, height / 7.5, height / 20); // Cell of Battery
  rect(height / 40 + height / 7.5, height - height / 20 - height / 100, height / 100, height / 50); // Stub of Battery
  float padding = height / 400;
  if (fuel < 25) fill(color(255, 0, 0)); // Red
  else if (fuel < 75) fill(color(255, 255, 0)); // Yellow
  else fill(color(0, 255, 0)); // Green
  rect(height / 40 + padding, height + height / 40 - height / 10 + padding, (height / 7.5 - padding * 2) * fuel / 100, height / 20 - padding * 2);
  rectMode(CORNER);

  // DRAW ANGLE
  stroke(tint);
  strokeWeight(2);
  float bottom = height + height / 40 - height / 10 + height / 20;
  float center = height / 40 + height / 7.5 + height / 15 + height / 40;
  float powWid = height / 30, powHei = height / 12;
  fill(color(255, 0, 0));
  beginShape();
  vertex(center, bottom);
  vertex(center - powWid, bottom - powHei);
  vertex(center + powWid, bottom - powHei);
  endShape(CLOSE);

  float powValue = (power / maxPower) * powHei;
  line(center - powWid, bottom - powValue, center + powWid, bottom - powValue);

  stroke(0);
  strokeWeight(1);
 }

 void draw() {
  fill(c);
  pushMatrix(); // Translate to tank then rotate to its angle.
    translate(position.x, position.y);
    rotate(angle);
    // println("got here" + angle);
    pushMatrix(); // Translate to the turret.
      translate(len / 2, -hei);
      ellipseMode(CENTER);
      ellipse(0, 0, hei / 2, hei / 2); // Draw turret pivot.
      turretPosition = new PVector(screenX(0, 0), screenY(0, 0));
      rotate(turretAngle);
      rect(0, -hei / 20, len / 3, hei / 10); // Draw the turret.
    popMatrix(); // Pop back to position and angle of tank.
    rect(0, -hei, len, hei); // Draw tank frame;
  popMatrix();
 }

 void fire() {
  if (shell.isActive()) return;
  shell.fire(turretPosition.x, turretPosition.y, angle + turretAngle, power, c);
 }

 boolean takeHit(float landingX, int blastRadius) {
  checkPosition();

  int rightOfTank = (int)(position.x + cos(angle) * len);
  int leftOfTank = (int) position.x;

  int extra = (int)(cos(angle - HALF_PI) * hei); // Calculate overhang
  if (extra > 0) rightOfTank += extra; // Add overhand to relevant size
  else leftOfTank += extra;

  if (landingX > leftOfTank && landingX < rightOfTank) { // Projectile lands within tank.
   if (health.takeHit(2)) alive = false; // returns true if killed
  } else if (landingX + blastRadius > leftOfTank && landingX - blastRadius < rightOfTank) { // Tank within blastRadius
   if (health.takeHit(1)) alive = false; // returns true if killed
  } else return false; // Tank unaffected.
  return true;
 }

 void moveLeft() {
  if (shell.isActive() || fuel <= 0 || position.x <= 0) return; // Do nothing.
  position.x -= 0.001 * width;
  checkPosition();
  if (Math.abs(angle) > maxAngle) position.x += 0.001 * width;
  fuel -= 0.5;
 }

 void moveRight() {
  if (shell.isActive() || fuel <= 0 || position.x + len >= width - 1) return; // Do nothing.
  position.x += 0.001 * width;
  checkPosition();
  if (Math.abs(angle) > maxAngle) position.x -= 0.001 * width;
  fuel -= 0.5;
 }

 void rotateLeft() {
  if (shell.isActive() || turretAngle <= -PI) return;
  turretAngle -= 0.02;
 }

 void rotateRight() {
  if (shell.isActive() || turretAngle >= 0) return;
  turretAngle += 0.02;
 }

 void increasePow() {
  if (shell.isActive() || power >= maxPower) return;
  power += 0.000415 * width;
 }

 void decreasePow() {
  if (shell.isActive() || power <= 0) return;
  power -= 0.000415 * width;
 }
}
