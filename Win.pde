// função fim de jogo
PImage winImage; // função que chama a image frame do player

void winShow() {

  winImage = loadImage("data/win.jpg");  // carrega a imagem do player
  image(winImage, 0, 0, width, height);
  fill(255, 250, 0);
  textSize(70);
  //   noLoop();
  textAlign(CENTER, CENTER);
  text ("YOU WIN!", width/2, height/2);
  fill(0, 255, 0);
  noStroke();
}
