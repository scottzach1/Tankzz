class Health {
  int halfLives;
  int pxSize = width/400, spacing = width/200;
  int [][] fullHeart, halfHeart;
  boolean isLeft;

  Health(int halfLives, boolean isLeft){
    this.halfLives = halfLives;
    this.isLeft = isLeft;
    fullHeart =  new int[][]{
      { 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 0 },
      { 0, 1, 2, 2, 2, 2, 1, 0, 1, 2, 2, 2, 2, 1, 0 },
      { 1, 2, 2, 3, 3, 2, 2, 1, 2, 2, 2, 2, 2, 2, 1 },
      { 1, 2, 3, 3, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1 },
      { 1, 2, 3, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1 },
      { 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1 },
      { 0, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 0 },
      { 0, 0, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 0, 0 },
      { 0, 0, 0, 1, 2, 2, 2, 2, 2, 2, 2, 1, 0, 0, 0 },
      { 0, 0, 0, 0, 1, 2, 2, 2, 2, 2, 1, 0, 0, 0, 0 },
      { 0, 0, 0, 0, 0, 1, 2, 2, 2, 1, 0, 0, 0, 0, 0 },
      { 0, 0, 0, 0, 0, 0, 1, 2, 1, 0, 0, 0, 0, 0, 0 },
      { 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 }};

      halfHeart =  new int[][]{
        { 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 0 },
        { 0, 1, 2, 2, 2, 2, 1, 0, 1, 0, 0, 0, 0, 1, 0 },
        { 1, 2, 2, 3, 3, 2, 2, 1, 0, 0, 0, 0, 0, 0, 1 },
        { 1, 2, 3, 3, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 1 },
        { 1, 2, 3, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 1 },
        { 1, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 1 },
        { 0, 1, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 1, 0 },
        { 0, 0, 1, 2, 2, 2, 2, 2, 0, 0, 0, 0, 1, 0, 0 },
        { 0, 0, 0, 1, 2, 2, 2, 2, 0, 0, 0, 1, 0, 0, 0 },
        { 0, 0, 0, 0, 1, 2, 2, 2, 0, 0, 1, 0, 0, 0, 0 },
        { 0, 0, 0, 0, 0, 1, 2, 2, 0, 1, 0, 0, 0, 0, 0 },
        { 0, 0, 0, 0, 0, 0, 1, 2, 1, 0, 0, 0, 0, 0, 0 },
        { 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 }};
      }

      boolean takeHit(int damage) {
        halfLives -= damage;
        println(halfLives);
        return halfLives <= 0;
      }

      void draw() {
        rectMode(CORNER);
        noStroke();
        int[][] heart = fullHeart;
        int row, col;

        for (int life = 0; life <= halfLives / 2; life++) {
          if (life*2 + 1 == halfLives) heart = halfHeart; // Gets last half heart.
          else if ((life+1)*2 > halfLives) break; // Heart is drawn.

          for (row=0; row < heart.length; row++ ) {
            for (col=0; col < heart[row].length; col++) {
              if      (heart[row][col] == 0) continue; // Transparent
              else if (heart[row][col] == 1) fill(0);  // Black
              else if (heart[row][col] == 2) fill(color(255, 0, 0)); // Red
              else if (heart[row][col] == 3) fill(255); // White
              if (isLeft) rect(life*pxSize*heart[row].length + (life+1)*spacing + col*pxSize, spacing + row*pxSize, pxSize, pxSize);
              else rect(width - (life*pxSize*heart[row].length + (life+1)*spacing + ((heart[row].length-1)-col)*pxSize), spacing + row*pxSize, pxSize, pxSize);
            }
          }
        }
        stroke(0);
      }
    }
