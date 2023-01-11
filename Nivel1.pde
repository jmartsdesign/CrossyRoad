// função desenha nivel 1

// codigo inicial antes de ser classe e array

 /*   fill(255, 100);
   rect(0, 0, width, grid*2); // desenha a barra da chegada
 rect(0, height-grid, width, grid); // desenha a barra (passeio) de inicio
    rect(0, height-grid*5, width, grid); // desenha 2 passeio depois da ROW 3
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
     if (player.y < height-grid*5 && player.y > grid) {
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
     
     */

void nivelShow() {

  // Estrada -----
  int index = 0; // numero inicial de carros na linha
  boys = new Boy[9]; // numero de carro nas estradas
  // ROW 1 (estrada, linha 1)
  for (int i = 0; i < 2; i++) { // desenha 2 carros por estrada(linha)
    //   float x = i * 100 + 50;
    float x = i * 300;
    boys[index] = new Boy (x, height-grid*2, grid, grid, 2);
   index++;
  }
  // ROW 2 (estrada, linha 2)
  for (int i = 0; i < 3; i++) { // desenha 2 carros por estrada(linha)
    float x = i * 200 + 150; // espaço entre carros
    boys[index] = new Boy (x, height-grid*3, grid, grid, -3.5); // carro no sentido contrário
   index++;
  }
  // ROW 3 (estrada, linha 3)
  for (int i = 0; i < 4; i++) { // desenha 4 carros por estrada(linha)
    float x = i * 150 + 25;
    boys[index] = new Boy (x, height-grid*4, grid, grid, 1.2);
    index++;
  }
  // Rio-----
  renas = new Rena [7]; // numero de logs no rio
  index = 0; // numero inicial de logs na linha
  // ROW 5 (rio, linha 5 porque a quatro é o passeio)
  for (int i = 0; i < 2; i++) { // desenha 2 carros por estrada(linha)
    float x = i * 250 + 100; // espaço entre logs
    renas[index] = new Rena (x, height-grid*6, grid*2, grid, 2.3);
    index++;
  }
  // ROW 6 (rio, linha 6 porque a quatro é o passeio)
  for (int i = 0; i < 3; i++) { // desenha 2 carros por estrada(linha)
    float x = i * 200 + 30; // espaço entre logs
    renas[index] = new Rena (x, height-grid*7, grid*2, grid, -1.3);
    index++;
  }
  // ROW 7 (rio, linha 7 porque a quatro é o passeio)
  for (int i = 0; i < 2; i++) { // desenha 2 carros por estrada(linha)
    float x = i * 400 + 10; // espaço entre logs
    renas[index] = new Rena (x, height-grid*8, grid*2, grid, 4);
    index++;
  }
}
