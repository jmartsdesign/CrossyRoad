class Lane extends Rectangle {

  Obstacl[] obst;
  color laneColor;
  int type;

  Lane(int rowNum, color c) {
    super(0, rowNum * grid, height, grid);
    type = SAFETY;
    obst = new Obstacl[0];
    laneColor = c;
  }

  Lane(int rowNum, int t, int obAmount, int len, int spacing, int speed) {
    super(0, rowNum * grid, height, grid);
    obst = new Obstacl[obAmount];
    type = t;
    int offset = (int) random(20, 200);
    for (int i = 0; i < obAmount; i++) {
      obst[i] = new Obstacl(offset + spacing * i, rowNum * grid, grid * len, grid, speed);
    }
    laneColor = color(100, 0);
  }

  void show() {
    //   fill(laneColor);
    //   rect(x, y, this.w, this.h);
  }

  void run() {
    for (int i = 0; i < obst.length; i++) {
      obst[i].show(type, levelObst);
      obst[i].update();
    }
  }

  void checkPlayer(Player player) {

    if (type == CAR) {
      for (int i = 0; i < obst.length; i++) {
        if (player.intersects(obst[i])) {
          resetGame();
        }
      }
    } else if (type == LOG) {
      boolean ok = false;
      for (int i = 0; i < obst.length; i++) {
        if (player.intersects(obst[i])) {
          ok = true;
          player.attach(obst[i]);
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
