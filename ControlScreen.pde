public class ControlScreen {
 String message = "Game Controls:\n Left / Right : Drive        \n       Up / Down : Adjust Turret \n    PG Up / PG Down : Adjust Shot Power \n Space : Fire  \n   R : Reset\n\n Press Any Key to Continue...";
 PFont font;
 boolean active;

 ControlScreen() { active = true; }

 void draw() {
  background(color(171, 196, 171));
  fill(0);
  textAlign(CENTER);
  font = createFont("Arial", (width + height) / 20, true);
  textFont(font);
  text("Tankzz", width / 2, height / 5);
  font = createFont("Arial", (width + height) / 40, true);
  textFont(font);
  textLeading((width + height) / 30);
  text(message, width / 2, height / 3);
 }
}
