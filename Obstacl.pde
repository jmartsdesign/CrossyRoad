// log - madeira
class Obstacl extends Rectangle {

  PImage playerImage, playerImage1; // função que chama a image frame do player
  PImage playerImageB, playerImageB1;
  PImage playerImageC, playerImageC1;
  PImage playerImageD, playerImageD1;
  float speed;

  Obstacl(float x, float y, float w, float h, float s) {
    super (x, y, w, h);  // super -Palavra-chave usada para referenciar a superclasse de uma subclasse.
    speed = s;
    playerImage = loadImage("Data/Rena1.png");  // carrega a imagem do player
    playerImage1 = loadImage("Data/Rena2.png");  // carrega a imagem do player
    playerImageB = loadImage("Data/Boy1.png");  // carrega a imagem do player
    playerImageB1 = loadImage("Data/Boy2.png");  // carrega a imagem do player
    playerImageC = loadImage("Data/EnyR1.png");
    playerImageC1 = loadImage("Data/EnyR2.png");
    playerImageD = loadImage("Data/Eny1.png");
    playerImageD1 = loadImage("Data/Eny2.png");
  }

  void update() {
    x = x + speed;
    if (speed > 0 && x > width+grid) { // o carro chega ao final do lado direito e volta a aparecer no esquerdo e faz o inverso
      x = -w-grid; // delay de atraso para voltar a aparecer
    } else if (speed < 0 && x < -w-grid) {  // faz o oposto pois continua do lado direito para o esquerdo
      x = width+grid;
    }
  }

  void show(int type, int lObst) {
    // rect(x, y, w, h);
    if (lObst == 1) {
      if (type == CAR) {
        if (speed < 0) { // desenha a imagem do player em sentido oposto caso movimento negativo
          image(playerImageB1, x, y, w, h);
        } else {
          image(playerImageB, x, y, w, h);  // desenha a imagem do player num quadrado
        }
      } else if (type == LOG) {
        if (speed < 0) { // desenha a imagem do player em sentido oposto caso movimento negativo
          image(playerImage1, x, y, w, h);
        } else {
          image(playerImage, x, y, w, h);  // desenha a imagem do player num quadrado
        }
      }
    } else if (lObst == 2) {
      if (type == CAR) {
        if (speed < 0) { // desenha a imagem do player em sentido oposto caso movimento negativo
          image(playerImageC1, x, y, w, h);
        } else {
          image(playerImageC, x, y, w, h);  // desenha a imagem do player num quadrado
        }
      } else if (type == LOG) {
        if (speed < 0) { // desenha a imagem do player em sentido oposto caso movimento negativo
          image(playerImageD1, x, y, w, h);
        } else {
          image(playerImageD, x, y, w, h);  // desenha a imagem do player num quadrado
        }
      }
    }
  }
}
