
//https://www.youtube.com/watch?v=06-ZvYmSeus&ab_channel=TheCodingTrain

// identificar as classes e arrays
Player player;
// Car car;  // chama função car
Boy[] boys; // array CAR
Rena[] renas; // array objetos madeira
Lane[] lanes; //  array Linhas do nivel

PImage menuImage; // função que chama a image frame titulo
PImage nivelImage0;

//-- importa biblioteca de som
import processing.sound.*;
SoundFile music_file;
// adicionar ficheiro de som
//String audioName ="data/game-sound.wave";
//String path;

// Variáveis globais
float grid = 50; // a tela está dividida em grelhas de 50x50

// ---------------------------------Sidonia
int menu=0;
int state = 0;
int mode = 0;
int SAFETY = 0; // variavel para saber se mata ou não player
int CAR = 1; // mata player
int LOG = 2; // não mata

int FINISH_LIVES = 0;
int lives = 6;
PFont f;

/*
 0 menu
 1 game play
 2 end game */
Button StartButton;
Button button [];
int t, Mt = 3000;
boolean time=false;
//max time (Mt) ten de ser medido com o frameRate o jogo pra saber o tempo em segundos
//FE: 60fps means that one second is 60 frames and if you increase t by one each frame it will take it 60 frames to reach one second t=60 == 1 second
// ----------------------------------------------Sidonia
boolean playing = true; // variavel que indica que está a musica a tocar

//volta a colocar player na posição inicial quando colide com os retangulos -------------
void resetGame() {
  player = new Player(width/2-grid/2, height-grid, grid);
  player.attach(null); // desasocia o player da loog
}

void setup() {
  size(600, 500);
  noStroke();
  noFill();
  f = createFont("helvetica", 20, true);  //carrega fonte de texto
  loadButton(); // ---------Sidonia
  frameRate(60); // ---------Sidonia
  reset();  // reset();
  resetGame(); //coloca a player no inicio do jogo

  // lê ficherio de musica ambiente da paata /data
  music_file = new SoundFile(this, "inicio.mp3");
  //  file.play();
  music_file.loop();

  StartButton= new Button(205, 150, 100, 50, "Start", 0, 200, 200); // ---------Sidonia

  // nivelShow(); // Chama o nivel 1

  // chama o array para criar linhas dos obstaculos do vivel
  int totalLanes = int(height / grid);
  lanes = new Lane[totalLanes];
  lanes[0] = new Lane(0, color(100, 0));
  lanes[1] = new Lane(0, color(100, 0));
  lanes[2] = new Lane(2, LOG, 2, 3, 350, -2);
  lanes[3] = new Lane(3, LOG, 4, 1, 200, 1);
  lanes[4] = new Lane(4, LOG, 3, 2, 250, -2);
  lanes[5] = new Lane(5, color(100, 0));
  lanes[6] = new Lane(6, CAR, 3, 1, 150, 2);
  lanes[7] = new Lane(7, CAR, 2, 2, 150, -3);
  lanes[8] = new Lane(8, CAR, 1, 3, 150, 2);
  //  lanes[9] = new Lane(9, CAR, 4, 1, 150, -1);
  lanes[9] = new Lane(10, color(100, 0));
}

// ---------Sidonia
void reset() {
  state = 0;
  mode = 1;
}
// ---------Sidonia

void draw() {
  background(0);
  // ------------------------------Sidonia
  switch(menu) {
  case 0:// Game play
    menuImage = loadImage("Data/menu.jpg");  // carrega a imagem inicio
    image(menuImage, 0, 0, width, height);
    fill(255);
    textSize (15);
    textAlign(LEFT);
    text ("Pause game", 20, height-35);
    text ("Som on/off", 20, height-20);
    StartButton.update();
    StartButton.render();
    button[0].update();
    button[0].render();
    button[1].update();
    button[1].render();
    if (StartButton.isClicked())
      menu=1;
    if (button[0].isClicked())
      menu =1;
    if (button[1].isClicked())
      menu= 3;
    break;

  case 1: // level 1   // ------------------------------------Sidonia
    nivelImage0 = loadImage("Data/nivel0.jpg");  // carrega a imagem fundo nivel
    image(nivelImage0, 0, 0, width, height);
    // player
    noStroke();

    // desenha os inimigos por limha e verfica se o player colide com eles
    for (int i = 0; i < lanes.length; i++) {
      lanes[i].run();
    }
    int laneIndex = int(player.y / grid);
    //   fill(0, 0, 0, 0);
    //   rect(0, 0, width, height);
    lanes[laneIndex].checkPlayer(player);

    player.update();
    player.show();  // desemha o player
 //   displayLives();
 //   displayFinished();

    // verifica as vidas
    if (lives <= FINISH_LIVES) {
      displayFinished();
    } else {
      displayLives();
    }
    // chega ao final ganha
    if (player.y <= 25) // se jogador chegar ao topo
      winShow(); // chama função do fim de nivel

    displayLives();

    //------------------------------------Sidonia
    if (t<Mt && !time)
      t++;
    if (t==Mt)
      time=true;
    else
      time=false;
    //  println(time, t);
    fill(map(t, 0, Mt, 0, 255), map(t, 0, Mt, 255, 0), 0);
    rect(0, height/40, map(t, 0, Mt, 1, width), 20);

    break;

    //-------------------------------------------------------------------------------------------------
  case 3: // level 2
    // player
    fill(255, 100);
    rect(0, 0, width, grid*4); // desenha a barra da chegada
    rect(0, height-grid, width, grid); // desenha a barra (passeio) de inicio
    rect(0, height-grid*8, width, grid); // desenha 2 passeio depois da ROW 3
    for (Boy boy : boys) {  // desenha os carros seguidos
      boy.show();
      boy.update();
      if (player.intersects(boy)) { // se player colide com retangulos volta á sua posição inicial
        resetGame();
        //   println("Game Over");
      }
    }
    for (Rena log : renas) {  // desenha as tabuas seguidas
      log.show();
      log.update();
    }
    if (player.y < height-grid*7 && player.y > grid*4) {
      //background(255,0,0); // teste para saber quando o player não acerta os logs
      boolean ok = false;
      for (Rena log : renas) {
        if (player.intersects(log)) {
          ok = true;
          player.attach(log); // adiciona o player á log
        }
      }
      if (!ok) {
        resetGame();
      }
    } else {  // faz com que o player deixe de acompamhar os logs quando desde para o passeio (safe zone)
      player.attach(null);
    }
    player.update();
    player.show();  // desemha o player
    break;
    // ------------------------------------Sidonia
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
void displayLives() {
  textFont(f, 20);
  fill(255);
  // textSize (15);
  textAlign(LEFT);
  text("Lives left " + lives, 20, height-25);
}

// Função fim de vida
void displayFinished() {
  textFont(f, 20);
  fill(0);
  textAlign(CENTER);
  text("GAME OVER", width/2, height-25);
}
