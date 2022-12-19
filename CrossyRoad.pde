//https://www.youtube.com/watch?v=06-ZvYmSeus&ab_channel=TheCodingTrain

// identificar as classes e arrays
Player player;
// Car car;  // chama função car
Car[] cars; // array CAR
Log[] logs; // array objetos madeira

// Variáveis globais
float grid = 50; // a tela está dividida em grelhas de 50x50

void resetGame() {   //volta a colocar player na posição inicial quando colide com os retangulos
  player = new Player(width/2-grid/2, height-grid, grid);
  player.attach(null); // desasocia o player da loog
}

void setup() {
  size(500, 500);
  resetGame(); //coloca a player no inicio do jogo

  // Estrada -----
  int index = 0; // numero inicial de carros na linha
  cars = new Car[8]; // numero de carro nas estradas
  // ROW 1 (estrada, linha 1)
  for (int i = 0; i < 2; i++) { // desenha 2 carros por estrada(linha)
    //   float x = i * 100 + 50;
    float x = i * 300;
    cars[index] = new Car (x, height-grid*2, grid*2, grid, 2);
    index++;
  }
  // ROW 2 (estrada, linha 2)
  for (int i = 0; i < 2; i++) { // desenha 2 carros por estrada(linha)
    float x = i * 200 + 150; // espaço entre carros
    cars[index] = new Car (x, height-grid*3, grid, grid, -3.5); // carro no sentido contrário
    index++;
  }
  // ROW 3 (estrada, linha 3)
  for (int i = 0; i < 4; i++) { // desenha 4 carros por estrada(linha)
    float x = i * 150 + 25;
    cars[index] = new Car (x, height-grid*4, grid, grid, 1.2);
    index++;
  }
  // Rio-----
  logs = new Log [7]; // numero de logs no rio
  index = 0; // numero inicial de logs na linha
  // ROW 5 (rio, linha 5 porque a quatro é o passeio)
  for (int i = 0; i < 2; i++) { // desenha 2 carros por estrada(linha)
    float x = i * 250 + 100; // espaço entre logs
    logs[index] = new Log (x, height-grid*6, grid*3, grid, 2.3);
    index++;
  }
  // ROW 6 (rio, linha 6 porque a quatro é o passeio)
  for (int i = 0; i < 3; i++) { // desenha 2 carros por estrada(linha)
    float x = i * 200 + 30; // espaço entre logs
    logs[index] = new Log (x, height-grid*7, grid*2, grid, -1.3);
    index++;
  }
  // ROW 7 (rio, linha 7 porque a quatro é o passeio)
  for (int i = 0; i < 2; i++) { // desenha 2 carros por estrada(linha)
    float x = i * 400 + 10; // espaço entre logs
    logs[index] = new Log (x, height-grid*8, grid*4, grid, 0.5);
    index++;
  }
}

void draw() {
  background(0);
  fill(255, 100);
  rect(0, 0, width, grid*2); // desenha a barra da chegada
  rect(0, height-grid, width, grid); // desenha a barra (passeio) de inicio
  rect(0, height-grid*5, width, grid); // desenha 2 passeio depois da ROW 3
  for (Car car : cars) {  // desenha os carros seguidos
    car.show();
    car.update();
    if (player.intersects(car)) { // se player colide com retangulos volta á sua posição inicial
      resetGame();
      //   println("Game Over");
    }
  }
  for (Log log : logs) {  // desenha as tabuas seguidas
    log.show();
    log.update();
  }
  if (player.y < height-grid*5 && player.y > grid*2) {
    //background(255,0,0); // teste para saber quando o player não acerta os logs
    boolean ok = false;
    for (Log log : logs) {
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
  }
}
