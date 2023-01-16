// Clase que cria e gere o player

class Player extends Rectangle {

  Obstacl attached = null;        // Variável que vai fazer com que o player acompanhe o obstáculo do tipo "Eny"
  PImage playerImage;       
  PImage playerImage1;

  Player(float x, float y, float w) {
    super (x, y, w, w); 
    playerImage = loadImage("data/NoelPlayer.png");
    playerImage1 = loadImage("data/2.png");
  }

  void attach(Obstacl obst) {     // Função que vai fazer com que o player acompanhe o obstáculo do tipo "Eny"
    attached = obst;
  }

  void update() {                 // Função para que o player acompanhe a log à mesma velocidade
    if (attached != null) {
      player.x += attached.speed;
    }                                    // Faz com que o player, quando atinge o limite do ecrã não o passe e deslize sobre o obstáculo do tipo "Eny"
    player.x = constrain(x, 0, width-w); // Restringe um valor para não exceder um valor máximo e mínimo
  }

  void show(int ava) {
    if (ava == 1) {
      image(playerImage, x, y, this.w, this.w); 
    } else {
      image(playerImage1, x, y, this.w, this.w);
    }
  }

  void move(float xdir, float ydir) {  // Faz mover o retangulo do player
    x += xdir * grid;
    y += ydir * grid;
    x = constrain(x, 0, width-w);      // Impede o player sair do lados do ecrã
    y = constrain(y, 0, height-h);     // Impede o player de sair da área do ecrã em baixo
  }
}
