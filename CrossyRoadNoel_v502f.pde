/*
Projeto final de programação - 2022/2023
Jogo simplificado da variação do Crossy Road
Trabalho elaborado por:
Sidónia Cordeiro    2022173482
Jorge Antunes       2022136207
*/

// Classes e Arrays
Player player;
Obstacl[] obst; // Array com objetos do tipo Obstacl
Lane[] lanes;   // Array linhas do nível
Button StartButton;
Button button [];

PImage menuImage; 
PImage nivelImage0, nivelImage2;
PImage menuImage2;
PImage winImage; 
PImage loseImage;

// Importação da biblioteca de som
import processing.sound.*;
SoundFile music_file;

// Variáveis globais
float grid = 50;    // A tela está dividida em grelhas de 50x50
int menu = 0;
int SAFETY = 0; 
int CAR = 1;                  // Obstáculos "Boy"
int LOG = 2;                  // Obstáculos "Eny"
int avatar = 1;               // Escolher personagem
int levelObst = 1 ;           // Escolher obstáculos por nível
int nolives = 0, lives = 3;   // Número de vidas
int points = 0;               // Pontuação
int hscore = 0;               // Pontuação final
PFont f;
int t = 0, Mt = 500;          // Tempo de cada jogada 500 frames = 8 segundos
boolean time = false;
boolean playing = true;       // Variável de controlo do som


// ResetGame - Função que volta a colocar o jogador na posição inicial quando este colide com os obstáculos
void resetGame() {
  player = new Player(width/2-grid/2, height-grid, grid);
  player.attach(null);                             // Desassocia o jogador dos obtáculos "Eny"
  lives--;
}

// Reset - Função que reinicia o tempo e as vidas
void reset() {
  lives = 4;
  points = 0;
  t = 0;
}

void setup() {
  size(600, 500);
  noStroke();
  noFill();
  frameRate(60);
  resetGame();                                     // Coloca o jogador no início do jogo
  music_file = new SoundFile(this, "inicio.mp3");  // Lê ficheiro de som
  music_file.loop();
  loadButton();
  f = createFont("helvetica", 20, true);  //carrega fonte de texto

  StartButton= new Button(205, 150, 100, 50, "Start", 0, 200, 200);

  // Chama o array para criar linhas dos obstáculos do nível
  int totalLanes = int(height / grid);
  lanes = new Lane[totalLanes];
  lanes[0] = new Lane(0, color(100, 0));
  lanes[1] = new Lane(1, color(100, 0));
  lanes[2] = new Lane(2, LOG, 2, 2, random(150,250), random(-10,10));
  lanes[3] = new Lane(3, LOG, 3, 2, random(200,250), random(-8,8));
  lanes[4] = new Lane(4, LOG, 3, 2, random(180,200), random(-5,5));
  lanes[5] = new Lane(5, color(100, 0));
  lanes[6] = new Lane(6, CAR, 4, 1, random(90,110), random(-3,3));
  lanes[7] = new Lane(7, CAR, 4, 1, random(100,150), random(-3,3));
  lanes[8] = new Lane(8, CAR, 5, 1, random(170,180), random(-1,1));
  lanes[9] = new Lane(9, color(100, 0));
}

