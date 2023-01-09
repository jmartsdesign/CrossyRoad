// Parte 3 - https://www.youtube.com/watch?v=hk326ZHlENQ

class Boy extends Rectangle {
  PImage playerImage; // função que chama a image frame do player
  PImage playerImage1; // função que chama a image frame do player
  float speed;
  Boy(float x, float y, float w, float h, float s) {
    super (x, y, w, h);  // super -Palavra-chave usada para referenciar a superclasse de uma subclasse.
    speed = s;
    playerImage = loadImage("Data/Boy1.png");  // carrega a imagem do player
    playerImage1 = loadImage("Data/Boy2.png");  // carrega a imagem do player
  }

  void update() {
    x = x + speed;
    if (speed > 0 && x > width+grid) { // o carro chega ao final do lado direito e volta a aparecer no esquerdo e faz o inverso
      x = -w-grid; // delay de atraso para voltar a aparecer
    } else if (speed < 0 && x < -w-grid) {  // faz o oposto pois continua do lado direito para o esquerdo
      x = width+grid;
    }
  }

  void show() {
    //fill(200);
    // rect(x, y, w, h);
    //    image(playerImage,x, y, w, h);  // desenha a imagem do player num quadrado
    if (speed < 0) { // desenha a imagem do player em sentido oposto caso movimento negativo
      image(playerImage1, x, y, w, h);
    } else {
      image(playerImage, x, y, w, h);
    }
  }
}
