/* Rectangulo de calculo de colisão dos objetos
 Retirado do Coding Challenge de Daniel Shiffman
 https://www.youtube.com/watch?v=giXV6xErw0Y&ab_channel=TheCodingTrain
 */

class Rectangle {

  float x;
  float y;
  float w;
  float h;

  Rectangle(float x, float y, float w, float h) {

    this.x = x; // this-Refere-se ao objeto atual (ou seja, "este objeto"), que mudará dependendo do contexto em que é referenciado.
    this.w = w;  // https://processing.org/reference/this.html
    this.y = y;
    this.h = h;
  }

  boolean intersects(Rectangle other) { // calcula as intercesões dos rectangulos

    float left = x;
    float right = x + w;
    float top = y;
    float  bottom = y + h;

    float oleft = other.x;
    float oright = other.x + other.w;
    float otop = other.y;
    float obottom = other.y + other.h;

    return !(left >= oright || right <= oleft || top >= obottom || bottom <= otop);
  }
}
