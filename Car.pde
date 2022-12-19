// Parte 3 - https://www.youtube.com/watch?v=hk326ZHlENQ

class Car extends Rectangle {
  float speed;
  Car(float x, float y, float w, float h, float s) {
    super (x, y, w, h);  // super -Palavra-chave usada para referenciar a superclasse de uma subclasse.
    speed = s;
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
    fill(200);
    rect(x, y, w, h);
  }
}
