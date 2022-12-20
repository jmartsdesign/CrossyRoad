/* Função do player

*/
class Player extends Rectangle { // extends-Permite que uma nova classe herde os métodos e campos de dados (variáveis ​​e constantes) de uma classe existente.

  Log attached = null; // variavel que vai fazer com que o player acompanhe a log

  Player(float x, float y, float w) {
    super (x, y, w, w);  // super -Palavra-chave usada para referenciar a superclasse de uma subclasse.
  }

  void attach(Log log) { // função que vai fazer com que o player acompanhe a log
    attached = log;
  }

  void update() {  // função para que o player acompanhe a log á mesma velocidade
    if (attached != null) {
      player.x += attached.speed;
    } // faz com que o player quando atinge limite do ecran não o passe e deslize sobre as logs
    player.x = constrain(x,0, width-w); // constrain-Restringe um valor para não exceder um valor máximo e mínimo.
  }

  void show() {
    fill(255,170);
    rect(x, y, w, w);
  }

  void move(float xdir, float ydir) {  // faz mover o retangulo do player
    x += xdir * grid;
    y += ydir * grid;
     x = constrain(x,0,width-grid); // impede o player sair do lados do ecran
    y = constrain(0,y,height-grid*8);  // impede o player de sair da área do ecran em por cima
  }
}
