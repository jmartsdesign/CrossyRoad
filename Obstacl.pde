class Obstacl extends Rectangle {

  PImage playerImage, playerImage1;
  PImage playerImageB, playerImageB1;
  PImage playerImageC, playerImageC1;
  PImage playerImageD, playerImageD1;
  float speed;

  Obstacl(float x, float y, float w, float h, float s) {
    super (x, y, w, h);
    speed = s;
    playerImage = loadImage("Data/Rena1.png");  
    playerImage1 = loadImage("Data/Rena2.png"); 
    playerImageB = loadImage("Data/Boy1.png");  
    playerImageB1 = loadImage("Data/Boy2.png");
    playerImageC = loadImage("Data/EnyR1.png");
    playerImageC1 = loadImage("Data/EnyR2.png");
    playerImageD = loadImage("Data/Eny1.png");
    playerImageD1 = loadImage("Data/Eny2.png");
  }

  void update() {
    x = x + speed;
    if (speed > 0 && x > width+grid) {        // O obstáculo chega ao final do lado direito e volta a aparecer no esquerdo e vice-versa
      x = -w-grid;                            // Delay de atraso para voltar a aparecer
    } else if (speed < 0 && x < -w-grid) {  
      x = width+grid;
    }
  }

  void show(int type, int lObst) {
    if (lObst == 1) {
      if (type == CAR) {
        if (speed < 0) {                      // Desenha a imagem do player no sentido oposto caso movimento negativo
          image(playerImageB1, x, y, w, h);
        } else {
          image(playerImageB, x, y, w, h);    // Desenha a imagem do player num quadrado
        }
      } else if (type == LOG) {
        if (speed < 0) {              
          image(playerImage1, x, y, w, h);
        } else {
          image(playerImage, x, y, w, h);
        }
      }
    } else if (lObst == 2) {
      if (type == CAR) {
        if (speed < 0) { 
          image(playerImageD, x, y, w, h);
        } else {
          image(playerImageD1, x, y, w, h); 
        }
      } else if (type == LOG) {
        if (speed < 0) { 
          image(playerImageC, x, y, w, h);
        } else {
          image(playerImageC1, x, y, w, h);
        }
      }
    }
  }
}
