/* Rectangulo de calculo de colisão dos objetos
 Esta função é a que calcula as colisões entre o player e os obstaculos
 Retirado do Coding Challenge de Daniel Shiffman
 https://www.youtube.com/watch?v=giXV6xErw0Y&ab_channel=TheCodingTrain
 */

class Rectangle {
  float x;
  float y;
  float w;
  float h;

  Rectangle(float x, float y, float w, float h) {
    this.x = x;
    this.w = w;
    this.y = y;
    this.h = h;
  }

  boolean intersects(Rectangle other) {   // Cálcula as intercessões dos rectângulos
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
