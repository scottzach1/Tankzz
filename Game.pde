class Game {
 Terrain terrain; // Deals with the randomly generated terrain.
 Tank left, right, active; // Left and Right tank are unique. Active is used as a pointer to the active tank.
 int leftWinCount, rightWinCount; // Just a counter for how many kills each team has.
 Shell shell; // The projectile shot from the tanks in the game.
 boolean showActive; // When true, will place an arrow above the tank who's turn it is.
 PFont font; // Used to display player name and kill count on the screen.
 CloudController clouds;
 color c;

 Game() {
  leftWinCount = 0;
  rightWinCount = 0;
  reset();
 }

 void reset() {
   c = color(random(50) + 100, random(50), random(150));
  terrain = new Terrain(c); // Generate a new map
  clouds = new CloudController(3, c);
  shell = new Shell(terrain, clouds.wind);
  left = new Tank(color(255, 255, 0), c, terrain, width * 0.25, shell, true);
  right = new Tank(color(255, 0, 255), c, terrain, width * 0.75, shell, false);
  shell.giveTanks(left, right); // Initialise all objects first to avoid null pointer exception. Not elegant.
  left.checkPosition();
  right.checkPosition();
  active = left;
  showActive = true;
 }


 void draw() {
  background(c);

  terrain.draw();
  left.draw();
  right.draw();
  if (showActive) active.showActive();

  if (shell.step()) { // step() returns true if shell has detonated: playerswitch.
   if (active == left) active = right;
   else active = left;
   showActive = true;
   if (!left.alive && !right.alive) { // EDGE CASE, both dies, reset.
     reset();
     return;
   }
   if (!left.alive) { // If left dies, reset.
    rightWinCount++;
    reset();
    active = left;
    return;
   }
   if (!right.alive) { // If right dies, reset.
    leftWinCount++;
    reset();
    active = right;
    return;
   }
  }
  shell.draw();
  clouds.draw();
  displayUI();
 }

 void displayUI() {
  displayScore();
  active.drawActive(c);
  left.health.draw();
  right.health.draw();
  drawCloud(height / 2.75, height - height / 20, 25);
  drawGear(width - height / 30, height - height / 30, width / 30);
 }

 void displayScore() {
   fill(0);
   font = createFont("Arial", height / 40, true);
   textFont(font);
   textAlign(LEFT);
   text("Player 1\nkills " + leftWinCount, height / 60, height / 10);
   textAlign(RIGHT);
   text("Player 2\nkills " + rightWinCount, width - height / 60, height / 10);
   fill(color(255, 255, 0));
   text(round(frameRate), width - height / 30 - height / 30, height - height / 50);
 }

 void drawGear(float x, float y, float diameter) {
  translate(x, y);
  ellipseMode(CENTER);
  strokeWeight(diameter / 10);
  noFill();
  stroke(color(255, 255, 0));
  ellipse(0, 0, diameter / 2 - diameter / 7.5, diameter / 2 - diameter / 7.5);
  fill(color(255, 255, 0));
  noStroke();
  rectMode(CENTER);
  for (int tooth = 0; tooth < 8; tooth++, rotate(TWO_PI / 8))
   rect(0, -diameter / 4, diameter / 9, diameter / 15);
  stroke(0);
  strokeWeight(1);
  rectMode(CORNER);
 }

 void drawCloud(float x, float y, float size) {
  pushMatrix();
  translate(x, y);
  fill((red(c)+255)/1.5, (green(c)+255)/1.5, (blue(c)+255)/1.5);
  noStroke();
  ellipse(size, 0, size, size);
  ellipse(-size, 0, size, size);
  ellipse(size - 0.75 * size, -0.1 * size, 1.75 * size, 1.75 * size);
  ellipse(-size / 1.5, -size / 2, size / 1.5, size / 1.5);
  ellipse(-size / 2, size / 2.5, size / 1.5, size / 1.5);
  font = createFont("Arial", height / 40, true);
  textFont(font);
  textAlign(CENTER);
  fill(0);
  text(round(clouds.wind * 100), -height / 150, height / 150);
  popMatrix();
 }
}
