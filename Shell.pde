class Shell {
 PVector position, velocity, gravity;
 int blastRadius;
 float radius;
 boolean active;
 color c;

 Tank left, right;
 Terrain terrain;

 Shell(Terrain ter, float wind) {
  this.terrain = ter;
  blastRadius = (int)(0.02 * height);
  radius = 0.00625 * height;
  gravity = new PVector(wind / 50, 0.0001 * height);
  active = false;
 }

 void giveTanks(Tank left, Tank right) {
  this.left = left;
  this.right = right;
 }

 void fire(float x, float y, float angle, float power, color c) {
  this.position = new PVector(x, y);
  this.velocity = new PVector(cos(angle) * power, sin(angle) * power);
  this.c = c;
  active = true;
 }

 Boolean isActive() {
  return active;
 }

 Boolean step() {
  if (!active) return false;
  position.add(velocity);
  velocity.add(gravity);
  if (position.x < -blastRadius || position.x >= width + blastRadius) { // Shell went out of bounds, switch turn.
   active = false;
   return true;
  }
  if (position.y < terrain.maxHeight) return false; // Speed up calculations
  if (position.y >= terrain.getHeight(position.x)) { // Shell hit ground, switch turn.
   left.takeHit(position.x, blastRadius); // Apply damage to tank
   right.takeHit(position.x, blastRadius); // Apply damage to tank
   terrain.terraform(position.x, blastRadius); // Terraform terrain.
   left.checkPosition(); // Update new tank position.
   right.checkPosition();
   active = false;
   return true;
  }
  return false;
 }

 void draw() {
  if (active) {
   fill(c);
   ellipseMode(CENTER);
   ellipse(position.x, position.y, radius, radius);
  }
 }
}
