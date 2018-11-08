import java.awt.event.KeyEvent;

Game game;
ControlScreen controls;

void setup() {
  //size(2400, 1600); // 3:2 fixed aspect ratio.
 size(1200, 800);
 frameRate(45);
 controls = new ControlScreen();
 game = new Game();
}

void keyPressed() {
  // Show game controls
 if (controls.active) {
  controls.active = false;
  return;
 } // Show game controls
 if (key == 'h') {
  controls.active = true;
  return;
 } // Hide arrow showing change in player turn.
 if (game.showActive) {
  game.showActive = false;
  } // Reset game.
 if (key == 'r') {
  game = new Game();
  controls.active = true;
  return;
 } // Standard controls
 if (key == 'd' || keyCode == RIGHT) game.active.moveRight();
 if (key == 'a' || keyCode == LEFT) game.active.moveLeft();
 if (key == 'w' || keyCode == UP) game.active.rotateRight();
 if (key == 's' || keyCode == DOWN) game.active.rotateLeft();
 if (key == 'f' || key == ' ') game.active.fire();
 if (key == 'q' || keyCode == KeyEvent.VK_PAGE_UP) game.active.decreasePow();
 if (key == 'e' || keyCode == KeyEvent.VK_PAGE_DOWN) game.active.increasePow();
}

void mousePressed() {
 if (controls.active) { // Clear controls screen.
  controls.active = false;
  return;
 } // Show controls screen.
 if (mouseX > width - width / 15 && mouseY > height - width / 15) {
  controls.active = true;
  return;
 }
}

void draw() { // Display either control screen or game.
 if (controls.active) controls.draw();
 else game.draw();
}
