
// identificar as classes e arrays
Player player; // chama a classe player
Boy[] boys; // array CAR
Rena[] renas; // array objetos madeira
Lane[] lanes; //  array Linhas do nivel

PImage menuImage; // função que chama a image frame titulo
PImage nivelImage0;
PImage menuImage2;

//-- importa biblioteca de som
import processing.sound.*;
SoundFile music_file;

// Variáveis globais
float grid = 50; // a tela está dividida em grelhas de 50x50
int menu=0;
//int state = 0, int mode = 0;
int SAFETY = 0; // variavel para saber se mata ou não player
int CAR = 1; // mata player
int LOG = 2; // não mata
int avatar=1;
int nolives = 0, lives=4;
PFont f;

Button StartButton;
Button button [];
int t = 0, Mt = 500; // tempo duração da barra =1000
boolean time = false;
//max time (Mt) ten de ser medido com o frameRate o jogo pra saber o tempo em segundos
//FE: 60fps means that one second is 60 frames and if you increase t by one each frame it will take it 60 frames to reach one second t=60 == 1 second

boolean playing = true; // variavel que indica que está a musica a tocar

//volta a colocar player na posição inicial quando colide com os retangulos -------------
void resetGame() {
  player = new Player(width/2-grid/2, height-grid, grid);
  player.attach(null); // desasocia o player da loog
  lives --;
}

void reset() {
  lives = 4;
  t = 0;
  // state = 0;
  // mode = 1;
}

void setup() {
  size(600, 500);
  noStroke();
  noFill();
  frameRate(60);
  resetGame(); //coloca a player no inicio do jogo
  music_file = new SoundFile(this, "inicio.mp3"); // lê ficherio de musica ambiente da paata /data
  music_file.loop();
  loadButton();
  f = createFont("helvetica", 20, true);  //carrega fonte de texto

  StartButton= new Button(205, 150, 100, 50, "Start", 0, 200, 200); // ---------Sidonia

  // chama o array para criar linhas dos obstaculos do vivel
  int totalLanes = int(height / grid);
  lanes = new Lane[totalLanes];
  lanes[0] = new Lane(0, color(100, 0));
  lanes[1] = new Lane(1, color(100, 0));
  lanes[2] = new Lane(2, LOG, 2, 2, 350, -2);
  lanes[3] = new Lane(3, LOG, 3, 2, 200, 1);
  lanes[4] = new Lane(4, LOG, 3, 2, 250, -2);
  lanes[5] = new Lane(5, color(100, 0));
  lanes[6] = new Lane(6, CAR, 4, 1, 100, 2);
  lanes[7] = new Lane(7, CAR, 4, 1, 150, -5);
  lanes[8] = new Lane(8, CAR, 5, 1, 180, 2);
  lanes[9] = new Lane(9, color(100, 0));
}

void draw() {
  background(0);
  // ------------------------------Sidonia
  // switch Funciona como uma estrutura if else, mas alternar é mais conveniente quando você
  //precisa selecionar entre três ou mais alternativas.
  switch(menu) {
  case 0:// Game play
    menu=0;
    menuImage = loadImage("Data/menu.jpg");  // carrega a imagem inicio
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
      menu = 1;
    if (button[1].isClicked())
      menu = 3; // substituir por nivel 2
    if (button[2].isClicked())
      menu=5;
    break;

  case 5: // Escolha dos players
    button[3].update();
    button[3].render();
    button[4].update();
    button[4].render();
    if (button[3].isClicked()) {
      menu=0;
      avatar=1;
    }
    menuImage2=loadImage("data/1.png");
    image(menuImage2, 320, 220);
    if (button[4].isClicked()) {
      menu=0;
      avatar=2;
    }
    menuImage2=loadImage("Data/2.png");
    image(menuImage2, 320, 290);
    break;

  case 1: // level 1
    nivelImage0 = loadImage("Data/nivel0.jpg");  // carrega a imagem fundo nivel
    image(nivelImage0, 0, 0, width, height);
    noStroke();
    //--------------------------------------
    // desenha os inimigos por limha e verfica se o player colide com eles
    for (int i = 0; i < lanes.length; i++) {
      lanes[i].run();
    }
    int laneIndex = int(player.y / grid); // numero inicial do player por linha
    lanes[laneIndex].checkPlayer(player);
    player.update();
    player.show(avatar);  // desemha o player
    displayTime(); // chama função da barra do tempo de jogo

    if (player.y <= 25) { // se jogador chegar ao topo
      menu=3;
    } else if (lives == nolives) {
      menu = 4;
    } else {
      displayLives(lives);
    }
    break;

  case 3: // Quando ganha chama função Win
    winShow();
    reset();
    resetGame();
    StartButton.update();
    StartButton.render();
    if (StartButton.isClicked())
      menu=0;
    break;

  case 4://loose
    loseShow();
    reset();
    resetGame();
    StartButton.update();
    StartButton.render();
    if (StartButton.isClicked())
      menu=0;
    break;
  }
}


void keyPressed() {  // Mover o Player

  if (keyCode == UP) {
    player.move(0, -1);
  } else if (keyCode == DOWN) {
    player.move(0, 1);
  } else if (keyCode == RIGHT) {
    player.move(1, 0);
  } else if (keyCode == LEFT) {
    player.move(-1, 0);
  } else if ((key == 's') || (key == 'S')) { // se percionar a tecla m tecla a musica inicial para
    if (playing) {  // se estiver a tocar
      music_file.stop(); // a musica para
      playing = false; // e pasa a ser falso que a musica está a tocar
    } else {
      music_file.play(); // se voltar a teclar volta a tocar se nda feito continua
      playing = true;
    }
  } else if ((key == 'p') || (key == 'P')) { // Se  percionar a tecla P o jogo para
    if (looping) {  // se estiver a desenhar (void draw)
      noLoop();  // não desenha
    } else {
      loop(); // continua a desenhar
    }
  }
}

//Função mostra vidas
void displayLives(int n) {
  textFont(f, 20);
  fill(255);
  // textSize (15);
  textAlign(LEFT);
  text("Lives left " + n, 20, height-25);
}

void displayTime() {
  //------------------------------------Sidonia
  if (t<Mt && !time) {
    t++;
  }
  if (t == Mt) {
    time = true;
  } else {
    time = false;
  }
  //println(time, t);
  fill(map(t, 0, Mt, 0, 255), map(t, 0, Mt, 255, 0), 0);
  rect(0, height/40, map(t, 0, Mt, 1, width), 20);
  if (player.y <=25) {
    t = 0;
    menu=3;
  }
  if (time)
    menu=4;
}
