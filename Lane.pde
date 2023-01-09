class Lane extends Rectangle {

  Rena[] renas;
  color laneColor;
  int type;

  Lane(int rowNum, color c) {
    super(0, rowNum * grid, height, grid);
    type = SAFETY;
    renas = new Rena[0];
    laneColor = c;
  }

  Lane(int rowNum, int t, int obAmount, int len, int spacing, int speed) {
    super(0, rowNum * grid, height, grid);
    renas = new Rena[obAmount];
    type = t;
    int offset = (int) random(20, 200);
    for (int i = 0; i < obAmount; i++) {
      renas[i] = new Rena(offset + spacing * i, rowNum * grid, grid * len, grid, speed);
    }
    laneColor = color(100,0);
  }

  void show() {
  //  fill(laneColor);
  //  rect(x, y, this.w, this.h);
  }

  void run() {
    show();
    for (int i = 0; i < renas.length; i++) {
      renas[i].show();
      renas[i].update();
    }
  }

  void checkPlayer(Player player) {
    if (type == CAR) {
      for (int i = 0; i < renas.length; i++) {
        if (player.intersects(renas[i])) {
          resetGame();
        }
      }
    } else if (type == LOG) {
      boolean ok = false;
      for (int i = 0; i < renas.length; i++) {
        if (player.intersects(renas[i])) {
          ok = true;
          player.attach(renas[i]);
        }
      }
      if (!ok) {
        resetGame();
      }
     } else {  // faz com que o player deixe de acompamhar os logs quando desde para o passeio (safe zone)
      player.attach(null);
    }
  }

}