void draw() {
  background(0);
  switch(menu) {
  // Menu principal
  case 0:
   reset();
    menu = 0;
    menuImage = loadImage("Data/menu.jpg");    // Carregar a imagem do menu inicial
    image(menuImage, 0, 0, width, height);
    fill(255);
    textSize (15);
    textAlign(LEFT);
    text ("Pause game", 20, height-35);
    text ("Som on/off", 20, height-20);
    button[0].update();
    button[0].render();
    button[1].update();
    button[1].render();
    button[2].update();
    button[2].render();
    if (button[0].isClicked())
      menu = 1; // Nível 1
    if (button[1].isClicked())
      menu = 2; // Nível 2
    if (button[2].isClicked())
      menu = 5;
    break;

  // Escolha dos personagens
  case 5:
    button[3].update();
    button[3].render();
    button[4].update();
    button[4].render();
    if (button[3].isClicked()) {
      menu = 0;
      avatar = 1;
      levelObst = 1;
    }
    menuImage2=loadImage("data/1.png");
    image(menuImage2, 320, 220);
    if (button[4].isClicked()) {
      menu = 0;
      avatar = 2;
      levelObst = 2;
    }
    menuImage2=loadImage("Data/2.png");
    image(menuImage2, 320, 290);
    break;

  // Nível 1
  case 1:
    nivelImage0 = loadImage("Data/nivel0.jpg");
    image(nivelImage0, 0, 0, width, height);
    noStroke();
    // Desenha os obstáculos por linha e verifica se o personagem colide com algum destes
    for (int i = 0; i < lanes.length; i++) {
      lanes[i].run();
    }
    int laneIndex = int(player.y / grid);           // Posição do jogador, por linha
    lanes[laneIndex].checkPlayer(player);
    player.update();
    player.show(avatar);                            // Desenhar personagem
    displayTime();                                  // Função da barra do tempo de jogo
    if (player.y <= 25) {                           // Se o jogador chegar ao topo do cenário
      menu = 3;
    } else if (lives == nolives) {
      menu = 4;
      } else if (points > hscore) {
      hscore = points;
    } else {
      displayLives(lives);
    }
    break;
    
  // Nível 2
  case 2:
    nivelImage2 = loadImage("Data/nivel2.jpg");
    image(nivelImage2, 0, 0, width, height);
    noStroke();
    for (int i = 0; i < lanes.length; i++) {
      lanes[i].run();
    }
    int laneIndexn2 = int(player.y / grid);
    lanes[laneIndexn2].checkPlayer(player);
    player.update();
    player.show(avatar);
    displayTime();
    if (player.y <= 25) {
      menu=3;
    } else if (lives == nolives) {
      menu = 4;
    } else {
      displayLives(lives);
    }
    break;

  // No caso de vitória
  case 3:
    winShow();
    resetGame();
    StartButton.update();
    StartButton.render();
    if (StartButton.isClicked())
      menu=0;
    break;
  
  // No caso de derrota
  case 4:
    loseShow();
    resetGame();
    StartButton.update();
    StartButton.render();
    if (StartButton.isClicked())
      menu=0;
    break;
  }
}


void keyPressed() {
  if (keyCode == UP) {
    player.move(0, -1);
    points = points + 10;
  } else if (keyCode == DOWN) {
    player.move(0, 1);
    points = points - 10;
  } else if (keyCode == RIGHT) {
    player.move(1, 0);
    points = points - 5;
  } else if (keyCode == LEFT) {
    player.move(-1, 0);
    points = points - 5;
  } else if ((key == 's') || (key == 'S')) {       // Controlo da música, através da tecla "s" ou "S"
    if (playing) {                                
      music_file.stop();
      playing = false;
    } else {
      music_file.play();
      playing = true;
    }
  } else if ((key == 'p') || (key == 'P')) {      // Controlo do jogo, através da tecla "p" ou "P"
    if (looping) {
      noLoop();
    } else {
      loop();
    }
  }
}

//Função para mostrar vidas no ecrã
void displayLives(int n) {
  textFont(f, 20);
  fill(255);
  textAlign(LEFT);
  text("Lives left " + n, 20, height-25);
  textAlign(RIGHT);
  text("Points left " + points, width-20, height-25);
}

void displayTime() {
  if (t<Mt && !time) {
    t++;
  }
  if (t == Mt) {
    time = true;
  } else {
    time = false;
  }
  fill(map(t, 0, Mt, 0, 255), map(t, 0, Mt, 255, 0), 0);
  rect(0, height/40, map(t, 0, Mt, 1, width), 20);
  if (player.y <=25) {
    t = 0;
    menu = 3;
  }
  if (time)
    menu = 4;
}

// Função de fim de jogo - Vitória
void winShow() {
  winImage = loadImage("data/win.jpg"); 
  image(winImage, 0, 0, width, height);
  fill(255, 250, 0);
  textSize(70);
  textAlign(CENTER, CENTER);
  text ("YOU WIN!", width/2, height/2);
  fill(255, 150, 0);
  textSize(50);
  text (hscore + " Points", width/2, height/2+60);
  fill(0, 255, 0);
  noStroke();
}

// Função de fim de jogo - Derrota
void loseShow() {
  loseImage = loadImage("data/lose.jpg");
  image(loseImage, 0, 0, width, height);
  fill(255, 250, 0);
  textSize(70);
  textAlign(CENTER, CENTER);
  text ("YOU LOSE!", width/2, height/2);
  fill(255, 150, 0);
  textSize(50);
  text (hscore + " Highscore", width/2, height/2+60);
  fill(0, 255, 0);
  noStroke();
}
