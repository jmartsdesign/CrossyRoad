// Função que cria os botões e calcula a posição do rato para clicar

class Button {
  PVector Pos = new PVector (0, 0);
  float Width=0;
  float Height=0;
  color Colour;
  String Text;
  Boolean Pressed = false;
  Boolean Clicked = false;

  // Construtor para criar o botão
  Button ( int x, int y, int w, int h, String T, int r, int g, int b) {
    Pos.x=x;
    Pos.y=y;
    Width=w;
    Height=h;
    Colour=color (r, g, b);
    Text=T;
  }
  
  void update() {
    if (mousePressed == true && mouseButton == LEFT && Pressed == false) {
      Pressed= true;
      if (mouseX>= Pos.x && mouseX <= Pos.x+Width && mouseY >= Pos.y && mouseY <= Pos.y+Height) {
        Clicked= true;
      }
    } else {
      Clicked = false;
    }
    if (mousePressed != true) {
      Pressed = false;
    }
  }
  
  void render () {
    fill(Colour);
    rect(Pos.x, Pos.y, Width, Height,20);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(18);
    text(Text, Pos.x+(Width/2), Pos.y+(Height/2));
  }
  
  boolean isClicked() {
    return Clicked;
  }
}

void loadButton() {
  button = new Button [5];
  button[0] = new Button(205, 220, 100, 50, "Level 1", 0, 200, 200);
  button[1] = new Button(205, 290, 100, 50, "Level 2", 0, 200, 200);
  button[2] = new Button(205, 360, 100, 50, "Players", 0, 200, 200);
  button[3] = new Button(205, 220, 100, 50, "Player 1", 0, 200, 200);
  button[4] = new Button(205, 290, 100, 50, "Player 2", 0, 200, 200);
}
