
class Player extends Rectangle { // extends-Permite que uma nova classe herde os métodos e campos de dados (variáveis ​​e constantes) de uma classe existente.

  Obstacl attached = null; // variavel que vai fazer com que o player acompanhe a log
  PImage playerImage; // função que chama a image frame do player
  PImage playerImage1;

  Player(float x, float y, float w) {
    super (x, y, w, w);  // super -Palavra-chave usada para referenciar a superclasse de uma subclasse.
    playerImage = loadImage("data/NoelPlayer.png");  // carrega a imagem do player
    playerImage1 = loadImage("data/2.png");
  }

  void attach(Obstacl obst) { // função que vai fazer com que o player acompanhe a log
    attached = obst;
  }

  void update() {  // função para que o player acompanhe a log á mesma velocidade
    if (attached != null) {
      player.x += attached.speed;
    } // faz com que o player quando atinge limite do ecran não o passe e deslize sobre as logs
    player.x = constrain(x, 0, width-w); // constrain-Restringe um valor para não exceder um valor máximo e mínimo.
  }

  void show(int ava) { // função com argumento
    //fill(255,170);
    //rect(x, y, w, w);
    if (ava == 1) {
      image(playerImage, x, y, this.w, this.w);  // desenha a imagem do player num quadrado
    } else {
      image(playerImage1, x, y, this.w, this.w);
    }
  }

  void move(float xdir, float ydir) {  // faz mover o retangulo do player
    x += xdir * grid;
    y += ydir * grid;
    x = constrain(x, 0, width-w); // impede o player sair do lados do ecran
    y = constrain(y, 0, height-h);  // impede o player de sair da área do ecran em por cima
  }
}
