// função fim de jogo
PImage loseImage; // função que chama a image frame do player

void loseShow() {

  loseImage = loadImage("data/lose.jpg");  // carrega a imagem do player
  image(loseImage, 0, 0, width, height);
  fill(255, 250, 0);
  textSize(70);
  textAlign(CENTER, CENTER);
  text ("YOU LOSE!", width/2, height/2);
  fill(0, 255, 0);
  noStroke();
}
